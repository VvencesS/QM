package com.melanin.commons

class Conf {
    //	ConfType dataType
    String dataType
    String label
    String value
    String type
    int ord

    static constraints = {
        value 	maxSize: 4000
        type blank: false
        dataType nullable:true
        ord nullable:true
    }
}
