package com.melanin.security
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes='name')
@ToString(includes='name', includeNames=true, includePackage=false)
class RoleGroup {

    private static final long serialVersionUID = 1
	String authority
    String name
    boolean canbedeleted = true// đánh dấu xem có xóa được không
	

    static constraints = {
        name blank: false, unique: true
    }

    static mapping = {
        cache true
//        id generator:'sequence', params:[sequence:'role_group_seq']
    }
}
