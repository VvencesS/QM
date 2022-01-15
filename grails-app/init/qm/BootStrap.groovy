package qm


import com.melanin.commons.MenuItem
import com.melanin.fingerprint.Branch
import com.melanin.fingerprint.Module
import com.melanin.security.RequestMap
import com.melanin.security.Role
import com.melanin.security.RoleGroup
import com.melanin.security.User
import com.melanin.security.UserRole

class BootStrap {

    transient springSecurityService
    def init = { servletContext ->

        def modules = [
                ['QTHT', 'Quản trị hệ thống']
        ]
        modules.each {
            if (!Module.findByCode(it[0])) {
                def m = new Module(code: it[0], name: it[1])
                m.save(flush: true)
            }
        }

        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        //init MenuItems
        if (!MenuItem.findByName('login'))
            new MenuItem(name: 'login', controller: 'melanin', action: 'login',
                    title: 'Click here to go to Login page', label: 'Login', roles: 'ROLE_ANONYMOUS').save(flush: true)
        if (!MenuItem.findByName('documentation'))
            new MenuItem(name: 'documentation', controller: 'melanin', action: 'documentation',
                    title: 'Click here to go to documentation page', label: 'Documentation', roles: 'ROLE_DEV').save(flush: true)
        if (!MenuItem.findByName('sample'))
            new MenuItem(name: 'sample', controller: 'melanin', action: 'sample',
                    title: 'Click here to see the sample page', label: 'Sample page', roles: 'ROLE_DEV').save(flush: true)
        if (!MenuItem.findByName('plugins'))
            new MenuItem(name: 'plugins', controller: 'melanin', action: 'plugins',
                    title: 'Click here to see the plugins page', label: 'Plugins', roles: 'ROLE_DEV').save(flush: true)
        if (!MenuItem.findByName('form'))
            new MenuItem(name: 'form', controller: 'melanin', action: 'form',
                    title: 'Click here to see the form & controls page', label: 'Form & controls', roles: 'ROLE_DEV').save(flush: true)
        if (!MenuItem.findByName('all-controller'))
            new MenuItem(name: 'all-controller', controller: 'melanin', action: 'all_controller',
                    title: 'Click here to see the all controller', label: 'All controller', roles: 'ROLE_DEV').save(flush: true)
        if (!MenuItem.findByName('source'))
            new MenuItem(name: 'source', controller: 'melanin', action: 'source', title: 'Javascript API', label: 'Javascript API', roles: 'ROLE_DEV').save(flush: true)
        if (!MenuItem.findByName('security'))
            new MenuItem(name: 'security', controller: 'fingerprint', action: 'index',
                    title: 'Click here to access security Control Panel', label: 'Quản trị hệ thống', roles: 'ROLE_ADMIN', ordernumber: 0).save(flush: true)
        if (!MenuItem.findByName('control-panel'))
            new MenuItem(name: 'control-panel', controller: 'controlPanel', action: 'index',
                    title: 'Click here to access Admin\'s Control Panel', label: 'Control Panel', roles: 'ROLE_ADMIN', ordernumber: 0).save(flush: true)

        // add branch root
        def branchesRoot = [
                ['TNG-H', 'TNG Holdings Group', 'TNG', 0, '1']]

        branchesRoot.each {
            if (!Branch.findByNameAndShortname(it[1], it[2])) {
                def m = new Branch(code: it[0], name: it[1], shortname: it[2], level: it[3], parent: null, active: true)
                m.save(flush: true, failOnError: true)
            }
        }

        def branchLv1 = [['TNG', 'TNG-H', 'Công ty TNG', 'Công ty TNG', 1, 'Công ty cổ phần đầu tư TNG Holdings Việt Nam']]

        branchLv1.each {
            def parentRoot = Branch.findByCode(it[1])
            if (!Branch.findByCodeAndSequenceCode(it[0], it[0])) {
                def m = new Branch(code: it[0], sequenceCode: it[0], name: it[2], shortname: it[3], level: it[4], parent: parentRoot, active: true, realName: it[5])
                m.save(flush: true)
            }
        }

        def branchOther = [['TNG.001', '001', 'Ban tác nghiệp (MB)', 2, 'TNG']]

        branchOther.each {
            def parent = Branch.findByCode(it[4])
            if (parent) {
                if (!Branch.findByCodeAndSequenceCode(it[0], it[1])) {
                    def m = new Branch(code: it[0], sequenceCode: it[1], name: it[2], shortname: it[2], level: it[3], parent: parent, active: true)
                    m.save(flush: true)
                }
            }
        }
        //end branch

        // role group
        def rolegroups = [
                ['Admin', 'Admin'],
                ['ROLE_MANAGER', 'Cán bộ quản lý phê duyệt phiếu'],
                ['ROLE_NHANVIEN', 'Cán bộ tạo phiếu']
        ]

        RoleGroup roleGroup

        rolegroups.each {
            if (!RoleGroup.findByAuthority(it[0])) {
                roleGroup = new RoleGroup(authority: it[0], name: it[1]).save(flush: true)
            }
        }
        Role role
        // role
        def roles = [
                ['ROLE_ADMIN', 'Admin', '[[];[];[];[];[];[];[]]', 'Admin'],
                ['ROLE_MANAGER', 'ROLE_MANAGER', '[[];[];[];[];[];[];[]]', 'ROLE_MANAGER'],
                ['ROLE_NHANVIEN', 'ROLE_NHANVIEN', '[[];[];[];[];[];[];[]]', 'ROLE_NHANVIEN']

        ]
        roles.each {
            role = Role.findByAuthority(it[0])
            if (!role) {
                RoleGroup rg = RoleGroup.findByAuthority(it[1])
                if (rg) {
                    role = new Role(authority: it[0], name: it[0], roleGroup: rg, active: true, dschucnang: it[2], diengiai: it[3], canbedeleted: false)
                    role.save(flush: true)
                }
            }
        }

        def users = [['admin', 'admin', 'ROLE_ADMIN', 'adminemail']]

        users.each {
            if (!User.findByUsername(it[0])) {
                def user = new User(username: it[0], fullname: it[1], adOnly: false, password: '1', enabled: true, email: it[3])
                validateAndSave(user, "user")

                def userRole = new UserRole()
                user.setId(1)
                def roleAdmin = Role.findById(1)
                userRole.setUser(user)
                userRole.setRole(roleAdmin)
                validateAndSave(userRole, "userRole")
            }
        }


        for (String url in [
                '/', '/errors/**', '/index', '/index.gsp', '/**/favicon.ico', '/shutdown',
                '/assets/**', '/**/js/**', '/**/css/**', '/**/images/**',
                '/melanin/login', '/melanin/login.*', '/melanin/login/*',
                '/melanin/logout', '/melanin/logout.*', '/melanin/logout/*',
                '/melanin/switchDashboard', '/direct/index', '/melanin/refresh',
                '/melanin/keep_login_session', '/melanin/changePassword', '/logout/index',
                '/direct/downloadFileHDSD'
        ]) {
            new RequestMap(url: url, configAttribute: 'permitAll').save()
        }

        new RequestMap(url: '/melanin/**', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/admin/**', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/**', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/thongKe/**', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/nhan/**', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/cauHoiVaTraLoi/**', configAttribute: 'ROLE_ADMIN').save()
        new RequestMap(url: '/huanLuyenVaThucNghiem/**', configAttribute: 'ROLE_ADMIN').save()
        springSecurityService.clearCachedRequestmaps()
    }
    def destroy = {
    }

    def validateAndSave(def saveObj, String name) {
        boolean check = false
        if (!saveObj.validate()) {
            saveObj.errors.each {
                println "ERROR WHEN VALIDATING " + name
                println it
            }
        } else {
            if (!saveObj.save(flush: true, failOnError: true)) {
                saveObj.errors.each {
                    println "ERROR WHEN SAVING " + name
                    println it
                }
            } else {
                check = true
            }
        }
        return check
    }
}
