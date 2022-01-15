package com.melanin.commons

import grails.converters.JSON
import org.apache.commons.lang.StringUtils
import org.apache.commons.lang.math.NumberUtils
import org.grails.web.json.JSONArray
import serversidetable.ServerSideMelaninService

class ConfController {
    def dataSource
    /***************** THAY DOI DOAN NAY ***********************************/
    /*
     * Dinh nghia cac truong the hien trong view propertiesToShow
     * Vi du: propertiesToShow = ['id','dateCreated','name','approver']
     *
     */
    public static final def propertiesToShow = ['id', 'value', 'type', 'dataType', 'label', 'ord']
    /*
    * Dinh nghia header cua bang trong view headerTableToShow
    * Vi du: headerTableToShow =  ['title id','ngay tao','ten ','title approver')']
    * chu y propertiesToShow va headerTableToShow cung size
    *
    */
    public static final def headerTableToShow = ['id', 'value', 'type', 'Data type', 'label', 'ord']
    /*
     * closRenderCustom dung de render cac association vao datatable, tuc la cac property khong phai la
     * dang thong thuong (Integer, String, Date, Double...) ma la cac property la Domain Object, vi du:
     * User, Branch,...
     * returnObject << dataObject.id << dataObject.user.name
     */
    def closRenderCustom = { dataObject, returnObject ->
        //returnObject << dataObject.id << dataObject.user.name
        returnObject << dataObject.id << dataObject.value << dataObject.type << dataObject.dataType.toString() << dataObject.label << dataObject.ord
    }
    //closFilterCustom dung de search tren bang, khi propertiesToShow.size() > 0 thi phai dinh nghia lai cho nay
    def closFilter = { props, val ->
        if (StringUtils.isNotBlank(val)) {
            return {
                or {
                    if (propertiesToShow) {
                        //Thay doi cho nay neu khi propertiesToShow.size() > 0
                        /*Vi du
                         * eq "id" ,  NumberUtils.toLong(val,0)
                         * like "name", '%'+val+'%'
                         * cho search voi 2 truong id va name
                         */
                        //eq "id" , NumberUtils.toLong(val,0)
                        // eq "ord" ,NumberUtils.toInt(val,0)
                        like "type", "%" + val + "%"
                        like "label", "%" + val + "%"
                        like "value", "%" + val + "%"

                    } else {
                        //Khong thay doi cho nay
                        props.eachWithIndex { p, i ->
                            if (p.type.name == 'java.lang.Long') {
                                eq p.name, NumberUtils.toLong(val, 0)
                            }
                            if (p.type.name == 'java.lang.Integer') {
                                like p.name, NumberUtils.toInt(val, 0)
                            }
                            if (p.type.name == 'java.lang.String') {
                                like p.name, "%" + val + "%"
                            }
                        }
                    }

                }
            }
        }
        return {}

    }


    //load ra ds user cho bang server side
    def loadConf() {
        println "${actionUri}: " + new Date() + ": " + params
        StringBuilder query = new StringBuilder()

        query.append(" SELECT stt, id, VALUE, TYPE, label")
        query.append(" FROM (SELECT (@row_number:=@row_number + 1) AS stt, th.*") //ROWNUM
        query.append("       FROM (SELECT c.id AS id, c.VALUE AS VALUE,")
        query.append("                    c.TYPE AS TYPE, c.label AS label")
        query.append("             FROM conf c")
        query.append("             WHERE 1 = 1")
        query.append("             ORDER BY c.id DESC) th) a")
        query.append(" WHERE 1 = 1")
//        println query.toString()
        def whereParam = []
        ServerSideMelaninService ssc = new ServerSideMelaninService()
        def listdynamic = ssc.listdynamic(query.toString(), params, dataSource, whereParam)

        JSONArray dataAr = listdynamic.get("data")
        JSONArray newData = new JSONArray()
        for (int i = 0; i < dataAr.size(); i++) {
            Object data = dataAr.get(i)
            List dataAsList = data.toList()
            JSONArray dataObj = new JSONArray()
            dataObj.push(dataAsList.get(0))
            dataObj.push(dataAsList.get(1))
            dataObj.push(dataAsList.get(2))
            dataObj.push(dataAsList.get(3))
            dataObj.push(dataAsList.get(4))

            String lnk = "<td><a href='${createLink(controller: 'conf', action: 'edit')}/" + dataAsList.get(1).intValue() + "' value='" + dataAsList.get(1) + "' class='editUrl icon-edit'></a></td>"
//            String lnk = "<td><a href='#' rel='" + dataAsList.get(1) + "' value='" + dataAsList.get(1) + "' class='editUrl icon-edit'></a>&nbsp;&nbsp;" +
//                    "<a href='#' rel='" + dataAsList.get(1) + "' value='" + dataAsList.get(1) + "' class='deleteUrl icon-trash'></a></td>"
            dataObj.push(lnk)//(9)
            newData.push(dataObj)
        }
        listdynamic.put("data", newData)
        render listdynamic as JSON
    }


