package com.melanin.fingerprint

import com.melanin.commons.Conf
import com.melanin.commons.LoginCheckingController
import com.melanin.commons.MenuItem
import com.melanin.security.*
import grails.converters.JSON
import org.grails.web.json.JSONArray
import serversidetable.ServerSideMelaninService
import serversidetable.SqlConnectionService

import java.util.regex.Pattern

class FingerprintController extends LoginCheckingController {
    def melaninLogService
    def springSecurityService
    def dataSource
    def commonService
    def cookieService
    def index = { render view: '/m-melanin-fingerprint/m-melanin-fingerprint' }

    // Menu Item --------------
    def menuItem = { render view: '/m-melanin-fingerprint/m-melanin-fingerprint-menuItem' }

    def saveMenuItem() {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("saveMenuItem", null)
            MenuItem.withTransaction { status ->
                try {
                    if (params.idz) {
                        def mn = MenuItem.get(params.idz)
                        mn.name = params.namez
                        mn.controller = params.controllerz
                        mn.action = params.actionz
                        mn.url = ''
                        mn.label = params.labelz
                        mn.title = params.titlez
                        mn.active = false
//                        mn.roles = params.rolez
                        mn.save(flush: true, failOnError: true)
                        //Them request_map khi them menu
                        String request_map_url = "/" + params.controllerz + "/" + params.actionz
                        if (params.rolez) {
                            if (params.rolez.size() > 0) {
                                def rolez = String.join(',', params.rolez);
                                mn.roles = rolez
                            }
                        } else {
                            mn.roles = ""
                        }
                        String role = mn.roles
                        def rm = RequestMap.findByUrl(request_map_url)
                        if (!rm) {
                            if (role) {
                                rm = new RequestMap()
                                rm.url = request_map_url
                                rm.configAttribute = role.trim()
                                rm.save(flush: true, failOnError: true)
                            }
                        } else {
                            if (role) {
                                rm.configAttribute = role.trim()
                                rm.save(flush: true, failOnError: true)
                            } else {
                                rm.delete(flush: true, failOnError: true)
                            }
                        }
                        //
                    } else {
                        def mn = new MenuItem()
                        mn.name = params.namez
                        mn.controller = params.controllerz
                        mn.action = params.actionz
                        mn.url = ''
                        mn.label = params.labelz
                        mn.title = params.titlez
                        mn.active = false
//                        mn.roles = params.rolez
                        mn.save(flush: true, failOnError: true)
                        //Them request_map khi them menu
                        String request_map_url = "/" + params.controllerz + "/" + params.actionz

                        if (params."rolez[]") {
                            if (params."rolez[]".size() > 0) {
                                def rolez = String.join(',', params."rolez[]");
                                mn.roles = rolez
                            }
                        } else {
                            mn.roles = ""
                        }
                        String role = mn.roles
                        def rm = RequestMap.findByUrl(request_map_url)
                        if (!rm) {
                            if (role) {
                                rm = new RequestMap()
                                rm.url = request_map_url
                                rm.configAttribute = role.trim()
                                rm.save(flush: true, failOnError: true)
                            }
                        } else {
                            if (role) {
                                rm.configAttribute = role.trim()
                                rm.save(flush: true, failOnError: true)
                            } else {
                                rm.delete(flush: true, failOnError: true)
                            }
                        }
                    }
                }
                catch (Exception e) {
                    status.setRollbackOnly()
                    throw e
                    render(view: '/errors/500')
                }
            }

            springSecurityService.clearCachedRequestmaps()
            flash.message = "success;Th??ng b??o;C???p nh???t th??ng tin th??nh c??ng!;toast-top-right"
            redirect action: 'menuItem'
        } catch (Exception e) {
            throw e
            savelog("", e)
            render(view: '/errors/500')
        }
    }

    def deleteMenuItem() {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("deleteMenuItem", null)
            def mn = MenuItem.get(params.id)
            if (mn) mn.delete()
            flash.message = "success;Th??ng b??o;X??a th??nh c??ng!;toast-top-right"
            redirect action: 'menuItem'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    // JOB TITLE ---------------
    def jobTitle = { render view: '/m-melanin-fingerprint/m-melanin-fingerprint-jobTitle' }

    def savejobTitle = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("savejobTitle", null)
            if (params.jobTitleId) {
                def jt = JobTitle.get(params.jobTitleId)
                jt.name = params.name
                jt.save()
                flash.message = "success;Th??ng b??o;C???p nh???t th??ng tin ch???c danh th??nh c??ng!;toast-top-right"

                redirect action: 'jobTitle'
            } else {
                def jobTitlenew = new JobTitle()
                jobTitlenew.name = params.name
                jobTitlenew.save()
                flash.message = "success;Th??ng b??o;Th??m m???i ch???c danh th??nh c??ng!;toast-top-right"
                redirect action: 'jobTitle'
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def editjobTitle = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editjobTitle", null)
            def jt = JobTitle.get(params.jobTitleId)
            jt.name = params.name
            jt.save()
            redirect action: 'jobTitle'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def deletejobTitle = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("deletejobTitle", null)
            def jt = JobTitle.get(params.id)
            jt.delete()

            flash.message = "success;Th??ng b??o;X??a ch???c danh th??nh c??ng!;toast-top-right"
            redirect action: 'jobTitle'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    // BRANCH MANAGEMENT ----------------
    def branch = {
        render(view: '/m-melanin-fingerprint/m-melanin-fingerprint-branch')
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
            order("name", "asc")
        }
        rootNodes.each { tree << findSubBranchesAsJson(it) }
        render tree as JSON
    }

    private def findSubBranchesAsJson(def branch) {

        def currentNode = [data: branch.code + " - " + branch.name, attr: [id: branch.id, code: branch.code]]
        def children = []
        def childTemp = Branch.createCriteria().list {
            eq('parent', branch)
            or {
                isNull('status')
                ne('status', '-1')
            }
            order('code', 'asc')
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
//        def divCC = g.render(template: '/templates/table_ds_user', model: [branchid: params.id])
        result << [branch: branch]
//        result << [users: branch.users]
//        result << [divCC: divCC]
        render result as JSON
    }

    def findAllUserInBranch() {
        println "${actionUri}: " + new Date() + ": " + params
        def divCC = g.render(template: '/templates/table_ds_user', model: [branchid: params.branchid])
        render(text: [success: true, divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def saveBranch = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("saveBranch", null)
            try {
                if (params.id) {
                    redirect action: 'editBranch', params: params
                    return
                } else {
                    int level = 999
                    def pbranch

                    if (params["parentid"]) {
                        pbranch = Branch.get(Long.parseLong(params["parentid"]))
                        level = pbranch.level.toInteger() + (1).toInteger()
                    }
                    def paramsTemp = params

                    def validate = validateBranch(paramsTemp, level)
                    if (!validate[0]) {
                        redirect(action: 'branch', params: [msg: "error;Th??ng b??o;" + validate[1] + ";toast-top-right"])
                        return;
                    }
                    def codeBranch = genBranchCode(paramsTemp, pbranch, level)
                    def checkBranch = Branch.findByCodeAndStatusIsNull(codeBranch)
                    if (checkBranch) {
                        redirect(action: 'branch', params: [msg: "error;Th??ng b??o;M?? ????n v??? tr??ng v???i ????n v??? " + checkBranch.code + "-" + checkBranch.name + "!;toast-top-right"])
                        return
                    } else if (Branch.findByNameAndStatusIsNull(params.name)) {
                        redirect(action: 'branch', params: [msg: "error;Th??ng b??o;T??n ????n v??? kh??ng ???????c tr??ng !;toast-top-right"])
                        return
                    } else {
                        def branch = new Branch()
                        branch.name = params.name
                        branch.shortname = params.shortname
                        String active = params.active
                        //08112019
                        branch.vungMien = params.vungMien
                        branch.sequenceCode = params.sequenceCode
                        //--
                        //21022019
                        branch.realName = params.realName
                        //--
                        branch.code = codeBranch

/*                        if (params."sanPham[]") {
                            if (params."sanPham[]".size() > 0) {
                                def sanPham = String.join(',', params."sanPham[]");
                                branch.sanPham = sanPham
                            }
                        }*/

                        if (active == 'true' || active.equals('true')) {
                            branch.active = true
                        } else {
                            branch.active = false
                        }
                        if (params["parentid"]) {
                            branch.parent = branch.get(params["parentid"])
                            branch.level = branch.get(params["parentid"]).level.toInteger() + (1).toInteger()
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
                        flash.message = "success;Th??ng b??o;Th??m ????n v??? th??nh c??ng!;toast-top-right"
                    }
                }
            } catch (Exception e) {
                throw e
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def genBranchCode(def params, Branch parent, def lvl) {
        def code, tempCode
        if (lvl == 0) {
            return code = params.code
        } else if (lvl == 1) {
            tempCode = params.sequenceCode
        } else {
            tempCode = parent.sequenceCode + "." + params.sequenceCode
        }
//        code = params.vungMien + "." + tempCode
        code = tempCode
        return code
    }

    def validateBranch(def params, def level) {
        def validate = [true, ""]

        if (params.sequenceCode && level >= 2) {
            String regexSequence = "^[0-9]*\$";
            Pattern pattern = Pattern.compile(regexSequence);
            if (!pattern.matcher(params.sequenceCode).matches()) {
                // chi nhap kieu so
                validate[0] = false
                validate[1] = "S??? sequence kh??ng h???p l???!"
            }
        }
        return validate
    }


    def editBranch = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editBranch", null)
            Branch parent = Branch.get(params.parentid)
            def branch = Branch.get(params.id)
            branch.name = params.name

            //08112019
            def paramsTemp = params
            def level = Integer.parseInt(params.level)
            def validate = validateBranch(paramsTemp, level)
            if (!validate[0]) {
                redirect(action: 'branch', params: [msg: "error;Th??ng b??o;" + validate[1] + ";toast-top-right"])
                return;
            }
            def codeBranch = genBranchCode(paramsTemp, parent, branch.level)

            if (params.parentid == params.id) {
                redirect(action: 'branch', params: [msg: "error;Th??ng b??o;????n v??? qu???n l?? kh??ng l?? ????n v??? qu???n l?? hi???n t???i!;toast-top-right"])
                return
            }
            //--

            if (parent?.level >= 2) {
                redirect(action: 'branch', params: [msg: "error;Th??ng b??o;????n v??? qu???n l?? ch??? thu???c level 0 v?? 1!;toast-top-right"])
                return
            }

            def a1 = Branch.findByCodeAndStatusIsNull(codeBranch)
            def a2 = Branch.findByNameAndStatusIsNull(params.name)
            if (a1 && branch.id != a1.id) {
                redirect(action: 'branch', params: [msg: "error;Th??ng b??o;M?? ????n v??? tr??ng v???i ????n v??? " + a1.code + "-" + a1.name + " !;toast-top-right"])
                return
            } else if (a2 && branch.id != a2.id) {
                redirect(action: 'branch', params: [msg: "error;Th??ng b??o;T??n ????n v??? ???? t???n t???i !;toast-top-right"])
                return
            } else {
//                branch.code = params.code
                //08112019
                if (branch.level >= 1) {
                    branch.vungMien = params.vungMien
                    branch.sequenceCode = params.sequenceCode
                }
                //--
                branch.code = codeBranch
                branch.shortname = params.shortname
                branch.realName = params.realName
                String active = params.active
/*                if (params."sanPham[]") {
                    if (params."sanPham[]".size() > 0) {
                        def sanPham = String.join(',', params."sanPham[]");
                        branch.sanPham = sanPham
                    }
                } else {
                    branch.sanPham = ""
                }*/

                if (active == 'true' || active.equals('true')) {
                    branch.active = true
                } else {
                    if (branch.canbedeleted) {
                        if (!branch.children) {
                            branch.active = false
                        } else {
                            redirect(action: 'branch', params: [msg: "error;L???i!;Kh??ng th??? inactive ????n v??? n??y !;toast-top-right"])
                            return
                        }
                    } else {
                        redirect(action: 'branch', params: [msg: "error;L???i!;Kh??ng th??? inactive ????n v??? n??y !;toast-top-right"])
                        return
                    }
                }
                if (params["parentid"]) {
                    branch.parent = branch.get(params["parentid"])
                    branch.level = branch.get(params["parentid"]).level.toInteger() + (1).toInteger()
                } else {
                    branch.level = 0
                    branch.parent = null
                }
                def listBranch = []
                if (branch.children && branch.level >= 2) {
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
                flash.message = "success;Th??ng b??o;C???p nh???t th??ng tin ????n v??? th??nh c??ng!;toast-top-right"
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def deleteBranch = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("deleteBranch", null)
            def brid = params.id
            def branch = Branch.get(params.id)
            if (branch.level == 0) {
                redirect action: 'branch'
                flash.message = "error;Th??ng b??o;Kh??ng ???????c x??a ????n v??? c?? level b???ng 0!;toast-top-right"
            } else {
                if (branch.children) {
                    redirect action: 'branch'
                    flash.message = "error;Th??ng b??o;Kh??ng th??? x??a ????n v??? l?? cha c???a ????n v??? kh??c ho???c b???n ghi n??y ???? ph??t sinh quan h??? d??? li???u!;toast-top-right"
                } else {
                    if (!branch.canbedeleted) {
                        redirect action: 'branch'
                        flash.message = "error;Th??ng b??o;B???n ghi n??y ???? ph??t sinh quan h??? d??? li???u, kh??ng th??? x??a!;toast-top-right"
                    } else {
//                        branch.status = '-1'
//                        def listBranch = []
//                        if (branch.children) {
//                            listBranch << branch
//                            while (listBranch) {
//                                def listchildBranch = []
//                                listBranch.each { Branch childB ->
//                                    childB.children.each { Branch childB2 ->
//                                        childB2.status = '-1'
//                                        childB2.save(flush: true)
//                                        listchildBranch << childB2
//                                    }
//                                }
//                                listBranch = listchildBranch
//                            }
//                        }
//                        branch.save(flush: true)

                        branch.delete(flush: true, failOnError: true)
                        redirect action: 'branch'
                        flash.message = "success;Th??ng b??o;X??a th??ng tin ????n v??? th??nh c??ng!;toast-top-right"
                    }
                }
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def addUserToBranch = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("addUserToBranch", null)
            def user = User.get(params.id)
            def branch = Branch.get(params.branch.toLong())

            if (branch.users.contains(user)) {
                render(text: [success: false, msg: "User ???? thu???c ????n v??? r???i!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            } else if (user.branch) {
                render(text: [success: false, msg: "User n??y ??ang thu???c 1 ????n v??? kh??c!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            } else {
                branch.addToUsers(user)
                branch.canbedeleted = false
                branch.save(flush: true)
                def divCC = g.render(template: '/templates/div_addrow_uinb', model: [rs: user])
                render(text: [success: true, user: user, divCC: divCC, msg: "Th??m user v??o ????n v??? th??nh c??ng!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def removeUserFromBranch = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("removeUserFromBranch", null)
            def user = User.get(params.id)
            def branch = Branch.get(params.branch.toLong())
            println "branch.users = " + branch.users
            if (branch.users.contains(user)) {
                branch.users.remove(user)
                branch.save(flush: true)
                user.branch = null
                user.save(flush: true)

                flash.message = "success;Th??ng b??o;X??a user kh???i ????n v??? th??nh c??ng!;toast-top-right"
                render 1
                return
            }
            render '-1'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def removeUserFromBranch_new = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("removeUserFromBranch_new", null)
            def user = User.get(params.id)
            def branch = Branch.get(params.branch.toLong())

            if (user.branch.id == branch.id) {
                user.branch = null
                user.save(flush: true)
                flash.message = "success;Th??ng b??o;X??a user kh???i ????n v??? th??nh c??ng!;toast-top-right"
                render 1
                return
            }
            render '-1'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def searchUser = {
        def users = User.findAllByFullnameLikeOrUsernameLike(params.term + "%", params.term + "%", [max: 20, sort: 'fullname'])
        render users as JSON
    }

    // USER MANAGEMENT ----------------

    def user = {
        println "${actionUri}: " + new Date() + ": " + params
        def listuser = User.list(sort: "id", order: "desc");
        def listBranch = commonService.getListBranch()
        //        render view: '/m-melanin-fingerprint/m-melanin-fingerprint-user', model: [listuser: listuser]
        render view: '/m-melanin-fingerprint/m-melanin-fingerprint-user-ss', model: [listuser: listuser, listBranch: listBranch]
    }

    //import user
    def btn_importExcel() {
        println "${actionUri}: " + new Date() + ": " + params
        def divCC = g.render(template: "/templates/modal_import_user_excel")
        render(text: [result: 'ok', divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def exportFileMau() {
        forward(controller: 'danhMucUser', action: 'exportFileMau', params: params)
    }

    def importExcel() {
        println "${actionUri}: " + new Date() + ": " + params
        forward(controller: 'danhMucUser', action: 'importExcel', params: params)
    }


    //load ra ds user cho bang server side
    def dsuser_ss() {
        println "${actionUri}: " + new Date() + ": " + params
        def role = cookieService.getCookie("role")

        StringBuilder query = new StringBuilder()
        query.append(" SELECT stt, id, username,manhanvien, fullname,")
        query.append("        branchname, chucvu,")
        query.append("        email, active")
        query.append(" FROM (SELECT (@row_number:=@row_number + 1) AS stt, th.*")
        query.append("       FROM (SELECT DISTINCT u.id AS id,")
        query.append("                    u.ma_nhan_vien AS manhanvien,")
        query.append("                    u.username AS username,")
        query.append("                    u.fullname AS fullname,")
        query.append("                    dv.name AS branchname,")
        query.append("                    u.chuc_vu AS chucvu,")
        query.append("                    u.email AS email,")
        query.append("                    if(u.enabled='1','Active', 'Inactive') as active")
        query.append("             FROM       users u , branch dv, (SELECT @row_number:=0) AS t")
        query.append("             WHERE u.branch_id = dv.id  AND u.username <> 'admin'")

        def whereParam = []

        if (params.username_search) {
            query.append(" AND u.username like (?) ")
            whereParam.push("%" + params.username_search + "%")
        }
        if (params.branch_search) {
            query.append(" AND dv.id = ? ")
            whereParam.push(params.branch_search)
        }

        if (params.role_search) {
            query.append(" AND EXISTS (SELECT 1 from user_role g where u.id = g.user_id and role_id = ?) ")
            whereParam.push(params.role_search)
        }

        if (params.trangthai_search) {
            if (params.trangthai_search == "true") {
                query.append(" AND u.enabled = 1 ")
            } else {
                query.append(" AND u.enabled = 0 ")
            }
        }

        query.append(" ORDER BY u.id DESC) th) a")
        query.append(" WHERE 1 = 1")

        ServerSideMelaninService ssc = new ServerSideMelaninService()
        def listdynamic = ssc.listdynamic(query.toString(), params, dataSource, whereParam)

        JSONArray dataAr = listdynamic.get("data")
        JSONArray newData = new JSONArray()
        for (int i = 0; i < dataAr.size(); i++) {
            Object data = dataAr.get(i)
            List dataAsList = data.toList()
            JSONArray dataObj = new JSONArray()
            dataObj.push(dataAsList.get(0))
            dataObj.push(dataAsList.get(1))
            dataObj.push(dataAsList.get(2))
            dataObj.push(dataAsList.get(3))
            dataObj.push(dataAsList.get(4))
            dataObj.push(dataAsList.get(5))
            dataObj.push(dataAsList.get(6))
            dataObj.push(dataAsList.get(7))
//            String rolenamestr = get_rolename_by_userid(dataAsList.get(1))
//            dataObj.push(rolenamestr)
//6 - do search theo role b??? m???t m???t c??c role kh??c n??n ph???i l??m c??i n??y ????? li???t k?? ?????
            dataObj.push(dataAsList.get(8))
            String lnk = ""
            lnk = "<td><a href='#' rel='" + dataAsList.get(1) + "' value='" + dataAsList.get(1) + "' class='editUrl icon-edit'></a>&nbsp;&nbsp;"
            lnk += "<a href='#' rel='" + dataAsList.get(1) + "' value='" + dataAsList.get(1) + "' class='deleteUrl icon-trash'></a>"

            lnk += "</td>"
            dataObj.push(lnk)//(9)
            newData.push(dataObj)
        }
        listdynamic.put("data", newData)
        render listdynamic as JSON
    }

    def get_rolename_by_userid(def userid) {
        def user = User.get(userid)
        def ur = UserRole.findAllByUser(user)
        def rolename = ur.role.name
        String rolenamestr = rolename.join(", ")
        return rolenamestr
    }

    /*def searchuser2() {
        println "${actionUri}: " + new Date() + ": " + params
        StringBuilder query = new StringBuilder("SELECT distinct id FROM users u INNER JOIN user_role ur ON u.id = ur.user_id WHERE 1 = 1 ")
        if (params.username) {
            query.append(" AND u.username LIKE '%" + params.username + "%'")
        }
        if (params.role) {
            query.append(" AND ur.role_id = " + params.role)
        }
        if (params.branch) {
            query.append(" AND branch_id = " + params.branch)
        }
        def sql = new Sql(dataSource)
        def rows = sql.rows(query.toString())
        def listuser = []
        if (rows) {
            for (r in rows) {
                def u = User.get(r[0])
                listuser << u
            }
        }
        render view: '/m-melanin-fingerprint/m-melanin-fingerprint-user-ss', model: [listuser: listuser]
        sql.close()
    }*/

    def addUser = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("addUser", null)
            if (params.userId) {
                redirect action: 'editUser', params: params
                return
            } else if (User.findByUsername(params.username)) {
                flash.message = "error;L???i!;Username ???? t???n t???i trong h??? th???ng. Vui l??ng ch???n username kh??c!;toast-top-right"
                redirect action: 'user'
            } else if (User.findByMaNhanVien(params.maNhanVien)) {
                flash.message = "error;L???i!;M?? nh??n vi??n ???? t???n t???i trong h??? th???ng. Vui l??ng nh???p m?? nh??n vi??n kh??c!;toast-top-right"
                redirect action: 'user'
            } else {
                User user = new User(params)
                User.withTransaction { status ->
                    try {
                        user.branch = Branch.get(params.branchID)
//                        user.nhomKt = TamDmNhomKeToanHdr.get(params.nhomKt)
                        if (!params.password) {
                            user.password = '1'
                        }
                        String enabled = params.enabled
                        if (enabled == 'true' || enabled.equals('true')) {
                            user.enabled = true
                        } else {
                            user.enabled = false
                        }
                        user.errors.each { println it }
                        user.save(flush: true)

                        Role role
                        if (params.roles) {
                            if (params.roles.class.name.equals('java.lang.String')) {
                                UserRole.create(user, Role.findByAuthority(params.roles), true)
                            } else {
                                params.roles.each {
                                    UserRole.create(user, Role.findByAuthority(it), true)
                                }
                            }
                        }
                        flash.message = "success;Th??ng b??o;Th??m m???i user th??nh c??ng!;toast-top-right"
                    } catch (Exception e) {
                        status.setRollbackOnly()
                        throw e
                        flash.message = "error;L???i!;L??u kh??ng th??nh c??ng !!;toast-top-right"
                    }
                }
                redirect action: 'user'
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def editUser = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editUser", null)
            User user = User.get(params.userId)

            def nhanvien = User.findByMaNhanVien(params.maNhanVien)
            if (nhanvien) {
                if (nhanvien.id != Long.valueOf(params.userId)) {
                    flash.message = "error;L???i!;M?? nh??n vi??n ???? t???n t???i trong h??? th???ng. Vui l??ng nh???p m?? nh??n vi??n kh??c!;toast-top-right"
                    redirect action: 'user'
                    return
                }
            }

            User.withTransaction { status ->
                try {
                    if (params.password == '') params.remove('password')
                    user.properties = params
                    user.branch = Branch.get(params.branchID)
//                    user.nhomKt = TamDmNhomKeToanHdr.get(params.nhomKt)
                    String enabled = params.enabled
                    if (enabled == 'true' || enabled.equals('true')) {
                        user.enabled = true
                    } else {
                        user.enabled = false
                    }
                    user.save(flush: true)
                    UserRole.removeAll user
                    println('role: ' + params.roles)
                    if (params.roles) {
                        if (params.roles.class.name.equals('java.lang.String')) {
                            UserRole.create user, Role.findByAuthority(params.roles), true
                        } else {
                            params.roles.each {
                                UserRole.create user, Role.findByAuthority(it), true
                            }
                        }
                    }
                    flash.message = "success;Th??ng b??o;C???p nh???t th??ng tin user th??nh c??ng!;toast-top-right"
                }
                catch (Exception ex) {
                    flash.message = "error;Th??ng b??o;Update th??ng tin user kh??ng th??nh c??ng!;toast-top-right"
                }
            }
            forward action: 'user'
            return
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def deleteUser = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("deleteUser", null)
            try {
                User user = User.get(params.id)
                if (!user.canbedeleted) {
                    redirect action: 'user'
                    flash.message = "error;Th??ng b??o;B???n ghi n??y ???? ph??t sinh quan h??? d??? li???u, kh??ng th??? x??a!;toast-top-right"
                } else {
                    UserRole.findAllByUser(user).each { UserRole.removeAll user }
                    user.delete(flush: true)
                    redirect action: 'user'
                    flash.message = "success;Th??ng b??o;D??? li???u ???????c x??a th??nh c??ng!;toast-top-right"
                }
            }
            catch (Exception ex) {
                flash.mesage = ex.message
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def getUserInfo = {
        println "\n${actionUri}: " + new Date() + ": " + params
        def user = User.get(params.uid)
        def branch_id = user?.branch?.id
        def ur = UserRole.findAllByUser(user)
        String rolename = ""
        if (ur) {
            rolename = ur*.role*.authority.toString()
        }
        render(text: [success: true, user: user, branch_id: branch_id, rolename: rolename] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def rolegroup = {
        println "\n${actionUri}: " + new Date() + ": " + params
        render view: '/m-melanin-fingerprint/m-melanin-fingerprint-roleGroup', model: [abc: 'abc']
        return
    }

    // ROLE MANAGEMENT -----------------
    def role = {
        println "\n${actionUri}: " + new Date() + ": " + params
        render view: '/m-melanin-fingerprint/m-melanin-fingerprint-role', model: [abc: 'abc']
        return
    }

    def findUsersByRole = {
        def users = UserRole.findAllByRole(Role.get(params.id)).user
        render users as JSON
    }

    def add_role_requestmap() {
        println "you are allowed!"
        render(text: [success: true] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def lay_div_addupdaterole() {
        println "${actionUri}: " + new Date() + ": " + params
        def role = Role.get(params.role_id)
        def divCC
        if (role) {
            divCC = g.render(template: '/templates/div_addupdaterole', model: [role: role, edit_or_new: "edit"])
        } else {
            divCC = g.render(template: "/templates/div_addupdaterole", model: [edit_or_new: "new"])
        }

        render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def lay_div_addupdate_rolegroup() {
        println "${actionUri}: " + new Date() + ": " + params
        def role_group = RoleGroup.get(params.role_id)
        def divCC
        if (role_group) {
            divCC = g.render(template: "/templates/div_addupdate_rolegroup", model: [role_group: role_group, edit_or_new: "edit"])
        } else {
            divCC = g.render(template: "/templates/div_addupdate_rolegroup", model: [edit_or_new: "new"])
        }

        render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def lay_div_dschucnangdaphanquyen() {
        println "${actionUri}: " + new Date() + ": " + params
        def role = Role.get(params.role_id)
        String dschucnang = role.dschucnang // = [[111,113,112,114];[];[];[];[];[];[]]
        if (dschucnang && dschucnang.length() > 2) {
            String dschucnang2 = dschucnang.substring(1, dschucnang.length() - 1)
// = [111,113,112,114];[];[];[];[];[];[]
            String[] arr_dschucnang = dschucnang2.split(";")
            def list_chucnang = []
            for (int i = 0; i < arr_dschucnang.size(); i++) {
                if (arr_dschucnang[i].length() > 2) {
                    String dschucnang3 = arr_dschucnang[i].substring(1, arr_dschucnang[i].length() - 1)
                    // = 111,113,112,114
                    String[] arr_dschucnang3 = dschucnang3.split(",")
                    for (int j = 0; j < arr_dschucnang3.size(); j++) {
                        list_chucnang.add(arr_dschucnang3[j])
                    }
                }
            }
            println "list_chucnang: " + list_chucnang
            if (list_chucnang) {
                def dschucnang_daphanquyen = UrlGroup.getAll(list_chucnang)
                def divCC = g.render(template: "/templates/div_dschucnangdaphanquyen", model: [dschucnang_daphanquyen: dschucnang_daphanquyen])
                render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
            } else {
                def divCC = g.render(template: "/templates/div_dschucnangdaphanquyen", model: [dschucnang_daphanquyen: null])
                render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
            }
        }
    }

    /**
     * @author lamnt3* Ham save role danh cho LPB
     * + th??m Role => c?? ds m???ng ch???c n??ng
     + th??m UserRole
     + duy???t qua m???ng ch???c n??ng => t???o ra request map m???i t????ng ???ng v???i Role
     */
    def addRole2 = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("addRole2", null)
            if (params.roleId) {
                redirect action: 'editRole2', params: params
                return
            } else {
                def module = Module.get(params.module_id)
                def roleGroup = RoleGroup.get(params.roleGroup)
                String rolename = params.rolename.toString().trim().toUpperCase()
                String diengiai = params.diengiai.toString().trim()
                String active = params.active
                //v???i b???t k?? th???ng n??o c?? quy???n admin, tr?????c h???t ph???i cho th??m c??i request map ????? n?? v??o dc trang index ????
                if (roleGroup.authority == 'Admin') {
                    /*def cantao = ['/fingerprint/role', '/fingerprint/branch', '/fingerprint/user', '/fingerprint/dsuser_ss', '/fingerprint/urlmng',
                                  '/fingerprint2/workflowsetup', '/fingerprint2/parametersmng', '/fingerprint2/logmng',
                                  '/fingerprint/menuItem', '/fingerprint2/luong_dg_dvkd', '/fingerprint/index']*/
                    def cantao = ['/fingerprint/**']
                    for (ct in cantao) {
                        def rm = RequestMap.findByUrl(ct)
                        if (!rm) {
                            rm = new RequestMap()
                            rm.url = ct
                            rm.configAttribute = rolename
                            rm.save(flush: true, failOnError: true)
                        } else {
                            String cf = rm.configAttribute
                            def cf_arr = cf.split(",")
                            if (cf_arr && !cf_arr.contains(rolename)) {
                                cf += "," + rolename
                            }
                            rm.configAttribute = cf
                            rm.save(flush: true, failOnError: true)
                        }
                    }
                }

                String list_function_by_module = params.list_function_by_module
                if (list_function_by_module && list_function_by_module.length() > 4) {
                    String list_function_by_module2 = list_function_by_module.substring(1, list_function_by_module.length() - 1)
                    // bo 2 dau ngoac
                    String[] arr_function = list_function_by_module2.split(";")

                    //1. save new role
                    def rc = Role.findByAuthority(params.rolename.trim())
                    if (!rc) {
                        def role = new Role()
                        Role.withTransaction { status ->
                            try {
                                role.authority = rolename
                                role.name = rolename
                                role.roleGroup = roleGroup
                                if (active == 'true' || active.equals('true')) {
                                    role.active = true
                                } else {
                                    role.active = false
                                }
                                role.diengiai = diengiai
                                role.dschucnang = list_function_by_module
                                role.save(flush: true, failOnError: true)

                                //2. duyet qua mang danh sach chuc nang theo module de tim ra cac url roi cho vao bang request map
                                //Ex: [112,111,114,113] => 112 la url_group_id => findAll url co url_group_id = 112 nay
                                for (int i = 0; i < arr_function.size(); i++) {
                                    if (arr_function[i].length() > 2) {
                                        println "arr_function[i]: " + arr_function[i] // = [112,111,114,113]
                                        println "module: " + (i + 1)
                                        String arr_function2 = arr_function[i].substring(1, arr_function[i].length() - 1)
                                        // = 112,111,114,113
                                        println "arr_function2: " + arr_function2
                                        if (arr_function[i].length() > 1) {
                                            String[] arr_role_group_id = arr_function2.split(",")
                                            // = m???ng 112,111,114,113
                                            println "arr_role_group_id: " + arr_role_group_id
                                            for (int j = 0; j < arr_role_group_id.size(); j++) {
                                                println "arr_role_group_id[j]: " + arr_role_group_id[j]// = 112,...
                                                def url_gr_id = UrlGroup.get(arr_role_group_id[j])
                                                println "url_gr_id: " + url_gr_id
                                                if (url_gr_id) {
                                                    def urls = Url.findAllByUrlGroup(url_gr_id)*.url
                                                    // l???c h???t c??c url ???? c?? c???a url group n??y
                                                    //println "urls: " + urls
                                                    for (u in urls) {
                                                        def rmz = RequestMap.findByUrl(u)
                                                        //181017 - ch???nh s???a l???i l?? khi active th?? m???i th??m v??o request map. k th?? th??i
                                                        if (role.active) {
                                                            if (rmz) {
                                                                // n???u ???? c?? request map v???i url s???n c?? r???i, th?? th??m d???u ph???y + t??n role v??o
                                                                String ca_current = rmz.configAttribute.toLowerCase()
                                                                def cf_arr = ca_current.split(",")
                                                                if (cf_arr && !cf_arr.contains(rolename.toLowerCase())) {
                                                                    rmz.configAttribute += "," + rolename
                                                                }
                                                                /*if (!ca_current.toLowerCase().contains(rolename.toLowerCase())) {
                                                                    rmz.configAttribute += "," + rolename
                                                                }*/
                                                                rmz.save(flush: true, failOnError: true)
                                                            } else {// kh??ng c?? th?? t???o m???i
                                                                def rm = new RequestMap()
                                                                rm.url = u
                                                                rm.configAttribute = rolename
                                                                rm.save(flush: true, failOnError: true)
                                                            }
                                                        }
                                                        springSecurityService.clearCachedRequestmaps()
                                                        change_alert_clearCachedRequestmaps()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                flash.message = "success;Th??ng b??o;Th??m m???i role th??nh c??ng!;toast-top-right"
                            } catch (Exception e) {
                                status.setRollbackOnly()
                                throw e
                                flash.message = "error;Th??ng b??o;???? c?? role n??y r???i !;toast-top-right"
                            }
                        }
                    } else {
                        flash.message = "error;Th??ng b??o;???? c?? nh??m quy???n n??y r???i !;toast-top-right"
                    }
                } else {
                    flash.message = "error;Th??ng b??o;L??u kh??ng th??nh c??ng !;toast-top-right"
                }
                redirect action: 'role'
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    /**
     * @author lamnt3* - Khi edit 1 role c?? s???n
     * + edit th??ng tin role
     * + x??a h???t UserRole th??m m???i l???i t??? ?????u
     * + duy???t qua m???ng ch???c n??ng, x??a h???t requestmap c??, th??m m???i l???i theo m???ng ch???c n??ng ?????y l??n,
     * d?? c?? thay ?????i hay kh??ng th?? m???i l???n s???a c??ng x??a r???i th??m l???i
     */
    def editRole2 = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editRole2", null)
            println "${actionUri}: " + new Date() + ": " + params
            def role = Role.get(params.roleId)
            if (role) {
                if (role.authority == 'ROLE_ADMIN') {
                    flash.message = "error;L???i;Kh??ng ???????c ch???nh s???a ROLE n??y!;toast-top-right"
                } else {
                    Role.withTransaction { status ->
                        try {
                            String old_role = role.authority
                            def module = Module.get(params.module_id)
                            def roleGroup = RoleGroup.get(params.roleGroup)
                            String rolename = params.rolename.toString().trim()
                            String diengiai = params.diengiai.toString().trim()
                            String active = params.active
                            String list_function_by_module = params.list_function_by_module
                            String list_function_by_module2 = list_function_by_module.substring(1, list_function_by_module.length() - 1)
                            String[] arr_function = list_function_by_module2.split(";")

                            role.authority = params.rolename
                            role.name = params.rolename
                            role.roleGroup = roleGroup
                            if (active == 'true' || active.equals('true')) {
                                role.active = true
                            } else {
                                role.active = false
                            }
                            role.diengiai = diengiai
                            role.dschucnang = list_function_by_module
                            role.save(flush: true, failOnError: true)

                            //Khong xoa nhung thang co duong dan tu controler direct
                            //def rm_olds = RequestMap.findAll()
                            def rm_olds = RequestMap.createCriteria().list {
                                not {
                                    ilike("url", "%direct%")
                                }
                            }
                            //s???a l???i nh?? sau
                            rm_olds.each { rm ->
                                //l???p qua t???ng RequestMap, cho v??o m???ng => parts l?? m???ng danh s??ch c??c config attribute
                                List parts = rm.configAttribute.split(',')
                                //n???u ch??? 1 b???n ghi m?? l???i tr??ng v???i role n??y th?? x??a h???n request map ????
                                if (parts.size() == 1) {
                                    parts.each { p ->
                                        if (p.equals(old_role)) {
                                            if (rm) rm.delete()
                                        }
                                    }
                                }
                                //n???u s??? l?????ng part > 1 th?? x??a ri??ng c??i part ???? th??i
                                else if (parts.size() > 1) {
                                    parts.remove old_role
                                    rm.configAttribute = parts.join(',')
                                    rm.save(flush: true, failOnError: true)
                                }
                            }


                            springSecurityService.clearCachedRequestmaps()
                            change_alert_clearCachedRequestmaps()

                            //181017 - n???u nh?? active th?? th??m l???i, k th?? th??i
                            if (role.active) {
                                //them lai request map tu dau
                                for (int i = 0; i < arr_function.size(); i++) {
                                    if (arr_function[i].length() > 2) {
                                        println "arr_function[i]: " + arr_function[i] // = [112,111,114,113]
                                        println "module: " + (i + 1)
                                        String arr_function2 = arr_function[i].substring(1, arr_function[i].length() - 1)
                                        // = 112,111,114,113
                                        println "arr_function2: " + arr_function2
                                        if (arr_function[i].length() > 1) {
                                            String[] arr_role_group_id = arr_function2.split(",")
                                            println "arr_role_group_id: " + arr_role_group_id
                                            for (int j = 0; j < arr_role_group_id.size(); j++) {
                                                println "arr_role_group_id[j]: " + arr_role_group_id[j]
                                                def url_gr_id = UrlGroup.get(arr_role_group_id[j])
                                                println "url_gr_id: " + url_gr_id
                                                if (url_gr_id) {
                                                    def urls = Url.findAllByUrlGroup(url_gr_id)*.url
                                                    println "urls: " + urls
                                                    for (u in urls) {
                                                        def rmz = RequestMap.findByUrl(u)
                                                        if (rmz) {
                                                            String ca_current = rmz.configAttribute.toLowerCase()
                                                            def cf_arr = ca_current.split(",")
                                                            if (cf_arr && !cf_arr.contains(rolename.toLowerCase())) {
                                                                rmz.configAttribute += "," + rolename
                                                            }
                                                            /*if (!ca_current.toLowerCase().contains(rolename.toLowerCase())) {
                                                                rmz.configAttribute += "," + rolename
                                                            }*/
                                                            rmz.save(flush: true, failOnError: true)
                                                        } else {
                                                            def rm = new RequestMap()
                                                            rm.url = u
                                                            rm.configAttribute = rolename
                                                            rm.save(flush: true, failOnError: true)
                                                        }
                                                        springSecurityService.clearCachedRequestmaps()
                                                        change_alert_clearCachedRequestmaps()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            flash.message = "success;Th??ng b??o;Ch???nh s???a role th??nh c??ng!;toast-top-right"
                        } catch (Exception e) {
                            status.setRollbackOnly()
                            throw e
                            flash.message = "error;Th??ng b??o;L??u kh??ng th??nh c??ng " + e + "!;toast-top-right"
                        }
                    }
                }
            } else {
                flash.message = "error;Kh??ng t??m th???y b???n ghi c???n ch???nh s???a !;toast-top-right"
            }

            redirect action: 'role'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def deleteRole = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("deleteRole", null)
            Role role = Role.get(params.id)
            springSecurityService.deleteRole(role)

            flash.message = "success;Th??ng b??o;X??a role th??nh c??ng!;toast-top-right"
            redirect action: 'role'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def deleteRoleGroup = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editRoleGroup", null)
            RoleGroup rolegroup = RoleGroup.get(params.id)

            if (rolegroup.authority == "Admin") {
                flash.message = "error;Th??ng b??o;Kh??ng ???????c x??a nh??m quy???n Admin!;toast-top-right "
                return
            }

            Role role = Role.findByRoleGroup(rolegroup)
            if (role) {
                flash.message = "error; Kh??ng th??? x??a khi c?? role s??? d???ng nh??m quy???n n??y!;toast-top-right "
                redirect action: 'rolegroup'
            } else {
                rolegroup.delete(flush: true, failOnError: true)
                flash.message = "success;Th??ng b??o;X??a nh??m quy???n th??nh c??ng!;toast-top-right "
                redirect action: 'rolegroup'
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }


    def addRoleGroup = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("saveRoleGroup", null)
            if (params.roleId) {
                redirect action: 'editRoleGroup', params: params
                return
            } else {
                String authority = params.authority.toString().trim().toUpperCase()
                String name = params.name.toString().trim()

                //1. save new role
                def rc = RoleGroup.findByAuthorityOrName(authority, name)
                if (!rc) {
                    def roleGroup = new RoleGroup()
                    RoleGroup.withTransaction { status ->
                        try {
                            roleGroup.authority = authority
                            roleGroup.name = name
                            roleGroup.canbedeleted = true
                            roleGroup.save(flush: true, failOnError: true)
                            flash.message = "success;Th??ng b??o;Th??m m???i nh??m quy???n th??nh c??ng!;toast-top-right "
                        } catch (Exception e) {
                            status.setRollbackOnly()
                            throw e
                            flash.message = "error;Th??ng b??o;C?? l???i khi t???o nh??m quy???n!;toast-top-right "
                        }
                    }
                } else {
                    flash.message = "error;Th??ng b??o;???? c?? nh??m quy???n n??y ho???c tr??ng t??n nh??m quy???n!;toast-top-right "
                }
                redirect action: 'rolegroup'
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }


    def editRoleGroup = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editRoleGroup", null)
            println "${actionUri}: " + new Date() + ": " + params

            def roleGroup = RoleGroup.get(params.roleId)
            String authority = params.authority.toString().toUpperCase().trim()
            String name = params.name.toString().trim()

            if (roleGroup.authority == "Admin") {
                flash.message = "error;Th??ng b??o;Kh??ng ???????c s???a nh??m quy???n Admin!;toast-top-right "
            } else {
                if (roleGroup) {
                    RoleGroup checkTrung = RoleGroup.createCriteria().get {
                        or {
                            eq('authority', authority)
                            eq('name', name)
                        }
                        ne('id', Long.parseLong(params.roleId))
                    }

                    if (checkTrung) {
                        flash.message = "error;Th??ng b??o;Kh??ng s???a nh??m quy???n ho???c t??n nh??m quy???n ???? t???n t???i!;toast-top-right "
                    } else {
                        RoleGroup.withTransaction { status ->
                            try {
                                roleGroup.authority = authority
                                roleGroup.name = name
                                roleGroup.save(flush: true, failOnError: true)
                                flash.message = "success;Th??ng b??o;Ch???nh s???a role th??nh c??ng!;toast-top-right "
                            } catch (Exception e) {
                                status.setRollbackOnly()
                                throw e
                                flash.message = "error;Th??ng b??o;L??u kh??ng th??nh c??ng " + e + "!;toast-top-right "
                            }
                        }
                    }
                } else {
                    flash.message = "error;Kh??ng t??m th???y b???n ghi c???n ch???nh s???a !; "
                }
            }
            redirect action: 'rolegroup'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def laydanhsachchucnangtheomodule = {
        def module = Module.get(params.module)
        def dschucnang = UrlGroup.findAllByModule(module, [sort: "usecasename", order: "asc"])
        def divCC = g.render(template: '/templates/div_dschucnang', model: [dschucnang: dschucnang, module: module])
        render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    // REQUEST MAP MANAGEMENT ----------------
    def requestmap = { render view: '/m-melanin-fingerprint/m-melanin-fingerprint-requestmap' }

    def addRequestmap = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("addRequestmap", null)
            if (params.requestmapId) {
                redirect action: 'editRequestmap', params: params
                return
            }
            RequestMap rm = new RequestMap(params).save(flush: true)
            springSecurityService.clearCachedRequestmaps()
            change_alert_clearCachedRequestmaps()

            flash.message = "success;Th??ng b??o;Th??m m???i request map th??nh c??ng!;toast-top-right"
            redirect action: 'requestmap'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def editRequestmap = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editRequestmap", null)
            RequestMap rm = RequestMap.get(params.requestmapId)
            rm.properties = params
            rm.save(flush: true)
            springSecurityService.clearCachedRequestmaps()
            change_alert_clearCachedRequestmaps()

            flash.message = "success;Th??ng b??o;C???p nh???t request map th??nh c??ng!;toast-top-right"
            redirect action: 'requestmap'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def deleteRequestmap = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("deleteRequestmap", null)
            RequestMap rm = RequestMap.get(params.id)
            rm.delete(flush: true)
            springSecurityService.clearCachedRequestmaps()
            change_alert_clearCachedRequestmaps()

            flash.message = "success;Th??ng b??o;X??a request map th??nh c??ng!;toast-top-right"
            redirect action: 'requestmap'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    private List findRequestmapsByRole(String roleName, domainClass, conf) {
        String requestmapClassName = conf.requestMap.className
        String configAttributeName = conf.requestMap.configAttributeField
        return domainClass.executeQuery(
                "SELECT rm FROM $requestmapClassName rm " +
                        "WHERE rm.$configAttributeName LIKE :roleName",
                [roleName: "%$roleName%"])
    }

    // qu???n tr??? url - t????ng t??? request map
    def urlmng() {
        render view: '/m-melanin-fingerprint/m-melanin-fingerprint-url', model: [abc: 'abc']
    }

    def layurlgrouptheomodule() {
        def module = Module.get(params.module)
        def urlgroup_by_module = UrlGroup.findAllByModule(module, [sort: "usecasename", order: "desc"])
        def divCC = g.render(template: "/templates/div_select_urlgroup", model: [urlgroup_by_module: urlgroup_by_module])
        render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    /**
     * @author lamnt3* @return l??u url v??o c??c url group t????ng ???ng
     * 1. th??m b???n ghi cho Url => c?? id_url_group
     * 2. Qu??t b???ng role, l???y ra to??n dschucnang => c?? id_url_group. N???u tr??ng id th?? ch???ng t??? url m???i th??m c???n c???p nh???t request map
     * 3. Ki???m tra RequestMap xem c?? url n??y ch??a ?
     * 4. N???u kh??ng c??: th??m m???i request map cho role + url m???i n??y
     */
    def addUrl() {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("addUrl", null)
            if (params.urlId) {
                redirect action: 'editUrl', params: params
                return
            } else {
                def ug = UrlGroup.get(params.urlgroup)
                if (ug) {
                    def u = Url.findAllByUrlAndUrlGroup(params.url, ug)
                    if (!u) {
                        Url rm = new Url()
                        Url.withTransaction { status ->
                            try {
                                rm.url = params.url
                                rm.urlGroup = ug
                                rm.save(flush: true, failOnError: true)

                                def allrole = Role.getAll()
                                if (allrole) {
                                    for (ar in allrole) {
                                        String dschucnang = ar.dschucnang // = [[111,112,113,114];[];[];[];[];[];[]]
                                        if (dschucnang && dschucnang.length() > 2) {
                                            String dschucnang2 = dschucnang.substring(1, dschucnang.length() - 1)
                                            // = [111,112,113,114];[];[];[];[];[];[]
                                            String[] arr_dschucnang = dschucnang2.split(";")
                                            // = m???ng [111,112,113,114];[];[];[];[];[];[]
                                            for (int i = 0; i < arr_dschucnang.size(); i++) {
                                                String dschucnang3 = arr_dschucnang[i] // = [111,112,113,114]
                                                if (dschucnang3.length() > 2) {
                                                    String dschucnang4 = dschucnang3.substring(1, dschucnang3.length() - 1)
                                                    // = 111,112,113,114
                                                    String[] arr_dschucnang4 = dschucnang4.split(",")
                                                    for (int j = 0; j < arr_dschucnang4.size(); j++) {
                                                        long cn = Long.parseLong(arr_dschucnang4[j] ? arr_dschucnang4[j] : "0")
                                                        if (cn == ug.id) {
                                                            //4.
                                                            def rq = RequestMap.findByUrl(params.url.toString().trim())
                                                            if (!rq) {
                                                                def newrq = new RequestMap()
                                                                newrq.url = params.url
                                                                newrq.configAttribute = ar.authority
                                                                newrq.save(flush: true, failOnError: true)
                                                            } else {
                                                                String ca_current = rq.configAttribute.toLowerCase()
                                                                def cf_arr = ca_current.split(",")
                                                                if (cf_arr && !cf_arr.contains(ar.authority.toLowerCase())) {
                                                                    rq.configAttribute += "," + ar.authority
                                                                }
                                                                /*if (!ca_current.toLowerCase().contains(ar.authority.toLowerCase())) {
                                                                    rq.configAttribute += "," + ar.authority
                                                                }*/
                                                                rq.save(flush: true, failOnError: true)
                                                            }
                                                            springSecurityService.clearCachedRequestmaps()
                                                            change_alert_clearCachedRequestmaps()
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                flash.message = "success;Th??ng b??o;Th??m m???i url th??nh c??ng!;toast-top-right"
                            } catch (Exception e) {
                                status.setRollbackOnly()
                                throw e
                                flash.message = "success;Th??ng b??o;L??u kh??ng th??nh c??ng " + e + "!;toast-top-right"
                            }
                        }
                    } else {
                        flash.message = "error;Th??ng b??o;???? t???n t???i b???n ghi t????ng t???!;toast-top-right"
                    }
                }
                redirect action: 'urlmng'
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    /**
     * @author lamnt3* h??m edit url, ch??? cho ph??p edit link , k cho ph??p edit url group, tr??nh r???c r???i request map
     */
    def editUrl() {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editUrl", null)
            Url rm = Url.get(params.urlId)
            if (rm) {
                Url.withTransaction { status ->
                    try {
                        String old_url = rm.url
                        String new_url = params.url
                        rm.url = new_url
                        rm.save(flush: true, failOnError: true)
                        def rms = RequestMap.findByUrl(old_url)
                        if (rms) {
                            rms.url = new_url
                            rms.save(flush: true, failOnError: true)
                            springSecurityService.clearCachedRequestmaps()
                            change_alert_clearCachedRequestmaps()
                        }
                        flash.message = "success;Th??ng b??o;C???p nh???t url th??nh c??ng!;toast-top-right"
                    } catch (Exception e) {
                        status.setRollbackOnly()
                        throw e
                        flash.message = "success;Th??ng b??o;L??u kh??ng th??nh c??ng " + e + "!;toast-top-right"
                    }
                }
            } else {
                flash.message = "error;Th??ng b??o;C???p nh???t kh??ng th??nh c??ng!;toast-top-right"
            }
            redirect action: 'urlmng'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def deleteUrl() {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("deleteUrl", null)
            Url rm = Url.get(params.id)
            if (rm) {
                Url.withTransaction { status ->
                    try {
                        def rqm = RequestMap.findAllByUrl(rm.url)
                        if (rqm) {
                            for (r in rqm) {
                                r.delete(flush: true, failOnError: true)
                            }
                        }
                        rm.delete()

                        if (!RequestMap.getAll()) {
                            def newrm = new RequestMap()
                            newrm.configAttribute = "ROLE_ADMIN"
                            newrm.url = "/fingerprint/**"
                            newrm.save(flush: true, failOnError: true)
                        }
                        springSecurityService.clearCachedRequestmaps()
                        change_alert_clearCachedRequestmaps()
                        flash.message = "success;Th??ng b??o;X??a url th??nh c??ng!;toast-top-right"
                    } catch (Exception e) {
                        status.setRollbackOnly()
                        throw e
                        flash.message = "success;Th??ng b??o;L??u kh??ng th??nh c??ng " + e + "!;toast-top-right"
                    }
                }
            } else {
                flash.message = "error;Th??ng b??o;X??a kh??ng th??nh c??ng!;toast-top-right"
            }

            redirect action: 'urlmng'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    // urlgroup -----------
    def urlgroup() {
        println "${actionUri}: " + new Date() + ": " + params

        SqlConnectionService sqlConnectionService = new SqlConnectionService();
        def sql = sqlConnectionService.getSqlConnection();

        StringBuilder query = new StringBuilder("SELECT ug.id AS ug_id,u.id AS u_id,ug.name AS ug_name,ug.module_id,ug.usecase,ug.usecasename,u.url,u.url_group_id,m.id AS module_id,m.code,m.name AS module_name")
        query.append(" FROM url_group ug ")
        query.append(" LEFT JOIN module m ON m.id = ug.module_id")
        query.append(" LEFT JOIN url u ON u.url_group_id = ug.id ORDER BY ug.id")
        def rows = sql.rows(query.toString())
        sql.close()

        render view: '/m-melanin-fingerprint/m-melanin-fingerprint-urlgroup', model: [urlgroup: rows]
    }

    // MODULE ---------------
    def module = { render view: '/m-melanin-fingerprint/m-melanin-fingerprint-module' }

    def saveModule = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("saveModule", null)
            if (params.moduleId) {
                def jt = Module.get(params.moduleId)
                jt.name = params.name
                jt.save()
                flash.message = "success;Th??ng b??o;C???p nh???t th??ng tin module th??nh c??ng!;toast-top-right"
                redirect action: 'module'
            } else {
                def modulenew = new Module()
                modulenew.name = params.name
                modulenew.save()
                flash.message = "success;Th??ng b??o;Th??m m???i module th??nh c??ng!;toast-top-right"
                redirect action: 'module'
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def editModule = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("editModule", null)
            def jt = Module.get(params.moduleId)
            jt.name = params.name
            jt.save()
            redirect action: 'module'
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def deleteModule = {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("deleteModule", null)
            try {
                savelog("deletemodule", null)
                def jt = Module.get(params.id)
                jt.delete()

                flash.message = "success;Th??ng b??o;X??a ch???c danh th??nh c??ng!;toast-top-right"
                redirect action: 'jobTitle'
            } catch (Exception e) {
                throw e
                savelog("", e)
            }
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    def checkform() {
        println "\n${actionUri}: " + new Date() + ": " + params
        try {
            savelog("", null)
        } catch (Exception e) {
            throw e
            savelog("", e)
        }
    }

    //clear cache request map
    def clear_cache_requestmap() {
        springSecurityService.clearCachedRequestmaps()
        change_alert_clearCachedRequestmaps()
    }

    //if some actions make change to request map, all nodes of load balancer need to be clear cache to be able to use new requestmap
    //this method changes the flag in Conf table, in your app, you need to create a job, run every minutes to clear cache only if it's value = 1
    def change_alert_clearCachedRequestmaps() {
        def clearcache = Conf.findByLabel('need_to_be_clear_cacherequestmap')
        if (clearcache) {
            clearcache.value = 1
            clearcache.save()
        }
    }

    private savelog(String actionname, Exception e) {
        if (!e) {
            melaninLogService.savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", "", "", "${actionUri}", "")
        } else {
            melaninLogService.savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", "", e?.getMessage() + " || " + e?.class, "${actionUri}", "ERROR")
        }
    }
}
