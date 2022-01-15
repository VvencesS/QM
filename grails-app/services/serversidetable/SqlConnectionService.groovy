package serversidetable


import grails.util.Holders
import groovy.sql.Sql

//@Transactional
class SqlConnectionService {

    def serviceMethod() {

    }
    private static Sql sql = null;

    static void initialize() throws Exception {
        try {
            def app = Holders.getGrailsApplication().config
            sql = Sql.newInstance(app.dataSource.url,
                                  app.dataSource.username,
                                  app.dataSource.password,
                                  app.dataSource.driverClassName)
//            sql = Sql.newInstance("jdbc:mysql://10.254.61.24:3306/melanin_g3?useUnicode=yes&characterEncoding=UTF-8&autoReconnect=true",
//                    "root", "admin123", "com.mysql.jdbc.Driver")
        } catch (Exception e) {
            throw e
        }
    }

    static Sql getSqlConnection() {
        if (sql == null)
            initialize();
        return sql;
    }

    static void destroy() {
        sql = null;
    }
}
