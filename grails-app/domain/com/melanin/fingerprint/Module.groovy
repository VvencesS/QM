package com.melanin.fingerprint
/**
 * @author lamnt3
 * 6 module chính của LPB Collateral
 */
class Module {
	
	String code
    String name
    boolean canbedeleted = true// đánh dấu xem có xóa được không

    static constraints = {
    }

    static mapping = {
//        id generator:'sequence', params:[sequence:'module_seq']
    }
}
