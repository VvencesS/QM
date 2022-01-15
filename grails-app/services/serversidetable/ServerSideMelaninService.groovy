package serversidetable

import grails.web.servlet.mvc.GrailsParameterMap
import groovy.sql.Sql
import org.grails.web.json.JSONArray
import org.grails.web.json.JSONObject
import org.springframework.beans.factory.annotation.Autowired

import javax.sql.DataSource

class ServerSideMelaninService {
    @Autowired
    DataSource dataSource

    def index() {}

    def row(String query_input, GrailsParameterMap params, def dataSource) {
        Sql sql = new Sql(dataSource)
        int soluong = 0
        try {
            def result = []
            def rs = sql.rows(query_input.toString())
            if (rs) {
                for (r in rs) {
                    result << r
                }
            }
            if (result) {
                //soluong = result.unique().size()
                soluong = result.get("count")
            }
            return soluong
        }
        catch (Exception e) {
            e.printStackTrace()
            throw e
        } finally {
            sql.close()
        }
    }

    /**
     * @param query_input : query truyền vào phải có dạng SELECT a,b,c FROM d WHERE e
     * Hàm sẽ tự động phân tích và truyền về kết quả cần thiết
     * @return
     */
    private listdynamic(String query_input, GrailsParameterMap params, def dataSource, def whereParam) {
        def sql = new Sql(dataSource)

        //TYPE YOUR OWN CODE HERE
        query_input = query_input
        JSONObject result = new JSONObject()
        JSONArray data = new JSONArray()
        int start = 0, length = 0, end = 0
        String error = ""
        long recordsTotal = 0
        int recordsFiltered = 0
        int draw = 0

        def phanTichCauSql = getListFromQuery(query_input)
        def col_array = phanTichCauSql.selectlist_arr
        def col_array_alias = phanTichCauSql.selectlist_arr
        String table_name = phanTichCauSql.fromtable
        String wherecondition = phanTichCauSql.wherecondition
//			println "---- col_array: "+col_array
//			println "---- table_name: "+table_name
//			println "---- wherecondition: "+wherecondition

        String cols_str = ""
        cols_str = String.join("," , col_array)

        // convert dung alias hoac as name
        def arr = []
        for (int i = 0; i < col_array_alias.length; i++) {
            String ss = col_array_alias[i].toString()
            if (ss.contains(" AS ")) {
                arr = ss.split(" AS ")
                col_array_alias[i] = arr[1].toString().trim()
            } else if (ss.contains(".")) {
                arr = ss.split("\\.")
                col_array_alias[i] = arr[1].toString().trim()
            } else {
                col_array_alias[i] = ss.trim()
            }
        }


        //0. draw ( must = 0 or increase each time )
        draw = Integer.parseInt(params.draw) + 0

        //search value
        if (params."search[value]") {
            String search_value = params."search[value]".trim();
            StringBuilder strB_wherecondition = new StringBuilder()
            strB_wherecondition.append(wherecondition)
            strB_wherecondition.append(" AND ( 1 = 2 ")
            for (int i = 0; i < col_array.length; i++) {
                if (params."columns[$i][searchable]" == "true" ) {
                    strB_wherecondition.append(" OR UPPER( ${col_array[i]} ) LIKE '%' || UPPER(?) || '%' ")
                    whereParam.push(search_value)
                }
            }
            strB_wherecondition.append(" )")
            wherecondition = strB_wherecondition.toString()
        }

        StringBuilder totalrecord_query = new StringBuilder()
        totalrecord_query.append(" SELECT COUNT(1) AS TOTALRECORD FROM $table_name WHERE $wherecondition ")

//            println "totalrecord_query: " + totalrecord_query.toString()
        //1. recordsTotal : total record of table you want to show
        def totalrecord = sql.rows(totalrecord_query.toString(), whereParam)
        recordsTotal = totalrecord ? totalrecord[0].totalrecord : 0
        //2. recordsFiltered
        recordsFiltered = recordsTotal

        //language=SQL
        StringBuilder query = new StringBuilder("SELECT $cols_str FROM $table_name WHERE $wherecondition ")
        //3 data + error: get data with range limit and search and order. After that, calculate recordsFiltered again
        start = params.start ? Integer.parseInt(params.start) : 0
        length = params.length ? Integer.parseInt(params.length) : 0

        if (params."order[0][column]" ) {
            int order_col_num = Integer.parseInt(params."order[0][column]")
            String order_col_name = params."columns[$order_col_num][name]"
            String orderDir = params."order[0][dir]"
            if ( order_col_name != "" ) {
                query.append(" order by $order_col_name $orderDir" )
            }
        }
        //25102019 xoa vi dung kieu oracle
        //Begin: kieu mySql
            query.append(" LIMIT " + start + " ," + length + "")
            def resultset = sql.rows(query.toString(), whereParam)
        //End.

        //Begin: kieu Oracle - truoc 12c
//            end = start + length;
//            StringBuilder queryTemp = new StringBuilder()
//            queryTemp.append("""SELECT * FROM (SELECT zz.*, ROWNUM rnum FROM (
//                ${query.toString()}) zz WHERE ROWNUM <=  $end )
//                WHERE rnum > $start
//            """)
//            def resultset = sql.rows(queryTemp.toString(), whereParam)
//        query.append(""" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY""")
//        whereParam.push(start)
//        whereParam.push(length)

//            List whereParam1 = (List) whereParam
//        def resultset = sql.rows(query.toString(), whereParam)
        //End.
        if (resultset) {
            for (item in resultset) {
                ArrayList objList = []
                for (int i = 0; i < col_array_alias.length; i++) {
                    def obj14 = item.(col_array_alias[i])
                    objList += item.(col_array_alias[i])
//                    objList.add( item.(col_array_alias[i]) )
                }
                data << objList
            }
        }
        //put 5 return parameters for datatable
        result += [draw: draw]
        result += [recordsTotal: recordsTotal]
        result += [recordsFiltered: recordsFiltered]
        result += [data: data]
        result += [error: error]
        return result
    }
    //=====================================================

