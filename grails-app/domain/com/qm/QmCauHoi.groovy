package com.qm

class QmCauHoi {
    String cauHoi
    QmCauTraLoi traLoi
    boolean active = true

    static mapping = {
        cauHoi sqlType: 'longText'
    }

    static constraints = {
        traLoi(nullable: true)
        cauHoi(nullable: true)
    }
}
