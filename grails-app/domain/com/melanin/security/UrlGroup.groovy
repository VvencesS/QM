package com.melanin.security

import com.melanin.fingerprint.Module

/**
 * @author lamnt3
 * Bảng nhóm action nhỏ
 */
class UrlGroup {
	
	String name
    String usecase
    String usecasename
    Module module
	boolean canbedeleted = true// đánh dấu xem có xóa được không

    static constraints = {
        usecase nullable: true
        usecasename nullable: true
    }
}
