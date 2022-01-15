package com.melanin.commons

import com.melanin.security.RoleGroup
import com.melanin.security.User
import com.melanin.security.UserRole
import grails.plugin.cookie.CookieService
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.SpringSecurityUtils

import java.lang.reflect.Array
import java.util.stream.Collectors

/*import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic*/

class MelaninController {

    SpringSecurityService springSecurityService
    def melaninCommonService
    CookieService cookieService
    def melaninLogService

    def changePassword = {

        if (!params.oldPassword || !params.newPassword) {
            render '-1'; return
        }
        def curentUser = springSecurityService.getCurrentUser();

        def user = User.findByUsername(curentUser.username)


        if (springSecurityService.passwordEncoder.isPasswordValid(user.password, params.oldPassword, null)) {
            user.password = params.newPassword
            render user.save(flush: true) ? '1' : '-1'
        } else {
            render '-1'
        }
//        if (user.password == springSecurityService.encodePassword(params.oldPassword)) {
//            user.password = params.newPassword
//            render user.save(flush: true) ? '1' : '-1'
//        } else {
//            render '-1'
//        }

    }
    def switchDashboard = {
        if (springSecurityService.isLoggedIn()) {
            def u = User.findByUsername(springSecurityService.currentUser?.username)
            if (u) {
                u.lastLogin = new Date()
                u.save(flush: true)
            }
        }

        melaninLogService.savelog(request, "${actionUri}", "${params}", "login", null)
//        def ip = melaninCommonService.getIpAddressClient(request)
//        println '-----------------------------IP-------------------------------------'
//        println ip
//        def userRole = UserRole.findAllByUser(springSecurityService.getCurrentUser())
//        StringBuilder roles = new StringBuilder();
//        int count = 0;
//        for (UserRole userRole1 : userRole) {
//            if (count == 0) {
//                count++;
//                roles.append(userRole1.role.roleGroup.authority)
//            } else {
//                roles.append("-" + userRole1.role.roleGroup.authority)
//            }
//        }
//        cookieService.setCookie("role", roles.toString(), 24 * 60 * 60, "/")

        //uuid
//        UUID uuid = UUID.randomUUID();
//        String randomUUIDString = uuid.toString();
//        cookieService.setCookie("uuid", randomUUIDString, 24 * 60 * 60, "/")

        def mappings = grailsApplication.config.msb.platto.fingerprint.defaultUrlMappings
        def redirected = false
        if (mappings) {
            mappings.each { c ->
                c.each { k, v ->
                    if (!redirected && SpringSecurityUtils.ifAnyGranted(k)) {
                        redirect uri: v
                        redirected = true
                    }

                }

                if (!redirected) {
                    c.each { k, v ->
                        if (k == 'DEFAULT') {
                            redirect uri: v
                            redirected = true
                        }
                    }
                }
            }
        }
        if (!redirected)
            redirect uri: '/'
    }
    def index = {
        render view: '/m-melanin-dashboard'
    }
    def security = {
        render view: '/m-melanin-security'
    }
    def sample = {
        render view: '/m-melanin-test-main'
    }
    def jquery = {
        render view: '/m-melanin-jquery-ui'
    }
    def easyui = {
        render view: '/m-melanin-easy-ui'
    }
    def login = {
        println "login -----------------"
        render(view: "/m-melanin-login")
    }
    def documentation = {
// 		UserLdap user =   UserLdap.find(base:"",filter:"(mail=" + springSecurityService.principal.username + ")")  
        render view: '/m-melanin-documentation'
    }
    def plugins = {
        render view: '/m-melanin-plugins'
    }
    def source = {
        render view: '/m-melanin-source'
    }
    def form = {
        render view: '/m-melanin-form'
    }
    def search = {
        render view: '/m-melanin-search'
    }

    def datagrid = {
        render view: '/data/datagrid_data' + params.id
    }
    def refresh = {
        if (springSecurityService.principal?.username.equals("__grails.anonymous.user__")) {
            render 0
        } else {
            render 1
        }
    }

    def keep_login_session = {
        if (springSecurityService.principal?.username.equals("__grails.anonymous.user__")) {
            render 0
        } else {
            render 1
        }
    }

    def ajax_login = {
        render 'abc'
    }
    def all_controller = {
        render view: '/m-melanin-all-controller'

    }

    def err_403 = {
        render view: '/errors/403'
    }

    def logout = {
        if (springSecurityService.isLoggedIn()) {
            cookieService.setCookie('role', null, 0, '/')
            cookieService.setCookie('uuid', null, 0, '/')
            def u = User.findByUsername(springSecurityService.principal.username)
            if (u) {
                u.lastLogout = new Date()
                u.save(flush: true)
            }
        }
        redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
    }
}