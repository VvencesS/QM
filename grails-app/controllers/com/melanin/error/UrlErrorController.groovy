package com.melanin.error

import grails.converters.JSON
import melanin.log.MelaninLogService

class UrlErrorController extends MelaninLogService {
    def notFound() {
//        println "${actionUri}: " + new Date() + ": " + params
        if ("${actionUri}".indexOf('/api/') >= 0) {
            render(text: [status : 404,
                          error  : 'notFound',
                          message: 'Đường link bạn cần tìm không tồn tại.'] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } else {
            render view: '/errors/404'
        }
    }

    def error() {
//        println "${actionUri}: " + new Date() + ": " + params
        if ("${actionUri}".indexOf('/api/') >= 0) {
            render(text: [status : 500,
                          error  : 'error',
                          message: 'Lỗi hệ thống.'] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } else {
            render view: '/errors/500'
        }
    }

    def forbidden() {
        println "${actionUri}: " + new Date() + ": " + params
        println "${actionUri}".indexOf('/api/')
        if ("${actionUri}".indexOf('/api/') >= 0 || "${actionUri}".indexOf('/null/forbidden') >= 0) {
            render(text: [status : 403,
                          error  : 'Access forbidden',
                          message: 'Truy cập bị cấm'] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } else {
            render view: '/errors/403'
        }
    }
}
