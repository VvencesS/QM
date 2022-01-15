package com.melanin.security

/**
 * @author lamnt3
 * Cấu hình tới từng action riêng lẻ
 */
class Url {
	
	String url
	UrlGroup urlGroup
    boolean canbedeleted = true// đánh dấu xem có xóa được không

    static constraints = {
    }
}
