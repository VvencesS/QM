package com.melanin.commons

import com.melanin.fingerprint.Branch

class MapOuLdapToBranch {

    String ou
    Branch branch
    String ghiChu

    static constraints = {
        ghiChu(nullable: true)
    }
}