    private listdynamicColumnSearch(String query_input, GrailsParameterMap params, def dataSource, def whereParam) {
        def sql = new Sql(dataSource)
//		SqlConnectionService sqlConnectionService = new SqlConnectionService();
//		Sql sql = sqlConnectionService.getSqlConnection();

        try {
            //TYPE YOUR OWN CODE HERE
            query_input = query_input
            JSONObject result = new JSONObject()
            JSONArray data = new JSONArray()
            int start = 0, length = 0, end = 0
            String error = ""
            long recordsTotal = 0
            int recordsFiltered = 0
            int draw = 0

            def abc = getListFromQuery(query_input)
            def col_array = abc[0]
//			println "---- col_array: "+col_array
            def col_array_alias = abc[0]
            String table_name = abc[1]
//			println "---- table_name: "+table_name
            String wherecondition = abc[2]
//			println "---- wherecondition: "+wherecondition

            String cols_str = ""
            for (int i = 0; i < col_array.length; i++) {
                if (i != col_array.length - 1) {
                    cols_str += col_array[i].toString().trim() + ","
                } else {
                    cols_str += col_array[i].toString().trim()
                }
            }

            // convert dung alias hoac as name
            def arr = []
            for (int i = 0; i < col_array_alias.length; i++) {
                String ss = col_array_alias[i].toString()
                if (ss.contains(" AS ")) {
                    arr = ss.split(" AS ")
                    col_array_alias[i] = arr[1].toString().trim()
                } else if (ss.contains(".")) {
                    arr = ss.split("\\.")
                    col_array_alias[i] = arr[1].toString().trim()
                } else {
                    col_array_alias[i] = ss.trim()
                }
            }

            StringBuilder query = new StringBuilder("SELECT " + cols_str)
            query.append(" FROM " + table_name)
            if (wherecondition.equals("1 = 1")) {
                query.append(" WHERE 1=1")
            } else {
                query.append(" WHERE 1=1 AND " + wherecondition)
            }

            //0. draw ( must = 0 or increase each time )
            draw = Integer.parseInt(params.draw) + 1

            def check_search_column = false

            for (int i = 0; i < col_array.length; i++) {
                if (params["columns[" + i + "][search][value]"].toString().trim()) {
                    check_search_column = true
                    break
                }
            }

            //search value
            if (check_search_column) {
                query.append(" AND ( 1 = 2 ")
                for (int i = 0; i < col_array.length; i++) {
                    if (params["columns[" + i + "][search][value]"].toString().trim()) {
                        query.append(" OR UPPER(" + col_array[i] + ") LIKE UPPER('%" + params["columns[" + i + "][search][value]"].toString().trim() + "%')")
                    }
                }
                query.append(" )")
                StringBuilder totalrecord_query = new StringBuilder()
                totalrecord_query.append("SELECT COUNT(1) AS TOTALRECORD FROM (")
                totalrecord_query.append(query)
                totalrecord_query.append(" ) total")

                println "totalrecord_query: " + totalrecord_query.toString()
                //1. recordsTotal : total record of table you want to show
                def totalrecord = sql.rows(totalrecord_query.toString(), whereParam)
                if (totalrecord) {
                    recordsTotal = totalrecord[0].totalrecord
                }
                //2. recordsFiltered
                recordsFiltered = recordsTotal
            } else {
                //1. recordsTotal : total record of table you want to show
                String totalrecord_query = new StringBuilder("SELECT COUNT(1) AS TOTALRECORD FROM " + table_name + " WHERE 1 = 1 AND " + wherecondition)
                println "totalrecord_query: " + totalrecord_query

                def totalrecord = sql.rows(totalrecord_query.toString(), whereParam)
                if (totalrecord) {
                    recordsTotal = totalrecord[0].totalrecord
                }
                //2. recordsFiltered
                recordsFiltered = recordsTotal
            }

            //3 data + error: get data with range limit and search and order. After that, calculate recordsFiltered again
            if (params.start) {
                start = Integer.parseInt(params.start)
            }
            if (params.length) {
                length = Integer.parseInt(params.length)
            }

            if (params["order[0][column]"]) {
                int order_col_num = Integer.parseInt(params["order[0][column]"])
                String order_col_name = params["columns[" + order_col_num + "][name]"]
                String order_by = params["order[0][dir]"]
                query.append(" order by " + order_col_name + " " + order_by)
            }
            //25102019 xoa vi dung kieu oracle
            //Begin: kieu mySql
//            query.append(" LIMIT " + start + " ," + length + "")
//            def resultset = sql.rows(query.toString(), whereParam)
            //End.

            //Begin: kieu Oracle
            end = start + length;
            StringBuilder queryTemp = new StringBuilder()
            queryTemp.append("SELECT * FROM (SELECT zz.*, ROWNUM rnum FROM (")
            queryTemp.append(query.toString())
            queryTemp.append(") zz WHERE ROWNUM <= " + end + ") WHERE rnum >" + start)
            def resultset = sql.rows(queryTemp.toString(), whereParam)
            //End.
            if (resultset) {
                for (p in resultset) {
                    JSONArray ja = new JSONArray()
                    for (int i = 0; i < col_array_alias.length; i++) {
                        ja.push(p[col_array_alias[i]])
                    }
                    data.push(ja)
                }
            }

            //put 5 return parameters for datatable
            result.put("draw", draw)
            result.put("recordsTotal", recordsTotal)
            result.put("recordsFiltered", recordsFiltered)
            result.put("data", data)
            result.put("error", error)
            return result
        } catch (Exception e) {
            e.printStackTrace()
            throw e
        } finally {
            sql.close()
//			sqlConnectionService.destroy()
        }
    }
    //==========================================================

