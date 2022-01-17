package api

import com.melanin.commons.Conf
import grails.converters.JSON
import grails.gorm.transactions.Transactional
import groovy.json.JsonOutput
import wslite.rest.ContentType
import wslite.rest.RESTClient
import grails.plugins.rest.client.RestBuilder

@Transactional
class RestClientService {
    def commonService
    def melaninLogService
    def melaninCommonService

    def getBotResponse(msg) {
        def api_BotApp_Address = Conf.findByLabel('Api_BotApp_Address').value
        def client = new RESTClient(api_BotApp_Address)
        def result = null
        try {
            def response = client.get(path: '/api/get-response?msg=' + msg,
                    accept: ContentType.JSON,
                    query: [status: "00"],
                    headers: ["X-Foo": "bar"],
                    connectTimeout: 60000,
                    readTimeout: 60000,
                    followRedirects: false,
                    useCaches: false,
                    sslTrustAllCerts: true
            )
            melaninLogService.savelog("SERVICE", "getBotResponse", "", "response: " + response + " -- json: " + response?.json, "", "RestClientService", "Response from " + api_BotApp_Address)
            if (response.json) {
                result = response.json
            } else {
                melaninLogService.savelog("SERVICE", "getBotResponse", "", "", "Response is null!", "RestClientService", "Response is null!")
                println "Response is null!"
            }
            return result
        } catch (Exception e) {
            melaninLogService.savelog("SERVICE", "getBotResponse", "", "", e.getStackTrace().toString(), "RestClientService", "getBotResponse")
            println e.message
            throw e
        }
    }

    def deleteLearnedData() {
        def api_BotApp_Address = Conf.findByLabel('Api_BotApp_Address').value
        def client = new RESTClient(api_BotApp_Address)
        def result = null
        try {
            def response = client.get(path: '/api/delete-learned-data',
                    accept: ContentType.JSON,
                    query: [status: "00"],
                    headers: ["X-Foo": "bar"],
                    connectTimeout: 60000,
                    readTimeout: 60000,
                    followRedirects: false,
                    useCaches: false,
                    sslTrustAllCerts: true
            )
            melaninLogService.savelog("SERVICE", "deleteLearnedData", "", "response: " + response + " -- json: " + response?.json, "", "RestClientService", "Response from " + api_BotApp_Address)
            if (response.json) {
                result = response.json
            } else {
                melaninLogService.savelog("SERVICE", "deleteLearnedData", "", "", "Response is null!", "RestClientService", "Response is null!")
                println "Response is null!"
            }
            return result
        } catch (Exception e) {
            melaninLogService.savelog("SERVICE", "deleteLearnedData", "", "", e.getStackTrace().toString(), "RestClientService", "deleteLearnedData")
            println e.message
            throw e
        }
    }

    def writeDataToFile(data) {
        RestBuilder rest = new RestBuilder()
        def api_BotApp_Address = Conf.findByLabel('Api_BotApp_Address').value
        def url = api_BotApp_Address + "/api/write-data-to-file"
        def jsonArr =  data
        def result = null
        try {
            def response = rest.post(url) {
                accept('application/json')
                contentType('application/json')
                body(JsonOutput.toJson(jsonArr))
            }

            melaninLogService.savelog("SERVICE", "writeDataToFile", "", "response: " + response + " -- json: " + response?.json, "", "RestClientService", "Response from " + api_BotApp_Address)
            if (response.json) {
                result = response.json
            } else {
                melaninLogService.savelog("SERVICE", "writeDataToFile", "", "", "Response is null!", "RestClientService", "Response is null!")
                println "Response is null!"
            }
            return result
        } catch (Exception e) {
            melaninLogService.savelog("SERVICE", "writeDataToFile", "", "", e.getStackTrace().toString(), "RestClientService", "writeDataToFile")
            println e.message
            throw e
        }
    }

    def trainingBot() {
        def api_BotApp_Address = Conf.findByLabel('Api_BotApp_Address').value
        def client = new RESTClient(api_BotApp_Address)
        def result = null
        try {
            def response = client.get(path: '/api/training-bot',
                    accept: ContentType.JSON,
                    query: [status: "00"],
                    headers: ["X-Foo": "bar"],
                    followRedirects: false,
                    useCaches: false,
                    sslTrustAllCerts: true
            )
            melaninLogService.savelog("SERVICE", "trainingBot", "", "response: " + response + " -- json: " + response?.json, "", "RestClientService", "Response from " + api_BotApp_Address)
            if (response.json) {
                result = response.json
            } else {
                melaninLogService.savelog("SERVICE", "trainingBot", "", "", "Response is null!", "RestClientService", "Response is null!")
                println "Response is null!"
            }
            return result
        } catch (Exception e) {
            melaninLogService.savelog("SERVICE", "trainingBot", "", "", e.getStackTrace().toString(), "RestClientService", "trainingBot")
            println e.message
            throw e
        }
    }
}
