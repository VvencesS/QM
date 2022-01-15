package com.melanin.security

import com.melanin.fingerprint.Branch
import grails.plugin.springsecurity.SpringSecurityService
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes = 'username')
@ToString(includes = 'username', includeNames = true, includePackage = false)
class User implements Serializable {
    private static final long serialVersionUID = 1

    SpringSecurityService springSecurityService

    String fullname
    String username
    String password
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    boolean adOnly = false

    Branch branch
    String prop1
    int jobTitle
    String prop2
    String prop3
    String prop4
    String prop5
    Date lastLogin
    Date lastLogout

    String maNhanVien
    String maNhanVienOld
    String sodienthoai
    String chucVu

    String email
    boolean canbedeleted = true// đánh dấu xem có xóa được không

    String updateBy
    Date updateDate = new Date()

    static constraints = {
        username blank: false, unique: true
        password blank: false, password: true

        prop1 nullable: true
        prop2 nullable: true
        prop3 nullable: true
        prop4 nullable: true
        prop5 nullable: true
        branch nullable: true
        adOnly nullable: true
        lastLogin nullable: true
        lastLogout nullable: true
        maNhanVien nullable: true
        sodienthoai nullable: true
        chucVu nullable: true
        updateBy nullable: true
        updateDate nullable: true
        maNhanVienOld nullable: true
    }

    static mapping = {
        password column: 'pass'
        table 'USERS'
        lastLogin sqlType: "date"
        lastLogout sqlType: "date"
        updateDate sqlType: "date"
//        id generator: 'sequence', params: [sequence: 'user_seq']
    }


    Set<Role> getAuthorities() {
        (UserRole.findAllByUser(this) as List<UserRole>)*.role as Set<Role>
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
//		password = springSecurityService.encodePassword(password)
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    static transients = ['springSecurityService']
}
