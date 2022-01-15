package com.melanin.commons

class MelaninLogAction {
    String username
    Date actiontime
    String actionname
    String ipaddress
    String parameters
    String exception
    String action_controller
    String note
    static mapping = {
        actiontime sqlType: "date"
//        parameters sqlType:"text"
//        exception sqlType:"text"
//        note sqlType:"text"
    }

    static constraints = {
        exception nullable: true
        note (nullable: true, maxSize: 4000)
        actionname nullable: true
        parameters (nullable: true, maxSize: 4000)
        exception (nullable: true, maxSize: 4000)
    }
}
