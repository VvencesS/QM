package qm

import grails.plugin.springsecurity.SpringSecurityService
import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.CellType
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Sheet
import org.grails.web.util.WebUtils

class QmExcelService {
    SpringSecurityService springSecurityService
    def grailsApplication

    def docFileExcelImport_buoc1(Sheet sheet, int intHeadRow, def ds_quyDoiTenCot) {

        def ds_tenCot = []
        def data_viTriCell = []
        for (cell in sheet.getRow(intHeadRow).cellIterator()) {
            ds_tenCot << [viTriCot: cell.columnIndex, tenCot: cell.stringCellValue]
        }

        for (Row row in sheet.rowIterator()) {
            if (row.rowNum <= 3) {
                continue
            }
            //kiểm tra dòng blank
            def cellChuaDuLieu = row.cellIterator().find { cell -> cell.cellType.name() != 'BLANK' }
            if (!cellChuaDuLieu) {
                continue
            }
            def dataRow1 = [:]
            dataRow1.viTriDong = row.rowNum
            for (cell in row.cellIterator()) {

                def tenCot = ds_tenCot.find { it.viTriCot == cell.columnIndex }
                tenCot = tenCot.tenCot
                def tenThuocTinh = ds_quyDoiTenCot.find { it.tenCot == tenCot }
                tenThuocTinh = tenThuocTinh?.tenThuocTinh
                if (tenThuocTinh) {
                    dataRow1[tenThuocTinh] = cell
                }
            }

            data_viTriCell.add(dataRow1)
        }
        return data_viTriCell
    }

    def docFileExcelImport_buoc2(def data_viTriCell, def ds_quyDoiTenCot, def ds_cotDomainClass, def danhSachLoi) {
        def data_import = []
        for (LinkedHashMap row in data_viTriCell) {
            LinkedHashMap rowKetQua = [:]
            rowKetQua.viTriDong = row.viTriDong
            for (def entry in row) {
                if (entry.key == 'viTriDong') {
                    continue
                }
                Cell cell = entry.value
                def giaTri1, giaTri2 = null;
                def obj_quyDoiTenCot = ds_quyDoiTenCot.find { it.tenThuocTinh == entry.key }

                if (cell.cellType.name() == 'STRING') {
                    giaTri1 = cell.stringCellValue
                } else if (cell.cellType.name() == 'BLANK') {
                    giaTri1 = null
                } else if (cell.cellType.name() == 'NUMERIC') {
                    if (obj_quyDoiTenCot.kieuDuLieu == 'Date') {
                        giaTri1 = cell.dateCellValue.format('dd/MM/yyyy')
                    } else {
                        cell.cellType = CellType.STRING
                        giaTri1 = cell.stringCellValue
                    }
                }
                rowKetQua += [(entry.key): giaTri1]

                continue
                if (obj_quyDoiTenCot.batBuoc && !giaTri1) {
                    danhSachLoi.add("Nội dung ô ${cell.address} không được bỏ trống")
                }
                if (obj_quyDoiTenCot.kieuDuLieu in ['Integer', 'BigDecimal', 'Date', 'domainClass']) {
                    if (giaTri1) {
                        try {
                            giaTri2 = obj_quyDoiTenCot.kieuDuLieu == 'Integer' ? Integer.parseInt(giaTri1) :
                                    obj_quyDoiTenCot.kieuDuLieu == 'BigDecimal' ? new BigDecimal(giaTri1) :
                                            obj_quyDoiTenCot.kieuDuLieu == 'Date' ? Date.parse('dd/MM/yyyy', giaTri1) :
                                                    null
                        } catch (e) {
                            giaTri2 = null
                            danhSachLoi.add("Dữ liệu trong ô ${cell.address} bị lỗi")
                        }
                        if (obj_quyDoiTenCot.kieuDuLieu == 'domainClass') {
                            Integer int1 = giaTri1.indexOf(" - ")
                            giaTri1 = (int1 == -1) ? giaTri1 : giaTri1.substring(0, int1)

                            def obj2 = ds_cotDomainClass.find { it.tenThuocTinh == entry.key }
                            def strTenDomain = obj2.tenDomain.name
                            strTenDomain = strTenDomain.split("\\.")
                            strTenDomain = strTenDomain[strTenDomain.length - 1]
                            giaTri2 = obj2.tenDomain.find("from $strTenDomain where ${obj2.cotTimKiem} = :giaTri1 order by id desc " as String, [giaTri1: giaTri1])
                            if (!giaTri2) {
                                danhSachLoi.add("Dữ liệu trong ô ${cell.address} bị lỗi")
                            }
                        }
                    }
                    rowKetQua += [(entry.key): giaTri2]
                } else {
                    rowKetQua += [(entry.key): giaTri1]
                }
            }

            data_import.add(rowKetQua)
        }
        return data_import
    }

