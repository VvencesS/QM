package com.melanin.fingerprint

class Notification {

    String typeNotify
    String titleNotify
    String linkPage
    String roleShow
    String saveViewAccount
    String createBy
    Date createDate = new Date()

    static mapping = {
//        id generator: 'sequence', params: [sequence: 'notification_seq']
    }
    static constraints = {
        saveViewAccount(nullable: true)
    }
}
