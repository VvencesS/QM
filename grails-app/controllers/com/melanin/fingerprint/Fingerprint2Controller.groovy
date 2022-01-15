package com.melanin.fingerprint

//import collateralmanagement.CollateralType

import com.melanin.commons.LoginCheckingController

import grails.converters.JSON
import serversidetable.ServerSideMelaninService

import java.sql.Timestamp
import java.text.SimpleDateFormat

class Fingerprint2Controller extends LoginCheckingController {
    def melaninLogService
    def LogService
    def CommonService
    def dataSource
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")

    def index() {}

    def direct_thietlapquytrinhthamso() {
        def type = params.type
        if (type == 'workflowsetup') {
            redirect(action: "workflowsetup")
        } else if (type == 'parametersmng') {
            redirect(action: "parametersmng")
        }
    }


    // -- lịch sử truy cập
    def logmng() {
        println "${actionUri}: " + new Date() + ": " + params
        render view: '/m-melanin-fingerprint/lich_su_truy_cap/MH_QT6_lichsutruycap'
    }

    def dslogss() {
        println "${actionUri}: " + new Date() + ": " + params
        try {
            //TYPE YOUR OWN CODE HERE
            StringBuilder query = new StringBuilder()
            query.append(" SELECT id, module_name, username, actionname, actiontime, action_controller, chuc_nang")
            query.append(" FROM ( SELECT lg.id, COALESCE(module_name, 'Quản trị hệ thống') module_name, username,")
            query.append("              actionname, action_controller, to_char(actiontime, 'dd/mm/yyyy hh:mi:ss') actiontime, th.chuc_nang")
            query.append("         FROM melanin_log_action lg LEFT JOIN ")
            query.append("              (SELECT u.url, m.name module_name, m.id module_id, gr.name chuc_nang")
            query.append("                 FROM  url u , url_group gr, module m")
            query.append("                WHERE u.url_group_id = gr.id")
            query.append("                  AND gr.module_id = m.id) th ON lg.action_controller = th.url")
            query.append("         WHERE 2 = 2 ")
            def whereParam = []
            if (params.user) {
                query.append(" AND lg.username like (?) ")
                whereParam.push("%"+params.user+"%")
            }
            if (params.module) {
                if(params.module=="1"){
                    query.append(" AND COALESCE(module_name, 'QTHT') = 'QTHT' ")
                }
                else {
                    query.append(" AND th.module_id = ?")
                    whereParam.push(params.module)
                }
            }
            if (params.thoigiantruycap_from) {
                query.append(" AND lg.actiontime >= STR_TO_DATE(?, '%d/%m/%Y')")
                whereParam.push(params.thoigiantruycap_from)
            }
            if (params.thoigiantruycap_to) {
                query.append(" AND lg.actiontime < STR_TO_DATE(?, '%d/%m/%Y') +1 ")
                whereParam.push(params.thoigiantruycap_to)
            }
            query.append(" ) b")
            query.append(" WHERE 1 = 1 ")
//            println query.toString()

            ServerSideMelaninService ssc = new ServerSideMelaninService()
            def listdynamic = ssc.listdynamic(query.toString(), params, dataSource, whereParam)
//            println "listdynamic: "+listdynamic
            render listdynamic as JSON

        } catch (Exception e) {
            throw e
            savelog2("", e)
        }
    }

    def logsearch() {
        println "${actionUri}: " + new Date() + ": " + params
        try {
            savelog2("Tìm kiếm lịch sử truy cập", null)
            //TYPE YOUR OWN CODE HERE
            render view: '/module_quantrihethong/MH_QT6_lichsutruycap', model: [params: params]
        } catch (Exception e) {
            savelog2("", e)
        }
    }

    def searchlog() {
        println "${actionUri}: " + new Date() + ": " + params
        try {
            melaninLogService.savelog(request, "${actionUri}", "${params}", "Tìm kiếm lịch sử truy cập", e)

            //TYPE YOUR OWN CODE HERE
            render view: '/module_quantrihethong/MH_QT6_lichsutruycap', model: [params: params]
        } catch (Exception e) {
            savelog2("searchlog", e)
        }
    }

    private savelog2(String actionname, Exception e) {
        if (!e) {
            melaninLogService.savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", "", "", "${actionUri}", "")
        } else {
            melaninLogService.savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", "", e?.getMessage() + " || " + e?.class, "${actionUri}", "ERROR")
            log.error("${request.remoteUser} || ${actionUri} || ${params} || ${request.remoteAddr} ||" + e.stackTrace)
        }
    }
}
