package com.melanin.commons

import grails.converters.JSON

class SidebarController {
    def index_sidebarItem() {
        println "${actionUri}: " + new Date() + ": " + params
        render view: "/m-melanin-fingerprint/sidebar_item/index_sidebarItem"
    }

    def lay_div_DMuc_Item() {
        println "${actionUri}: " + new Date() + ": " + params
        def divCC = g.render(template: '/m-melanin-fingerprint/sidebar_item/template/div_DanhMuc')
        render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def lay_div_Update() {
        println "${actionUri}: " + new Date() + ": " + params
        def objSanPham = params.id == null ? null : SidebarItem.get(params.id)

        def divCC
        if (objSanPham != null) {
            divCC = g.render(template: '/m-melanin-fingerprint/sidebar_item/template/div_Update',
                    model: [hdr: objSanPham, edit_or_new: "edit"])
        } else {
            divCC = g.render(template: '/m-melanin-fingerprint/sidebar_item/template/div_Update',
                    model: [edit_or_new: "new"])
        }
        render(text: [divCC: divCC, hdr: objSanPham] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def add_Item() {
        println "${actionUri}: " + new Date() + ": " + params
        try {
            if (params.edit_or_new == "new") {
                def obj_sidebarItem = new SidebarItem()
                obj_sidebarItem.label = params.label
                obj_sidebarItem.menuItem = MenuItem.get(params.menuItem)
//                obj_sidebarItem.roles = params.roles
                if (params.rolez) {
                    if (params.rolez.size() > 0) {
                        def rolez = String.join(',', params.rolez);
                        obj_sidebarItem.roles = rolez
                    }
                } else {
                    obj_sidebarItem.roles = ''
                }
                obj_sidebarItem.ordernumber = Double.valueOf(params.ordernumber)
                obj_sidebarItem.controller = params.controller_input
                obj_sidebarItem.action = params.action_input
                if (params.icon) {
                    obj_sidebarItem.icon = params.icon
                }
                obj_sidebarItem.htmlElementId = params.htmlElementId
                obj_sidebarItem.save(flush: true, failOnError: true);
                render(text: [success: true, msg: "1 Sidebar Item được thêm mới thành công!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            } else {
                def obj_sidebarItem = SidebarItem.get(params.hdrId)
                obj_sidebarItem.label = params.label
//                obj_sidebarItem.roles = params.roles
                if (params.rolez) {
                    if (params.rolez.size() > 0) {
                        def rolez = String.join(',', params.rolez);
                        obj_sidebarItem.roles = rolez
                    }
                } else {
                    obj_sidebarItem.roles = ''
                }
                obj_sidebarItem.ordernumber = Double.valueOf(params.ordernumber)
                obj_sidebarItem.icon = params.icon ? params.icon : 'icon-list'
                obj_sidebarItem.save(flush: true, failOnError: true)
                render(text: [success: true, msg: "Cập nhật Sidebar Item thành công!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            }
        } catch (Exception e) {
//            throw e
            render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
        }
    }

    def delete_Item() {
        def obj_sidebarItem = SidebarItem.get(params.id)
        if (obj_sidebarItem) {
            try {
                obj_sidebarItem.delete(flush: true, failOnError: true)
                render(text: [success: true, msg: "Xóa thành công 1 sidebar item!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            }
            catch (Exception e) {
                render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            }
        }
    }
}