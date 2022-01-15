package com.qm

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import org.springframework.beans.factory.annotation.Autowired

import javax.sql.DataSource

class HuanLuyenVaThucNghiemController {
    SpringSecurityService springSecurityService

    @Autowired
    DataSource dataSource
    def restClientService
    def melaninCommonService

    def index_HuanLuyenVaThucNghiem() {
        println "${actionUri}: " + new Date() + ": " + params
        render view: "/qm/huanLuyenVaThucNghiem/index_HuanLuyenVaThucNghiem"
    }

    def getBotResponse() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            def result = restClientService.getBotResponse(params?.msg)

            // Lưu vào bảng QmLichSuChat
            def map_LichSuChat = [
                    cauHoi_User: params?.msg_NoEncode,
                    traLoi_Bot : result?.result,
                    mapNhan    : !result?.result?.equals("") ? QmCauTraLoi.findByTraLoi(result?.result)?.mapNhan : null,
            ]
            QmLichSuChat lichSuChat = new QmLichSuChat(map_LichSuChat)
            lichSuChat.save(flush: true, failOnError: true)

            render result as JSON
        } catch (Exception e) {
            e.printStackTrace()
        }
    }

    def deleteLearnedData() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            def result = restClientService.deleteLearnedData()
            render result as JSON
        } catch (Exception e) {
            e.printStackTrace()
        }
    }

    def getDataForTraining() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            def result = []
            ArrayList<QmNhan> nhanArrayList = QmNhan.findAll()

            // thêm tên file
            nhanArrayList.each { nhan ->
                def check = true
                def data = []
                def dsCH_TL = []

                ArrayList<QmCauTraLoi> cauTraLoiArrayList = QmCauTraLoi.findAllByNhan(nhan)
                if (cauTraLoiArrayList.size() > 0) {
                    cauTraLoiArrayList.each { cauTraLoi ->
                        def CH_TL = []
                        ArrayList<QmCauHoi> cauHoiArrayList = QmCauHoi.findAllByTraLoi(cauTraLoi)
                        if (cauHoiArrayList.size() > 0) {
                            cauHoiArrayList.each { cauHoi ->
                                CH_TL = [
                                        cauHoi: cauHoi.cauHoi,
                                        traLoi: cauTraLoi.traLoi
                                ]
                                dsCH_TL.add(CH_TL)
                            }
                        }
                    }
                }

                result.each {
                    if (it.tenFile.equals(nhan.tenFileCuaNhan)) {
                        it.dsCH_TL += dsCH_TL
                        check = false
                    }
                }

                if (check) {
                    data = [
                            tenFile: nhan.tenFileCuaNhan,
                            dsCH_TL: dsCH_TL
                    ]
                    result.add(data)
                }
            }
            return result
        } catch (Exception e) {
            e.printStackTrace()
        }
    }

    def writeDataToFile() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            def data = getDataForTraining()
            def result = restClientService.writeDataToFile(data)
            render result as JSON
        } catch (Exception e) {
            e.printStackTrace()
        }
    }

    def trainingBot() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            def result = null
            result = restClientService.deleteLearnedData()
            if (result) {
                def data = getDataForTraining()
                result = restClientService.writeDataToFile(data)
                if (result) {
                    result = restClientService.trainingBot()
                }
            }

            render result as JSON
        } catch (Exception e) {
            e.printStackTrace()
        }
    }

}
