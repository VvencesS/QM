package qm

import com.melanin.commons.MenuItem
import com.melanin.commons.SidebarItem
import com.melanin.fingerprint.Module
import com.melanin.security.Url
import com.melanin.security.UrlGroup
import grails.core.GrailsApplication

class QM_BootStrap {
    transient springSecurityService
    GrailsApplication grailsApplication

    def init = { servletContext ->
        //add module
        def modules = [
                ['TK', 'Thống kê'],
                ['CH_TL', 'Câu hỏi & trả lời'],
                ['NHAN', 'Nhãn'],
                ['HUAN_LUYEN', 'Huấn luyện và thực nghiệm'],
        ]

        modules.each {
            if (!Module.findByCode(it[0])) {
                def m = new Module(code: it[0], name: it[1]).save(flush: true)
            }
        }

        //init MenuItems
        def dataMenuItem = [
                [name: 'TK', controller: 'thongKe', action: 'index_ThongKe', title: 'Nhấn để vào menu Thống kê', label: 'Thống kê', roles: 'ROLE_MANAGER,ROLE_NHANVIEN', ordernumber: 1],
                [name: 'NHAN', controller: 'nhan', action: 'index_Nhan', title: 'Nhấn để vào menu Nhãn', label: 'Nhãn', roles: 'ROLE_MANAGER,ROLE_NHANVIEN', ordernumber: 2],
                [name: 'CH_TL', controller: 'cauHoiVaTraLoi', action: 'index_CauHoiVaTraLoi', title: 'Nhấn để vào menu Câu hỏi & trả lời', label: 'Câu hỏi & trả lời', roles: 'ROLE_MANAGER,ROLE_NHANVIEN', ordernumber: 3],
                [name: 'HUAN_LUYEN', controller: 'huanLuyenVaThucNghiem', action: 'index_HuanLuyenVaThucNghiem', title: 'Nhấn để vào menu Huấn luyện và thực nghiệm', label: 'Huấn luyện và thực nghiệm', roles: 'ROLE_MANAGER,ROLE_NHANVIEN', ordernumber: 4],
        ]

        dataMenuItem.each {
            if (!MenuItem.findByName(it.name)) {
                new MenuItem(name: it.name, controller: it.controller, action: it.action, title: it.title, label: it.label, roles: it.roles, ordernumber: it.ordernumber).save(flush: true)
            }
        }
        //End: init MenuItems

        //Begin: init Sidebar
        //['tên MenuItem','Nội dung hiển thị','Role được truy cập','Số thự tự hiển thị','Tên Controler','Tên Action','URL_Param','Level','Item Cha','ID của element','Icon']
//        def dataSideBars = [
//                [menuItem: 'TK', label: 'Thống kê', roles: '', ordernumber: 1, controller: 'thongKe', action: 'index', urlParam: null, level: 1, parentItemName: null, htmlElementId: 'sidebarThongKe', icon: 'icon-user'],
//                [menuItem: 'QA', label: 'Q&A', roles: '', ordernumber: 1, controller: 'quanLyQA', action: 'index', urlParam: null, level: 1, parentItemName: null, htmlElementId: 'sidebarQuanLyQA', icon: 'icon-user'],
//                [menuItem: 'NHAN', label: 'Nhãn', roles: '', ordernumber: 1, controller: 'quanLyNhan', action: 'index', urlParam: null, level: 1, parentItemName: null, htmlElementId: 'sidebarQuanLyNhan', icon: 'icon-user'],
//                [menuItem: 'GANNHAN', label: 'Gán nhãn', roles: '', ordernumber: 1, controller: 'ganNhan', action: 'index', urlParam: null, level: 1, parentItemName: null, htmlElementId: 'sidebarGanNhan', icon: 'icon-user'],
//
//        ]
//
//        dataSideBars.each {
//            def menuItem = MenuItem.findByName(it.menuItem)
//            if (menuItem) {
//                if (!SidebarItem.findByHtmlElementId(it.htmlElementId)) {
//                    def sidebar = new SidebarItem(menuItem: menuItem, label: it.label, roles: it.roles,
//                            ordernumber: it.ordernumber, controller: it.controller, action: it.action, urlParam: it.urlParam,
//                            level: it.level, parentItemName: it.parentItemName, htmlElementId: it.htmlElementId, icon: it.icon).save(flush: true)
//                    if (it.parentItemName) {
//                        def parentSideBar = SidebarItem.findByHtmlElementId(it.parentItemName)
//                        if (parentSideBar) {
//                            sidebar.parentItem = parentSideBar
//                        }
//                    }
//                }
//            }
//        }
        //End: init Sidebar

        //Begin: init Sidebar
        //['tên MODULE','Tên chức năng','Tên hành động','url']
        def dataUrl = [
                ['TK', 'Thống kê', 'Chức năng Thống kê', '/thongKe/index_ThongKe'],
                ['TK', 'Thống kê', 'Chức năng Thống kê', '/thongKe/mostAskedTopicChart'],
                ['TK', 'Thống kê', 'Chức năng Thống kê', '/thongKe/foundResultsChart'],
                ['TK', 'Thống kê', 'Chức năng Thống kê', '/thongKe/numberOfQuestionsInAPeriod'],

                ['NHAN', 'Nhãn', 'Nhãn', '/nhan/index_Nhan'],
                ['NHAN', 'Nhãn', 'Nhãn', '/nhan/layDivDMNhan'],
                ['NHAN', 'Nhãn', 'Nhãn', '/nhan/layDivCRUDNhan'],
                ['NHAN', 'Nhãn', 'Nhãn', '/nhan/crudNhan'],

                ['CH_TL', 'Câu hỏi & trả lời', 'Chức năng Câu hỏi & trả lời', '/cauHoiVaTraLoi/index_CauHoiVaTraLoi'],
                ['CH_TL', 'Câu hỏi & trả lời', 'Chức năng Câu hỏi & trả lời', '/cauHoiVaTraLoi/layDmCauHoiVaTraLoi'],
                ['CH_TL', 'Câu hỏi & trả lời', 'Chức năng Câu hỏi & trả lời', '/cauHoiVaTraLoi/layDivDMCauHoiVaTraLoi'],
                ['CH_TL', 'Câu hỏi & trả lời', 'Chức năng Câu hỏi & trả lời', '/cauHoiVaTraLoi/layDsDuLieuCauHoi_TraLoi'],
                ['CH_TL', 'Câu hỏi & trả lời', 'Chức năng Câu hỏi & trả lời', '/cauHoiVaTraLoi/crudCauHoiVaTraLoi'],
                ['CH_TL', 'Câu hỏi & trả lời', 'Chức năng Câu hỏi & trả lời', '/cauHoiVaTraLoi/exportTemplateExcel'],
                ['CH_TL', 'Câu hỏi & trả lời', 'Chức năng Câu hỏi & trả lời', '/cauHoiVaTraLoi/importExcel'],

                ['HUAN_LUYEN', 'Huấn luyện và thực nghiệm', 'Huấn luyện và thực nghiệm', '/HuanLuyenVaThucNghiem/index_HuanLuyenVaThucNghiem'],
                ['HUAN_LUYEN', 'Huấn luyện và thực nghiệm', 'Huấn luyện và thực nghiệm', '/HuanLuyenVaThucNghiem/getBotResponse'],
                ['HUAN_LUYEN', 'Huấn luyện và thực nghiệm', 'Huấn luyện và thực nghiệm', '/HuanLuyenVaThucNghiem/deleteLearnedData'],
                ['HUAN_LUYEN', 'Huấn luyện và thực nghiệm', 'Huấn luyện và thực nghiệm', '/HuanLuyenVaThucNghiem/writeDataToFile'],
                ['HUAN_LUYEN', 'Huấn luyện và thực nghiệm', 'Huấn luyện và thực nghiệm', '/HuanLuyenVaThucNghiem/trainingBot'],

        ]

        dataUrl.each {
            Module obj_module = Module.findByCode(it[0])
            UrlGroup obj_urlgroup = UrlGroup.findByNameAndUsecasenameAndModule(it[2], it[1], obj_module)
            if (!obj_urlgroup) {
                def m = new UrlGroup(name: it[2], usecasename: it[1], usecase: null, module: obj_module).save(flush: true)
                obj_urlgroup = m
            }
            Url obj_url = Url.findByUrl(it[3])
            if (!obj_url) {
                def u = new Url(url: it[3], urlGroup: obj_urlgroup, canbedeleted: false).save(flush: true)
            }
        }
        //End: init Sidebar
        
    }

    def destroy = {
    }
}
