package com.melanin.commons

import com.melanin.fingerprint.Branch

class MapEmailLdapToBranch {

    String email
    Branch branch
    String code

    static constraints = {
        branch(nullable: true)
        code(nullable: true)
    }
}