    /*************** KHONG NEN THAY DOI TU DOAN NAY TRO XUONG **************************/
    /* def listAjax = {
         //def props = ScaffoldingUtil.getProps(grailsApplication,"msb.platto.commons.Conf")
         println "${actionUri}: " + new Date() + ": " + params
         def dataToRender = [:] // map
         dataToRender.sEcho = params.sEcho
         dataToRender.aaData=[]                // Array of vacationRequests.
         def total = Conf.createCriteria().count(closFilter(props, params.sSearch))// remove null value in clos and change content of clos function for enable search feature
         dataToRender.iTotalRecords = total
         dataToRender.iTotalDisplayRecords = dataToRender.iTotalRecords
         def sortDir = params.sSortDir_0?.equalsIgnoreCase('asc') ? 'asc' : 'desc'
         def sortProperty = propertiesToShow ? propertiesToShow[params.iSortCol_0 as int] :  props.collect{it.name}[params.iSortCol_0 as int]
         def objList = Conf.createCriteria().list(max: params.iDisplayLength as int, offset: params.iDisplayStart as int,sort: sortProperty,order: sortDir, closFilter(props, params.sSearch)) // remove null value in clos and change content of clos function for enable search feature
         objList.each{ dataObject ->
             def o = []
             if(propertiesToShow){
                 closRenderCustom(dataObject, o)
             }else{
                 props.eachWithIndex{ propertyObject, i ->
                     if(propertyObject.type.name == 'java.util.Date'){
                         o << DateUtil.formatDateTimeFromMessageCode(dataObject[propertyObject.name])
                     }else{
                         o << dataObject[propertyObject.name]
                     }
                 }

             }
             dataToRender.aaData.add o
         }
         render dataToRender as JSON
     }*/

    def create = {
        def confInstance = new Conf()
        confInstance.properties = params
        render(view: '/conf/conf', model: [confInstance: confInstance])
    }
    def save = {
        if (params.id) {
            redirect(action: "update", params: params)
            return
        }
        def confInstance = new Conf(params)
        if (confInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'conf.label', default: 'Conf'), confInstance.id])}"
            redirect(action: "list")
        } else {
            render(view: '/conf/conf', model: [confInstance: confInstance])
        }
    }
    def edit = {
        println "${actionUri}: " + new Date() + ": " + params
        def confInstance = Conf.get(params.id)
        if (!confInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'conf.label', default: 'Conf'), params.id])}"
            redirect(action: "list")
        } else {
            render(view: '/conf/conf', model: [confInstance: confInstance])
        }
    }
    def update = {
        def confInstance = Conf.get(NumberUtils.toLong(params.id, 0))
        if (confInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (confInstance.version > version) {

                    confInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'conf.label', default: 'Conf')] as Object[], "Another user has updated this Conf while you were editing")
                    render(view: '/conf/conf', model: [confInstance: confInstance])
                    return
                }
            }
            confInstance.properties = params
            if (!confInstance.hasErrors() && confInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'conf.label', default: 'Conf'), confInstance.id])}"
                redirect(action: "list")
            } else {
                render(view: '/conf/conf', model: [confInstance: confInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'conf.label', default: 'Conf'), params.id])}"
            redirect(action: "list")
        }
    }
    def delete = {
        def confInstance = Conf.get(NumberUtils.toLong(params.id, 0))
        if (confInstance) {
            try {
                confInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'conf.label', default: 'Conf'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'conf.label', default: 'Conf'), params.id])}"
                redirect(action: "list")
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'conf.label', default: 'Conf'), params.id])}"
            redirect(action: "list")
        }
    }
    def index = {
        redirect(action: "list", params: params)
    }
    def list = {
        render view: '/conf/conf'
    }

}
