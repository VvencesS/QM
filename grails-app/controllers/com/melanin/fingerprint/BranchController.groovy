package com.melanin.fingerprint

import grails.converters.JSON

class BranchController {
    def melaninLogService

    def index() {}

    // BRANCH MANAGEMENT ----------------
    def branch = {
        render view: '/m-melanin-fingerprint/m-melanin-fingerprint-branch'
        if (params.msg) {
            flash.message = params.msg
        }
    }

    def branchTree = {
        println "${actionUri}: " + new Date() + ": " + params
        def tree = []
        def rootNodes = Branch.createCriteria().list {
            isNull('parent')
            or {
                isNull('status')
                ne('status', '-1')
            }
        }
        rootNodes.each { tree << findSubBranchesAsJson(it) }
        render tree as JSON
    }

    private def findSubBranchesAsJson(def branch) {
        def currentNode = [data: branch.name, attr: [id: branch.id, code: branch.code]]
        def children = []
        def childTemp = Branch.createCriteria().list {
            eq('parent', branch)
            or {
                isNull('status')
                ne('status', '-1')
            }
            order('name', 'asc')
        }

        childTemp.each {
            if (it.status == null || it.status != '-1')
                children << findSubBranchesAsJson(it)
        }
        currentNode['children'] = children
        return currentNode
    }

    def findBranch = {
        println "${actionUri}: " + new Date() + ": " + params
        def result = [:]
        def branch = Branch.get(params.id)
        def divCC = g.render(template: '/templates/table_ds_user', model: [branchid: params.id])
        result << [branch: branch]
        result << [users: branch.users]
        result << [divCC: divCC]
        render result as JSON
    }

