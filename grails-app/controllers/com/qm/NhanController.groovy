package com.qm

import com.commons.Constant
import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import org.springframework.beans.factory.annotation.Autowired
import serversidetable.ServerSideMelaninService

import javax.sql.DataSource

class NhanController {
    SpringSecurityService springSecurityService

    @Autowired
    DataSource dataSource
    def dmsCommonService

    def index_Nhan() {
        println "${actionUri}: " + new Date() + ": " + params
        render view: "/qm/nhan/index_nhan"
    }

    def layDivDMNhan() {
        println "${actionUri}: " + new Date() + ": " + params

        def divCC = g.render(template: '/qm/nhan/div_dm_nhan')
        render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def taoTenFileChoNhan(String maNhan, QmNhan parentItem) {
        println "${actionUri}: " + new Date() + ": " + params

        String tenFileCuaNhan = maNhan
        if (parentItem) {
            tenFileCuaNhan = parentItem.maNhan + "_" + tenFileCuaNhan
            if (parentItem.parentItem) {
                tenFileCuaNhan = parentItem.parentItem.maNhan + "_" + tenFileCuaNhan
            }
        }
        return tenFileCuaNhan
    }

    def layDivCRUDNhan() {
        println "${actionUri}: " + new Date() + ": " + params

        QmNhan nhan = null
        ArrayList<QmNhan> nhanArrayList = []
        String crud = Constant.CRUD_1000
        if (params?.crud && params?.crud?.equals(Constant.CRUD_0100)) {
            nhan = params?.id ? QmNhan.get(params?.id) : null
            crud = Constant.CRUD_0010
            nhanArrayList = QmNhan.findAllByMaNhanNotEqual(nhan?.maNhan)
        } else {
            nhanArrayList = QmNhan.findAll()
        }
        def divCC = g.render(template: '/qm/nhan/div_crud_nhan', model: [hdr: nhan, nhanArrayList: nhanArrayList, crud: crud])
        render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def crudNhan() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            QmNhan nhan = null
            String crud = params?.crud ? params?.crud : ''
            if (crud && crud.equals(Constant.CRUD_1000)) {
                ArrayList<QmNhan> nhanArrayList = QmNhan.findAllByMaNhan(params?.maNhan)
                if (nhanArrayList.size() == 0) {
                    LinkedHashMap mapNhan = [
                            maNhan        : params?.maNhan,
                            tenNhan       : params?.tenNhan,
                            tenFileCuaNhan: taoTenFileChoNhan(params?.maNhan, QmNhan.get(params?.parentItem)),
                            parentItem    : params?.parentItem,
                            level         : QmNhan.get(params?.parentItem) ? QmNhan.get(params?.parentItem)?.level + 1 : 1,
                    ]
                    nhan = new QmNhan(mapNhan)
                    nhan.save(flush: true, failOnError: true)
                    render(text: [success: true, msg: "Thao tác thành công!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
                } else {
                    render(text: [warning: true, msg: "Trùng mã Nhãn!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
                }
            } else if (crud && crud.equals(Constant.CRUD_0010)) {
                nhan = params?.hdrId ? QmNhan.get(params?.hdrId) : null
                if (nhan) {
                    ArrayList<QmNhan> nhanArrayList = QmNhan.findAllByMaNhan(params?.maNhan)
                    if (nhanArrayList.size() == 0 || (nhanArrayList.size() == 1 && nhanArrayList[0].id == Long.parseLong(params?.hdrId))) {
                        nhan.maNhan = params?.maNhan
                        nhan.tenNhan = params?.tenNhan
                        nhan.tenFileCuaNhan = taoTenFileChoNhan(params?.maNhan, QmNhan.get(params?.parentItem))
                        nhan.parentItem = QmNhan.get(params?.parentItem)
                        nhan.level = QmNhan.get(params?.parentItem) ? QmNhan.get(params?.parentItem)?.level + 1 : 1
                        nhan.save(flush: true, failOnError: true)
                        render(text: [success: true, msg: "Thao tác thành công!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
                    } else {
                        render(text: [warning: true, msg: "Trùng mã nhãn!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
                    }
                } else {
                    render(text: [warning: true, msg: "Không tìm thấy bản ghi!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
                }
            } else if (crud && crud.equals(Constant.CRUD_0001)) {
                nhan = params?.hdrId ? QmNhan.get(params?.hdrId) : null
                if (nhan) {
                    ArrayList<QmCauTraLoi> cauTraLoiArrayList = QmCauTraLoi.findAllByNhan(nhan)
                    ArrayList<QmNhan> nhanArrayList = QmNhan.findAllByParentItem(nhan)
                    if (cauTraLoiArrayList.size() == 0 && nhanArrayList == 0) {
                        nhan.delete(flush: true, failOnError: true)
                        render(text: [success: true, msg: "Thao tác thành công!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
                    } else {
                        render(text: [warning: true, msg: "Bản ghi có bản ghi con!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
                    }
                } else {
                    render(text: [warning: true, msg: "Không tìm thấy bản ghi!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
                }
            }

        } catch (Exception e) {
            render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            e.printStackTrace()
        }
    }
}
