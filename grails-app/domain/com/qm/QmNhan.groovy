package com.qm

class QmNhan {
    static belongsTo = [parentItem: QmNhan]
    String maNhan
    String tenNhan
    String tenFileCuaNhan
    boolean active = true
    Integer level

    static mapping = {
        level column: 'levels'
    }

    static constraints = {
        parentItem(nullable: true)
        maNhan(maxSize: 500, nullable: true)
        tenNhan(maxSize: 500, nullable: true)
        tenFileCuaNhan(maxSize: 500, nullable: true)
        level(nullable: true)
    }
}