    def findAllUserInBranch() {
        println "${actionUri}: " + new Date() + ": " + params
        def divCC = g.render(template: '/templates/table_ds_user', model: [branchid: params.branchid])
        render(text: [success: true, divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def saveBranch = {
        println "${actionUri}: " + new Date() + ": " + params
        if (params.id) {
            redirect action: 'editBranch', params: params
            return
        } else {
            int level = 0
            if (params["parent.id"]) {
                def pbranch = Branch.get(params["parent.id"])
                level = pbranch.get(params["parent.id"]).level.toInteger() + (1).toInteger()
            }

            if (Branch.findByCodeAndStatusIsNull(params.code)) {
                redirect(action: 'branch', params: [msg: "error;Th??ng b??o;M?? chi nh??nh kh??ng ???????c tr??ng !;toast-top-right"])
                return
            } else if (Branch.findByNameAndStatusIsNull(params.name)) {
                redirect(action: 'branch', params: [msg: "error;Th??ng b??o;T??n ????n v??? kh??ng ???????c tr??ng !;toast-top-right"])
                return
            } else {
                def branch = new Branch()
                branch.name = params.name
                branch.code = params.code
                branch.shortname = params.shortname
                String active = params.active
                if (active == 'true' || active.equals('true')) {
                    branch.active = true
                } else {
                    branch.active = false
                }
                if (params["parent.id"]) {
                    branch.parent = branch.get(params["parent.id"])
                    branch.level = branch.get(params["parent.id"]).level.toInteger() + (1).toInteger()
                } else {
                    branch.level = 0
                    branch.parent = null
                }
                def listBranch = []
                if (branch.children) {
                    listBranch << branch
                    while (listBranch) {
                        def listchildBranch = []
                        listBranch.each { Branch childB ->
                            childB.children.each { Branch childB2 ->
                                childB2.level = childB.level + 1
                                childB2.save(flush: true)
                                listchildBranch << childB2
                            }
                        }
                        listBranch = listchildBranch
                    }
                }
                render branch.save(flush: true)
                flash.message = "success;Th??ng b??o;Th??m chi nh??nh th??nh c??ng!;toast-top-right"
            }
        }
    }

    def editBranch = {
        println "${actionUri}: " + new Date() + ": " + params
        def branch = Branch.get(params.id)
        branch.name = params.name
        def a1 = Branch.findByCodeAndStatusIsNull(params.code)
        def a2 = Branch.findByNameAndStatusIsNull(params.name)
        if (a1 && branch.id != a1.id) {
            redirect(action: 'branch', params: [msg: "error;Th??ng b??o;M?? chi nh??nh kh??ng ???????c tr??ng !;toast-top-right"])
            return
        } else if (a2 && branch.id != a2.id) {
            redirect(action: 'branch', params: [msg: "error;Th??ng b??o;T??n ????n v??? ???? t???n t???i !;toast-top-right"])
            return
        } else {
            branch.code = params.code
            branch.shortname = params.shortname
            String active = params.active
            if (active == 'true' || active.equals('true')) {
                branch.active = true
            } else {
                if (branch.canbedeleted) {
                    if (!branch.children) {
                        branch.active = false
                    } else {
                        redirect(action: 'branch', params: [msg: "error;L???i!;Kh??ng th??? inactive chi nh??nh n??y !;toast-top-right"])
                        return
                    }
                } else {
                    redirect(action: 'branch', params: [msg: "error;L???i!;Kh??ng th??? inactive chi nh??nh n??y !;toast-top-right"])
                    return
                }
            }
            if (params["parent.id"]) {
                branch.parent = branch.get(params["parent.id"])
                branch.level = branch.get(params["parent.id"]).level.toInteger() + (1).toInteger()
            } else {
                branch.level = 0
                branch.parent = null
            }
            def listBranch = []
            if (branch.children) {
                listBranch << branch
                while (listBranch) {
                    def listchildBranch = []
                    listBranch.each { Branch childB ->
                        childB.children.each { Branch childB2 ->
                            childB2.level = childB.level + 1
                            childB2.save(flush: true)
                            listchildBranch << childB2
                        }
                    }
                    listBranch = listchildBranch
                }
            }
            render branch.save(flush: true)
            flash.message = "success;Th??ng b??o;C???p nh???t th??ng tin chi nh??nh th??nh c??ng!;toast-top-right"
        }
    }

    def deleteBranch = {
        println "${actionUri}: " + new Date() + ": " + params
        def brid = params.id
        def branch = Branch.get(params.id)
        if (brid == '1' || brid == '2' || brid == '3' || branch.level == 0 || branch.level == 1) {
            redirect action: 'branch'
            flash.message = "error;Th??ng b??o;Kh??ng ???????c x??a (1 trong c??c) ????n v??? sau: LPB/ Mi???n B???c/ Mi???n Nam!;toast-top-right"
        } else {
            if (branch.children) {
                redirect action: 'branch'
                flash.message = "error;Th??ng b??o;Kh??ng th??? x??a chi nh??nh l?? cha c???a chi nh??nh kh??c!;toast-top-right"
            } else {
                if (!branch.canbedeleted) {
                    redirect action: 'branch'
                    flash.message = "error;Th??ng b??o;B???n ghi n??y ???? ph??t sinh quan h??? d??? li???u, kh??ng th??? x??a!;toast-top-right"
                } else {
                    branch.status = '-1'
                    def listBranch = []
                    if (branch.children) {
                        listBranch << branch
                        while (listBranch) {
                            def listchildBranch = []
                            listBranch.each { Branch childB ->
                                childB.children.each { Branch childB2 ->
                                    childB2.status = '-1'
                                    childB2.save(flush: true)
                                    listchildBranch << childB2
                                }
                            }
                            listBranch = listchildBranch
                        }
                    }
                    branch.save(flush: true)
                    redirect action: 'branch'
                    flash.message = "success;Th??ng b??o;X??a th??ng tin chi nh??nh th??nh c??ng!;toast-top-right"
                }
            }
        }
    }

    def addUserToBranch = {
        println "${actionUri}: " + new Date() + ": " + params
        def user = User.get(params.id)
        def branch = Branch.get(params.branch.toLong())

        if (branch.users.contains(user)) {
            render(text: [success: false, msg: "User ???? thu???c chi nh??nh r???i!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } else if (user.branch) {
            render(text: [success: false, msg: "User n??y ??ang thu???c 1 chi nh??nh kh??c!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } else {
            branch.addToUsers(user)
            branch.canbedeleted = false
            branch.save(flush: true)
            def divCC = g.render(template: '/templates/div_addrow_uinb', model: [rs: user])
            render(text: [success: true, user: user, divCC: divCC, msg: "Th??m user v??o chi nh??nh th??nh c??ng!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
        }
    }

    def removeUserFromBranch = {
        println "${actionUri}: " + new Date() + ": " + params
        def user = User.get(params.id)
        def branch = Branch.get(params.branch.toLong())
        println "branch.users = " + branch.users
        if (branch.users.contains(user)) {
            branch.users.remove(user)
            branch.save(flush: true)
            user.branch = null
            user.save(flush: true)

            flash.message = "success;Th??ng b??o;X??a user kh???i chi nh??nh th??nh c??ng!;toast-top-right"
            render 1
            return
        }
        render '-1'
    }

    def removeUserFromBranch_new = {
        println "${actionUri}: " + new Date() + ": " + params
        def user = User.get(params.id)
        def branch = Branch.get(params.branch.toLong())

        if (user.branch.id == branch.id) {
            user.branch = null
            user.save(flush: true)
            flash.message = "success;Th??ng b??o;X??a user kh???i chi nh??nh th??nh c??ng!;toast-top-right"
            render 1
            return
        }
        render '-1'
    }

    def searchUser = {
        def users = User.findAllByFullnameLikeOrUsernameLike(params.term + "%", params.term + "%", [max: 20, sort: 'fullname'])
        render users as JSON
    }

    def checkform() {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            melaninLogService.savelog(request, "${actionUri}", "${params}", "checkform", null)
        } catch (Exception e) {
            throw e
            melaninLogService.savelog(request, "${actionUri}", "${params}", "checkform", e)
        }
    }

    private savelog(String actionname, Exception e) {
        if (!e) {
            melaninLogService.savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", "", "", "${actionUri}", "")
        } else {
            melaninLogService.savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", "", e?.getMessage() + " || " + e?.class, "${actionUri}", "ERROR")
//            log.error("${request.remoteUser} || ${actionUri} || ${params} || ${request.remoteAddr} ||" + e.stackTrace)
        }
    }
}
