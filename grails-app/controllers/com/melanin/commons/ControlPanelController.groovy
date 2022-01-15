package com.melanin.commons

class ControlPanelController {

    def index = {
        println "${actionUri}: " + new Date() + ": " + params
        redirect(controller: 'conf', action: 'list')
        return
//		render view:'/m-melanin-control-panel/m-melanin-control-panel'
    }


}
