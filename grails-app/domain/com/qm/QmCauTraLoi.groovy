package com.qm

class QmCauTraLoi {
    String traLoi
    boolean active = true
    QmNhan nhan
    String mapNhan

    static mapping = {
        traLoi sqlType: 'longText'
    }

    static constraints = {
        traLoi(nullable: true)
        nhan(nullable: true)
        mapNhan(nullable: true)
    }
}
