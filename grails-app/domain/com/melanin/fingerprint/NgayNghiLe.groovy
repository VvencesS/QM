package com.melanin.fingerprint

class NgayNghiLe {

    String tenNgayNghi
    String ghiChu
    Date ngayNghi

    boolean deleted
    boolean trangThai

    String created_by
    Date date_entered = new Date()
    String modified_user_id
    Date date_modified

    static constraints = {
        ghiChu (nullable: true, maxSize: 2000)
        modified_user_id nullable: true
        date_modified nullable: true
        created_by nullable: true
    }

    static mapping = {
        ngayNghi sqlType: "date"
        date_entered sqlType: "date"
        date_modified sqlType: "date"
    }
}
