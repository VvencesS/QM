package com.melanin.commons

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.SpringSecurityUtils
import melanin.log.MelaninLogService

import javax.servlet.ServletContext

class DirectController extends MelaninLogService {
    SpringSecurityService springSecurityService

    /**
     * Controller dieu phoi chuyen huong truy cap trong ung dung
     */
    def index() {
        println "${actionUri}: " + new Date() + ": " + params
        if (springSecurityService.principal?.username.equals("__grails.anonymous.user__")) {
            redirect uri: '/'
            return
        } else {
            render view: "/qm/direct/index"
            return
        }
    }

    def module_danhmuchethong() {
//        println "${actionUri}: " + new Date() + ": " + params
        SidebarItem sidebar = getSidebar('DMHT')
        if (sidebar) {
            redirect(controller: sidebar.controller, action: sidebar.action)
        } else {
            render view: "/index"
        }
        return
    }

    def module_sodo() {
//        println "${actionUri}: " + new Date() + ": " + params
//        redirect(controller: 'timKiemKH', action: 'index')
        println "${actionUri}: " + new Date() + ": " + params
        SidebarItem sidebar = getSidebar('SODO')
        if (sidebar) {
            redirect(controller: sidebar.controller, action: sidebar.action)
        } else {
            render view: "/index"
        }
        return
    }

    def module_bohoso() {
        println "${actionUri}: " + new Date() + ": " + params
        SidebarItem sidebar = getSidebar('BHS_CNG')
        if (sidebar) {
            redirect(controller: sidebar.controller, action: sidebar.action)
        } else {
            render view: "/index"
        }
        return
    }


    def module_baocao() {
        println "${actionUri}: " + new Date() + ": " + params
        SidebarItem sidebar = getSidebar('BAOCAO')
        if (sidebar) {
            redirect(controller: sidebar.controller, action: sidebar.action)
        } else {
            render view: "/index"
        }
        return
    }

    def module_cophan() {
        println "${actionUri}: " + new Date() + ": " + params
        SidebarItem sidebar = getSidebar('COPHAN')
        if (sidebar) {
            redirect(controller: sidebar.controller, action: sidebar.action)
        } else {
            render view: "/index"
        }
        return
    }

    def module_cpnBhs() {
        println "${actionUri}: " + new Date() + ": " + params
        SidebarItem sidebar = getSidebar('CPN_BHS')
        if (sidebar) {
            redirect(controller: sidebar.controller, action: sidebar.action)
        } else {
            render view: "/index"
        }
        return
    }

    def downloadFileHDSD() {
        println "${actionUri}: " + new Date() + ": " + params
        try {
//            String dynamiclink = params.link
//            def path = Conf.findByLabel("UploadDir").value + dynamiclink

            ServletContext servletContext = getServletContext();
            String contextPath = servletContext.getRealPath(File.separator);
            String path = contextPath
            path += '\\template\\DocTemplate\\TNTECH_QLTS_Tai lieu huong dan su dung.docx'

            def file = new File(path)
            if (file.exists()) {
                response.setContentType("application/octet-stream")
                response.setHeader("Content-disposition", "filename=\"${file.name}\"")
                response.outputStream << file.bytes
                return
            }
        } catch (Exception e) {
            throw e
            savelog(request, "downloadFileHDSD", e)
        }
    }

    def getSidebar(def menuItemName) {
        def menuItemDMHT = MenuItem.findByName(menuItemName)
        def listSideBar = SidebarItem.findAllByMenuItem(menuItemDMHT, [sort: 'ordernumber'])
        def result
        for (sidebar in listSideBar) {
            if (sidebar.roles) {
                if (SpringSecurityUtils.ifAnyGranted(sidebar.roles)) {
                    result = sidebar
                    break;
                }
            } else {
                result = sidebar
                break;
            }
        }
        return result
    }
}