    def docFileExcelImport_buoc5(ArrayList data_import, data_viTriCell, ds_quyDoiTenCot, ds_cotDomainClass, def danhSachLoi, actionUri = null) {
        for (int i1 = 0; i1 < data_import.size(); i1++) {
            LinkedHashMap row = data_import[i1]
            def row_chuaCell = data_viTriCell.find { it.viTriDong == row.viTriDong }

            for (def entry in row) {
                if (entry.key == 'viTriDong') {
                    continue
                }
                def cell = row_chuaCell[entry.key]
                def giaTri1 = entry.value
                def giaTri2 = null;
                def obj_quyDoiTenCot = ds_quyDoiTenCot.find { it.tenThuocTinh == entry.key }

                if (obj_quyDoiTenCot.batBuoc && !giaTri1) {
                    danhSachLoi.add("Nội dung ô ${cell.address} không được bỏ trống")
                }
                if (obj_quyDoiTenCot.kieuDuLieu in ['Integer', 'BigDecimal', 'Date', 'domainClass']) {
                    if (giaTri1) {
                        try {
                            giaTri2 = obj_quyDoiTenCot.kieuDuLieu == 'Integer' ? Integer.parseInt(giaTri1) :
                                    obj_quyDoiTenCot.kieuDuLieu == 'BigDecimal' ? new BigDecimal(giaTri1) :
                                            obj_quyDoiTenCot.kieuDuLieu == 'Date' ? Date.parse('dd/MM/yyyy', giaTri1) :
                                                    null
                        } catch (e) {
                            giaTri2 = null
                            danhSachLoi.add("Dữ liệu trong ô ${cell.address} bị lỗi")
                        }
                        if (obj_quyDoiTenCot.kieuDuLieu == 'domainClass') {
                            Integer int2 = giaTri1.indexOf(" - ")
                            giaTri1 = (int2 == -1) ? giaTri1 : giaTri1.substring(0, int2)

                            def obj2 = ds_cotDomainClass.find { it.tenThuocTinh == entry.key }
                            def strTenDomain = obj2.tenDomain.name
                            strTenDomain = strTenDomain.split("\\.")
                            strTenDomain = strTenDomain[strTenDomain.length - 1]
                            giaTri2 = obj2.tenDomain.find("from $strTenDomain where ${obj2.cotTimKiem} = :giaTri1 order by id desc " as String, [giaTri1: giaTri1])
                            if (!giaTri2) {
                                danhSachLoi.add("Dữ liệu trong ô ${cell.address} bị lỗi")
                            }
                        }
                    }
                    row += [(entry.key): giaTri2]
                }
            }
            data_import[i1] = row
        }
        return data_import
    }

    def docFileExcelImport_buoc3(ArrayList data_import, String loaiPhieu) {
        for (int i1 = 0; i1 < data_import.size(); i1++) {
            def row = data_import[i1]
            LinkedHashMap map_CH_TL = [:]
            map_CH_TL = [
                    newRow     : "newRow_" + (i1 + 1),
                    cauHoiId   : -1,
                    cauTraLoiId: -1,
                    updateRow  : -1,
                    cauHoi     : row.cauHoi,
                    cauTraLoi  : row.cauTraLoi,
            ]

            LinkedHashMap rowKetQua = map_CH_TL
            data_import[i1] = rowKetQua
        }
    }

    def docFileExcelImport_buoc4(def data_import) {
        def session = WebUtils.retrieveGrailsWebRequest().session
        session.data_import = data_import
    }

}
