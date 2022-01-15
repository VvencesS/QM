package com.melanin.fingerprint

import com.melanin.security.User

class Branch {
    String name
    String code
    int level
    static hasMany = [children: Branch, users: User]
    static belongsTo = [parent: Branch]
    String status

    String shortname
    boolean active
//    boolean is_ho // la ho

//    SortedSet children
    boolean canbedeleted = true// đánh dấu xem có xóa được không

    //tên chính xác của đơn vị phục vụ in báo cáo
    String realName

    //08112019
    String vungMien = "0"
    String sequenceCode = "0"
    //--

    static constraints = {
        parent nullable: true
        code nullable: true
        status nullable: true
        vungMien(maxSize: 1, nullable: true)
        sequenceCode(maxSize: 10, nullable: true)
        realName(nullable: true, maxSize: 500)
    }


    static mapping = {
        children cache: 'nonstrict-read-write'
        children lazy: true
//        users lazy: true
        level column: 'levels'
//        id generator: 'sequence', params: [sequence: 'dms_branch_seq']
    }
}
