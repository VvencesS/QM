package com.melanin.commons

class SidebarItem {
    static belongsTo = [parentItem: SidebarItem]
    MenuItem menuItem
    String label
    String htmlElementId
    String controller
    String action = ''
    String urlParam
    String icon = 'icon-list'
	boolean active = false
    String roles
    Integer level

    //phuc vu update dml
    String menuName
    String parentItemName
    //


	Double ordernumber = 9

	static mapping={
//        id generator:'sequence', params:[sequence:'sidebar_item_seq']
        level column: 'levels'
	}

    static constraints = {
		parentItem(nullable:true)
        level(nullable:true)
        htmlElementId(maxSize: 500, minSize: 2)
        controller(maxSize: 200, nullable:true)
        action(maxSize: 200, nullable:true)
        urlParam(nullable:true)
        menuName(nullable:true)
        menuItem(nullable:true)
        parentItemName(nullable:true)
        roles(maxSize: 3000, nullable:true)
    }
}
