package com.qm

import com.commons.Constant
import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.poifs.filesystem.POIFSFileSystem
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.grails.web.json.JSONArray
import org.springframework.beans.factory.annotation.Autowired
import serversidetable.ServerSideMelaninService

import javax.sql.DataSource

class CauHoiVaTraLoiController {
    SpringSecurityService springSecurityService

    @Autowired
    DataSource dataSource
    def dmsCommonService
    def exportExcelService
    def qmExcelService

    def index_CauHoiVaTraLoi() {
        println "${actionUri}: " + new Date() + ": " + params
        render view: "/qm/cauHoiVaTraLoi/index_cauHoiVaTraLoi"
    }

    def layDmCauHoiVaTraLoi() {
        println "${actionUri}: " + new Date() + ": " + params

        def whereParam = []
        StringBuilder query = new StringBuilder()
        query.append("""""")
        query.append("""
             SELECT tl.map_nhan, ch.cau_hoi, tl.tra_loi, ch.id
             FROM qm_cau_hoi ch,
                  qm_cau_tra_loi tl
             WHERE ch.tra_loi_id = tl.id     
        """)
        ServerSideMelaninService ssc = new ServerSideMelaninService()
        def result = ssc.query(query.toString(), whereParam, dataSource)
        return result
    }

    def filterDMCauHoiVaTraLoi(String nhans_search, cauHoiVaTraLoiList) {
        println "${actionUri}: " + new Date() + ": " + params

        def result = []
        def map_nhans_search = nhans_search.split(",")
        for (int i1 = 0; i1 < cauHoiVaTraLoiList.size(); i1++) {
            def map_nhans_CH_TL = cauHoiVaTraLoiList[i1]?.map_nhan.split(",")
            for (int i2 = 0; i2 < map_nhans_search.size(); i2++) {
                def maNhan = map_nhans_search[i2]
                if (map_nhans_CH_TL.contains(maNhan)) {
                    result.push(cauHoiVaTraLoiList[i1])
                    break
                }
            }
        }
        return result
    }

    def layDivDMCauHoiVaTraLoi() {
        println "${actionUri}: " + new Date() + ": " + params

        def cauHoiVaTraLoiList = layDmCauHoiVaTraLoi()
        if (params?.nhans_search) {
            cauHoiVaTraLoiList = filterDMCauHoiVaTraLoi(params?.nhans_search, cauHoiVaTraLoiList)
        }

        def divCC = g.render(template: '/qm/cauHoiVaTraLoi/div_dm_cauHoiVaTraLoi', model: [cauHoiVaTraLoiList: cauHoiVaTraLoiList])
        render(text: [divCC: divCC] as JSON, contentType: 'text/json', encoding: "UTF-8")
    }

    def layDsNhapMoiSua(dataDsCH_TL) {
        println "${actionUri}: " + new Date() + ": " + params
        try {
            def dataDsCH_TL_NhapMoi = []
            def dataDsCH_TL_Sua = []

            for (int i1 = 0; i1 < dataDsCH_TL.size(); i1++) {
                def objCH_TL = dataDsCH_TL[i1]

                if (objCH_TL?.newRow instanceof String && objCH_TL?.updateRow != 1) {
                    dataDsCH_TL_NhapMoi.push(objCH_TL)
                } else if (objCH_TL?.newRow instanceof String && objCH_TL?.updateRow == 1) {
                    dataDsCH_TL_Sua.push(objCH_TL)
                }
            }
            return [dataDsCH_TL_NhapMoi: dataDsCH_TL_NhapMoi, dataDsCH_TL_Sua: dataDsCH_TL_Sua]
        } catch (Exception e) {
            render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            e.printStackTrace()
        }
    }

