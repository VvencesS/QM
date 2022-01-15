package com.melanin.security

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes = 'authority')
@ToString(includes = 'authority', includeNames = true, includePackage = false)
class Role implements Serializable {
    private static final long serialVersionUID = 1

    String authority
    String name            // ten quyen
    RoleGroup roleGroup        // quyen chung
    boolean active            // trang thai
    String diengiai
    String dschucnang        // danh sách chức năng theo module ( mảng 7 phần tử ( 7 module ))
    boolean canbedeleted = true// đánh dấu xem có xóa được không

    static mapping = {
        cache true
//        id generator: 'sequence', params: [sequence: 'role_seq']
    }

    static constraints = {
        authority blank: false, unique: true
        name blank: false, unique: true
        diengiai nullable: true
        dschucnang(maxSize: 4000)
    }
}
