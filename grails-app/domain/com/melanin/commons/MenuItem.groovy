package com.melanin.commons

class MenuItem {
	
	String name
    String controller
    String action = ''
    String url
    String label
    String title
	boolean active = false
    String roles
	int ordernumber = 9

	static mapping={
//        id generator:'sequence', params:[sequence:'menu_item_seq']
	}

    static constraints = {
		title		nullable:true
		controller	nullable:true
		url			nullable:true
    }
}