    def layDsDuLieuCauHoi_TraLoi() {
        println "${actionUri}: " + new Date() + ": " + params
        try {
            def result = []
            def dataDsCH_TL = []
            def mapNhan
            boolean error = false
            String msg = ''

            if (params?.hdrId) {
                QmCauHoi cauHoi = QmCauHoi.get(params?.hdrId)
                if (cauHoi) {
                    QmCauTraLoi cauTraLoi = cauHoi?.traLoi
                    mapNhan = cauTraLoi?.mapNhan
                    def dataCH_TL = [
                            newRow     : -1,
                            cauHoiId   : cauHoi?.id,
                            cauTraLoiId: cauTraLoi?.id,
                            updateRow  : -1,
                            cauHoi     : cauHoi?.cauHoi,
                            cauTraLoi  : cauTraLoi?.traLoi,
                    ]
                    dataDsCH_TL.push(dataCH_TL)
                    msg = 'Thao tác thành công!'
                } else {
                    error = true
                    msg = 'Không tìm thấy bản ghi!'
                }
            } else if (params?.mapNhan) {
                ArrayList<QmCauTraLoi> cauTraLoi_result = []
                mapNhan = params?.mapNhan
                def nhanArrrayList = params?.mapNhan.split(",")
                ArrayList<QmCauTraLoi> cauTraLoiArrayList = QmCauTraLoi.findAll()
                cauTraLoiArrayList.each {
                    boolean check1 = true
                    boolean check2 = true
                    def _mapNhan = it.mapNhan.split(",")
                    for (int i1 = 0; i1 < _mapNhan.size(); i1++) {
                        if (!nhanArrrayList.contains(_mapNhan[i1])) {
                            check1 = false
                            break
                        }
                    }
                    for (int i1 = 0; i1 < nhanArrrayList.size(); i1++) {
                        if (!_mapNhan.contains(nhanArrrayList[i1])) {
                            check2 = false
                            break
                        }
                    }
                    if (check1 && check2) {
                        cauTraLoi_result.push(it)
                    }
                }
                if (cauTraLoi_result.size() > 0) {
                    cauTraLoi_result.each {
                        QmCauHoi cauHoi = QmCauHoi.findByTraLoi(it)
                        def dataCH_TL = [
                                newRow     : -1,
                                cauHoiId   : cauHoi?.id,
                                cauTraLoiId: it?.id,
                                updateRow  : -1,
                                cauHoi     : cauHoi?.cauHoi,
                                cauTraLoi  : it?.traLoi,
                        ]
                        dataDsCH_TL.push(dataCH_TL)
                    }
                    error = false
                    msg = 'Thao tác thành công!'
                } else {
                    error = true
                    msg = 'Không tìm thấy bản ghi!'
                }

            }
            result = [
                    error      : error,
                    msg        : msg,
                    nhans      : mapNhan,
                    dataDsCH_TL: dataDsCH_TL
            ]
            render result as JSON
        } catch (Exception e) {
            render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            e.printStackTrace()
        }
    }

    def getNhanArrayList(maNhanArrayList) {
        def nhanArrayList = []
        for (int i1 = 0; i1 < maNhanArrayList.size(); i1++) {
            QmNhan nhan = QmNhan.findByMaNhan(maNhanArrayList[i1])
            nhanArrayList.push(nhan)
        }
        return nhanArrayList
    }

    def getMaxLevelNhan(nhanArrayList) {
        QmNhan maxLevelNhan = null

        if (nhanArrayList.size() == 1) {
            maxLevelNhan = nhanArrayList[0]
        } else if (nhanArrayList.size() > 1) {
            maxLevelNhan = nhanArrayList[0]
            for (int i1 = 1; i1 < nhanArrayList.size(); i1++) {
                if (maxLevelNhan != null && nhanArrayList[i1] != null) {
                    if (maxLevelNhan.level < nhanArrayList[i1].level) {
                        maxLevelNhan = nhanArrayList[i1]
                    }
                }
            }
        }
        return maxLevelNhan
    }

    def createDsCauHoiVaTraLoi(dataDsCH_TL, QmNhan maxLevelNhan, objNhan) {
        println "${actionUri}: " + new Date() + ": " + params

        for (int i1 = 0; i1 < dataDsCH_TL.size(); i1++) {
            def objCH_TL = dataDsCH_TL[i1]
            QmCauTraLoi cauTraLoi = new QmCauTraLoi(traLoi: objCH_TL?.cauTraLoi, nhan: maxLevelNhan, mapNhan: objNhan?.nhans)
            QmCauHoi cauHoi = new QmCauHoi(cauHoi: objCH_TL?.cauHoi, traLoi: cauTraLoi)

            cauTraLoi.save(flush: true, failOnError: true)
            cauHoi.save(flush: true, failOnError: true)
        }
    }

    def updateDsCauHoiVaTraLoi(dataDsCH_TL, QmNhan maxLevelNhan, objNhan) {
        println "${actionUri}: " + new Date() + ": " + params

        for (int i1 = 0; i1 < dataDsCH_TL.size(); i1++) {
            def objCH_TL = dataDsCH_TL[i1]
            QmCauHoi cauHoi = QmCauHoi.get(objCH_TL?.cauHoiId)
            QmCauTraLoi cauTraLoi = QmCauTraLoi.get(objCH_TL?.cauTraLoiId)

            cauTraLoi.traLoi = objCH_TL?.cauTraLoi
            cauTraLoi.nhan = maxLevelNhan
            cauTraLoi.mapNhan = objNhan?.nhans

            cauHoi.cauHoi = objCH_TL?.cauHoi

            cauTraLoi.save(flush: true, failOnError: true)
            cauHoi.save(flush: true, failOnError: true)
        }
    }

    def deleteDsCauHoiVaTraLoi(data) {
        println "${actionUri}: " + new Date() + ": " + params

        if (data) {
            if (data instanceof JSONArray) {
                for (int i1 = 0; i1 < data.size(); i1++) {
                    deleteCauHoiVaTraLoi(data?.cauHoiId)
                }
            } else {
                deleteCauHoiVaTraLoi(data)
            }
        }
    }

    def deleteCauHoiVaTraLoi(hdrId) {
        println "${actionUri}: " + new Date() + ": " + params

        QmCauHoi cauHoi = QmCauHoi.get(hdrId)
        if (cauHoi) {
            QmCauTraLoi cauTraLoi = cauHoi?.traLoi
            ArrayList<QmCauHoi> cauHoiArrayList = QmCauHoi.findAllByTraLoi(cauTraLoi)
            boolean checkDelete = cauHoiArrayList.size() == 1 ? true : false
            cauHoi.delete(flush: true, failOnError: true)
            if (checkDelete) {
                cauTraLoi.delete(flush: true, failOnError: true)
            }
        }
    }

