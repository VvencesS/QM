package com.qm

import com.commons.Constant
import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import org.springframework.beans.factory.annotation.Autowired

import javax.sql.DataSource

class ThongKeController {
    SpringSecurityService springSecurityService

    @Autowired
    DataSource dataSource

    def index_ThongKe() {
        println "${actionUri}: " + new Date() + ": " + params
        render view: "/qm/thongKe/index_ThongKe"
    }

    // Chủ đề được hỏi nhiều nhất
    def mostAskedTopicChart() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            List mapNhan_LichSuChat = []
            List xValues_MostAskedTopicChart = []
            List yValues_MostAskedTopicChart = []
            List barColors_MostAskedTopicChart = []
            LinkedHashMap result = []
            ArrayList<QmLichSuChat> lichSuChatArrayList = QmLichSuChat.findAll()

            // Lấy và thêm tất cả mapNhan vào mapNhan_LichSuChat
            lichSuChatArrayList.each {
                if (it.mapNhan) {
                    def nhanArray = it.mapNhan.split(",")
                    for (int i1 = 0; i1 < nhanArray.size(); i1++) {
                        mapNhan_LichSuChat.push(nhanArray[i1])
                    }
                }
            }

            result = mapNhan_LichSuChat.inject([:]) { m, x -> if (!m[x]) m[x] = 0; m[x] += 1; m }
            result.each { key, value ->
                xValues_MostAskedTopicChart.push(key)
                yValues_MostAskedTopicChart.push(value)
            }
            barColors_MostAskedTopicChart = Constant.CODE_COLORS.subList(0, xValues_MostAskedTopicChart.size() > 0 ? xValues_MostAskedTopicChart.size() - 1 : 0)

            render(text: [
                    success                      : true,
                    msg                          : "Thao tác thành công!",
                    xValues_MostAskedTopicChart  : xValues_MostAskedTopicChart,
                    yValues_MostAskedTopicChart  : yValues_MostAskedTopicChart,
                    barColors_MostAskedTopicChart: barColors_MostAskedTopicChart,
            ] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } catch (Exception e) {
            render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            e.printStackTrace()
        }
    }

    // Số lượng câu hỏi tìm được kết quả
    def foundResultsChart() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            def xValues_FoundResultsChart = ["Có đáp án", "Không tìm thấy"]
            def yValues_FoundResultsChart = []
            def barColors_FoundResultsChart = ["#2b5797", "#e8c3b9"]
            def mapData_FoundResultsChart_google = []
            ArrayList<QmLichSuChat> lichSuChatArrayList = QmLichSuChat.findAll()
            int count_NULL_RESPONSE_BOT = 0
            int count_RESPONSE_BOT = 0

            lichSuChatArrayList.each {
                if (it.traLoi_Bot.equals(Constant.MSG_NULL_RESPONSE_BOT_1) || it.traLoi_Bot.equals(Constant.MSG_NULL_RESPONSE_BOT_2)) {
                    count_NULL_RESPONSE_BOT++
                }
            }
            count_RESPONSE_BOT = lichSuChatArrayList.size() > 0 ? lichSuChatArrayList.size() - count_NULL_RESPONSE_BOT : 0
            yValues_FoundResultsChart = [count_RESPONSE_BOT, count_NULL_RESPONSE_BOT]

            mapData_FoundResultsChart_google = [
                    ["Tỷ lệ % câu hỏi tìm được kết quả", "Mhl"],
                    ["Có đáp án", (float) yValues_FoundResultsChart[0]],
                    ["Không tìm thấy", (float) yValues_FoundResultsChart[1]]
            ]

            render(text: [
                    success                         : true,
                    msg                             : "Thao tác thành công!",
                    xValues_FoundResultsChart       : xValues_FoundResultsChart,
                    yValues_FoundResultsChart       : yValues_FoundResultsChart,
                    barColors_FoundResultsChart     : barColors_FoundResultsChart,
                    mapData_FoundResultsChart_google: mapData_FoundResultsChart_google,
            ] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } catch (Exception e) {
            render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            e.printStackTrace()
        }
    }

    // Số lượng câu hỏi trong một khoảng thời gian
    def numberOfQuestionsInAPeriod() {
        println "${actionUri}: " + new Date() + ": " + params

        try {
            def xValues_numberOfQuestionsInAPeriod = []
            def yValues_numberOfQuestionsInAPeriod = []
            Date nowDate = new Date()
            ArrayList<QmLichSuChat> lichSuChatArrayList = QmLichSuChat.listOrderByChatDate()

            xValues_numberOfQuestionsInAPeriod = ['09/01/2021', '10/01/2021', '11/01/2021', '12/01/2021', '13/01/2021', '14/01/2021',]
            yValues_numberOfQuestionsInAPeriod = [5, 6, 7, 8, 3, 7]
            render(text: [
                    success                  : true,
                    msg                      : "Thao tác thành công!",
                    xValues_FoundResultsChart: xValues_numberOfQuestionsInAPeriod,
                    yValues_FoundResultsChart: yValues_numberOfQuestionsInAPeriod,
                    lichSuChatArrayList      : lichSuChatArrayList,
            ] as JSON, contentType: 'text/json', encoding: "UTF-8")
        } catch (Exception e) {
            render(text: [error: true, msg: "Có lỗi xảy ra!"] as JSON, contentType: 'text/json', encoding: "UTF-8")
            e.printStackTrace()
        }
    }

}
