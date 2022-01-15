package qm

import com.melanin.commons.Conf
import com.melanin.commons.MenuItem
import com.melanin.commons.SidebarItem
import com.melanin.fingerprint.JobTitle
import com.melanin.fingerprint.Module
import com.melanin.security.Url
import com.melanin.security.UrlGroup
import grails.core.GrailsApplication

class Conf_BootStrap {
    transient springSecurityService
    GrailsApplication grailsApplication

    def init = { servletContext ->
//        return ;
        //BEGIN: CONF TABLE
        if (!Conf.findByType('welcome-text')) {
            new Conf(type: 'welcome-text', label: 'welcome-text', value: '', ord: 0, dataType: 'TEXT').save(flush: true)
        }
        if (!Conf.findByType('help-file-url')) {
            new Conf(type: 'help-file-url', label: 'help-file-url', value: 'http://intranet/help', ord: 0, dataType: 'TEXT').save(flush: true)
        }

        if (!Conf.findByType('UploadDir')) {
            new Conf(type: 'UploadDir', label: 'UploadDir', value: 'C:\\projects\\qm', ord: 0, dataType: 'TEXT').save(flush: true)
        }

        if (!Conf.findByTypeAndLabel('maxFileSize', 'uploadfile')) {
            new Conf(type: 'maxFileSize', label: 'uploadfile', value: '10000000', ord: 0, dataType: 'TEXT').save(flush: true)
        }

        if (!Conf.findByTypeAndLabel('file_upload_type_allow', 'image_type_upload_allow')) {
            new Conf(type: 'file_upload_type_allow', label: 'image_type_upload_allow', value: 'jpg,jpeg,png,pdf', ord: 0, dataType: 'TEXT').save(flush: true)
        }
        if (!Conf.findByTypeAndLabel('file_upload_type_allow', 'document_type_upload_allow')) {
            new Conf(type: 'file_upload_type_allow', label: 'document_type_upload_allow', value: 'pdf,doc,docx,ppt,pptx,pps,ppsx,xls,xlsx,zip,txt,rar', ord: 0, dataType: 'TEXT').save(flush: true)
        }
        if (!Conf.findByTypeAndLabel('Api_BotApp_Address', 'Api_BotApp_Address')) {
            new Conf(type: 'Api_BotApp_Address', label: 'Api_BotApp_Address', value: 'http://127.0.0.1:5000', ord: 0, dataType: 'TEXT').save(flush: true)
        }

        //--END

        // init JobTitle
        if (JobTitle.findByName('Manager'))
            new JobTitle(name: 'Manager').save(flush: true)
        if (JobTitle.findByName('Staff'))
            new JobTitle(name: 'Staff').save(flush: true)


        def copyright = Conf.findByLabel('copyright')
        if (!copyright) {
            def cr = new Conf(dataType: 'TEXT', label: 'copyright', ord: 0, type: 'copyright', value: '2022 Copyright by Trần Đức Soạn - D12CNPM1').save(flush: true)
        }

        // alert to be clear cache request map
        if (!Conf.findByLabel('need_to_be_clear_cacherequestmap')) {
            new Conf(type: 'need_to_be_clear_cacherequestmap (1 = clear cache)', label: 'need_to_be_clear_cacherequestmap', value: '0', ord: 0, dataType: 'TEXT').save(flush: true)
        }

        // so ngay lưu log hệ thống
        if (!Conf.findByType('soNgayLuuLog')) {
            new Conf(type: 'soNgayLuuLog', label: 'Số ngày lưu log hệ thống', value: '30', ord: 0, dataType: 'NUMBER').save(flush: true)
        }


    }

    def destroy = {
    }
}
