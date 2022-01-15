package com.qm

class QmLichSuChat {
    String cauHoi_User
    String traLoi_Bot
    String mapNhan
    Date chatDate = new Date()
    Boolean rate = true
    String detailedReview

    static mapping = {
        cauHoi_User sqlType: 'longText'
        traLoi_Bot sqlType: 'longText'
        detailedReview sqlType: 'longText'
    }

    static constraints = {
        cauHoi_User(nullable: true)
        traLoi_Bot(nullable: true)
        mapNhan(nullable: true)
        rate(nullable: true)
        detailedReview(nullable: true)
    }
}