    //replace chuoi co ky tu ' thanh '' khi chay cau lenh select
    def replace_apostrophe(String str) {
        str = str.replaceAll("\'", "''")
        return str;
    }

    def getListFromQuery(String query) {
//		println "----------------------"
//		println "--- query input: "+query
        def re = [:]
        String[] selectlist_arr
        query = query
        String selectlist = ""
        String fromtable = ""
        String wherecondition = ""
        int _to_1st_FROM_length = 0 // include FROM
        int _from_last_WHERE_to_end_length = 0 // include WHERE
        // 1. tach ra select
        String[] strSplit = query.split(" FROM ")
        if (strSplit) {
            String beforfrom = strSplit[0] //truoc chu FROM đầu tiên của câu query
//			println "----beforfrom: "+beforfrom
            def arr_catBangSelect = beforfrom.split("SELECT")
            selectlist = arr_catBangSelect[1]
//			println "----selectlist: "+selectlist
            selectlist_arr = selectlist.split(",") // mảng những cái cần select
            for (int i = 0; i < selectlist_arr.size(); i++) {
                selectlist_arr[i] = selectlist_arr[i].trim();
            }
            _to_1st_FROM_length = strSplit[0].length() + 6 // include FROM and 2 space chars
//			println "----_to_1st_FROM_length: "+_to_1st_FROM_length
            //2. Cắt chuỗi đằng sau chữ FROM đầu tiên = cắt từ đống trước FROM trên + 6 kí tự cho chính chữ FROM (2 dấu cách) ( tại sao k dùng strSplit[1] ? Vì có thể đằng sau có nhiều chữ FROM nên bị cắt nhiều khúc )
            String afterfrom = query.substring(_to_1st_FROM_length)
//			println "----afterfrom: "+afterfrom
            //3. Tìm chữ WHERE cuối cùng của chuỗi và cắt ra
            String[] splitbyWhere = afterfrom.split(" WHERE ")
            // có thể cắt ra rất nhiều chuỗi do WHERE => chỉ lấy cái cuối cùng thôi
            int splitbyWhere_count = splitbyWhere.size()
            // = 0 thì vô lý, bằng 1 thì có 2 cái, bằng 2 thì lấy cái cuối cùng
            if (splitbyWhere_count == 0) {
                wherecondition = "1 = 1"
            } else {
                wherecondition = splitbyWhere[splitbyWhere_count - 1]
            }
//			println "----wherecondition: "+wherecondition
//			println "----query.length(): "+query.length()
            _from_last_WHERE_to_end_length = query.length() - wherecondition.length() - 7
            // include WHERE & 2 space chars

            //4. Có sau FROM đầu và WHERE cuối rồi => xác định được cái đống tablename ( có thể là inner join trong 1 đống ngoặc )
//			println "_to_1st_FROM_length: "+_to_1st_FROM_length
//			println "_from_last_WHERE_to_end_length: "+_from_last_WHERE_to_end_length

            fromtable = query.substring(_to_1st_FROM_length, _from_last_WHERE_to_end_length)
            re.selectlist_arr = selectlist_arr
            re.fromtable = fromtable
            re.wherecondition = wherecondition
            return re
        }
    }
    //=====================================================

    def query(String query_input, def whereParam, def dataSource) {
        Sql sql = new Sql(dataSource)
        try {
            def result = sql.rows(query_input, whereParam)
            return result
        }
        catch (Exception e) {
            e.printStackTrace()
            throw e
        } finally {
            sql.close()
        }
    }
}