    def crudCauHoiVaTraLoi() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            String crud = params?.crud ? params?.crud : ''
            QmNhan nhan = null
            QmCauHoi cauHoi = null
            QmCauTraLoi cauTraLoi = null
            def objNhan = params?.objNhan ? JSON.parse(params?.objNhan) : []
            def maNhanArrayList = (objNhan.size() > 0 && objNhan?.nhans) ? objNhan?.nhans?.split(",") : []
            def nhanArrayList = []
            QmNhan maxLevelNhan = null
            def dataDsCH_TL = params?.dataDsCH_TL ? JSON.parse(params?.dataDsCH_TL) : []

            nhanArrayList = getNhanArrayList(maNhanArrayList)
            maxLevelNhan = getMaxLevelNhan(nhanArrayList)

            if (objNhan?.editOrView.equals('create')) {
                createDsCauHoiVaTraLoi(dataDsCH_TL, maxLevelNhan, objNhan)
            } else if (objNhan?.editOrView.equals('edit')) {
                def dataDsCH_TL_Sua = layDsNhapMoiSua(dataDsCH_TL)?.dataDsCH_TL_Sua
                def dataDsCH_TL_NhapMoi = layDsNhapMoiSua(dataDsCH_TL)?.dataDsCH_TL_NhapMoi
                def dataDsCH_TLXoa = JSON.parse(params?.dataDsCH_TLXoa)

                createDsCauHoiVaTraLoi(dataDsCH_TL_NhapMoi, maxLevelNhan, objNhan)
                updateDsCauHoiVaTraLoi(dataDsCH_TL_Sua, maxLevelNhan, objNhan)
                deleteDsCauHoiVaTraLoi(dataDsCH_TLXoa)
            } else {
                if (crud && crud.equals(Constant.CRUD_0001)) {
                    deleteCauHoiVaTraLoi(params?.hdrId)
                }
            }
            render(text: [success: true, msg: "Thao tác thành công!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } catch (Exception e) {
            render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            e.printStackTrace()
        }
    }

    def exportTemplateExcel() {
        println "${actionUri}: " + new Date() + ": " + params

        String filename = 'template_CauHoiVaTraLoi.xlsx'
        String path = getServletContext().getRealPath(File.separator)
        path += '\\template\\ExcelTemplate\\template_CauHoiVaTraLoi.xlsx'
        InputStream inp = new FileInputStream(path)
        String fileExtn = exportExcelService.GetFileExtension(path)
        Workbook wb //Declare XSSF WorkBook
        Sheet sheet = null // sheet can be used as common for XSSF and HSSF
        if (fileExtn.equalsIgnoreCase("xlsx")) {
            wb = new org.apache.poi.xssf.usermodel.XSSFWorkbook(inp)
        } else if (fileExtn.equalsIgnoreCase("xls")) {
            wb = new HSSFWorkbook(new POIFSFileSystem(inp))
        }

        exportExcelService.exportExcel(filename, wb, response)
        System.out.println("EXPORT EXCEL SUCCESSFULL!!!!");
        return
    }

    def importExcel() {
        println "${actionUri}: " + new Date() + ": " + params

        def file = params.file
        def fileName = file.filename
        def fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length())
        def workbook
        if (fileExtension == "xls") {
            workbook = new HSSFWorkbook(file.getInputStream())
        } else if (fileExtension == "xlsx") {
            workbook = new XSSFWorkbook(file.getInputStream())
        } else {
            render(text: [result: 'error', message: 'File không phải định dạng Excel!'] as JSON, contentType: 'text/json', encoding: "UTF-8")
            return
        }
        def sheet = workbook.getSheetAt(0)
        def ds_quyDoiTenCot = [
                [tenThuocTinh: 'cauHoi', tenCot: 'Câu hỏi', batBuoc: 1, kieuDuLieu: ''],
                [tenThuocTinh: 'cauTraLoi', tenCot: 'Trả lời', batBuoc: 1, kieuDuLieu: ''],
        ]
        def ds_cotDomainClass = [
        ]
        def danhSachLoi = []
        def data_viTriCell = qmExcelService.docFileExcelImport_buoc1(sheet, 2, ds_quyDoiTenCot)
        ArrayList data_import = qmExcelService.docFileExcelImport_buoc2(data_viTriCell, ds_quyDoiTenCot, ds_cotDomainClass, danhSachLoi)
        data_import = qmExcelService.docFileExcelImport_buoc5(data_import, data_viTriCell, ds_quyDoiTenCot, ds_cotDomainClass, danhSachLoi, actionUri)
        qmExcelService.docFileExcelImport_buoc3(data_import, "")
//        qmExcelService.docFileExcelImport_buoc4(data_import)

        def ketQua = [danhSachLoi: danhSachLoi, data_import: data_import]
        render ketQua as JSON
    }
}