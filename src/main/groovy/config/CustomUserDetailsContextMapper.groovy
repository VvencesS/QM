package config

import com.commons.Constant
import com.melanin.commons.MapEmailLdapToBranch
import com.melanin.commons.MapOuLdapToBranch
import com.melanin.security.Role
import com.melanin.security.User
import com.melanin.security.UserRole
import grails.gorm.transactions.Transactional
import grails.plugin.cookie.CookieService
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.ldap.core.DirContextAdapter
import org.springframework.ldap.core.DirContextOperations
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper

class CustomUserDetailsContextMapper implements UserDetailsContextMapper {
    private static final List NO_ROLES = [new SimpleGrantedAuthority(SpringSecurityUtils.NO_ROLE)]

    @Override
    @Transactional
    CustomUserDetails mapUserFromContext(DirContextOperations ctx, String username, Collection<? extends GrantedAuthority> authorities) {
        User user = User.findByUsername(username)

        //Neu khong ton tai user trong hệ thống thì tạo user và gán quyền nhân viên
        if (!user) {
            String email = ctx.attributes.get('mail')?.get() as String
            String phone = ctx.attributes.get('telephoneNumber')?.get() as String
            String maNhanVien = ctx.attributes.get('postOfficeBox')?.get() as String
            String displayName = ctx.attributes.get('cn')?.get() as String

            String distinguishedName = ctx.attributes.get('distinguishedName')?.get() as String

            //begin: get don vi cua user
            def branch
            def listOuLdap = MapOuLdapToBranch.findAll();
            for (def o in listOuLdap) {
                if (distinguishedName.contains(o.ou)) {
                    branch = o.branch
                    break;
                }
            }

            if (!branch) {
                def listEmailLdap = MapEmailLdapToBranch.findAll();
                for (def e in listEmailLdap) {
                    if (email.contains(e.email)) {
                        branch = e.branch
                        break;
                    }
                }
            }
            //end

            if (branch) {
                // Create new user and save to the database
                user = new User()
                user.username = username
                user.password = Constant.defaultPassWord
                user.email = email
                user.sodienthoai = phone
                user.maNhanVien = maNhanVien
                user.fullname = displayName
                user.chucVu = "Nhân viên"
                user.branch = branch
                user.save(flush: true, failOnError: true)

                UserRole userRole = new UserRole()
                userRole.user = user
                userRole.role = Role.findByAuthority(Constant.ROLE_NHANVIEN) // Default role
                userRole.save(flush: true, failOnError: true)

                Collection<GrantedAuthority> authority = user.getAuthorities().collect { new SimpleGrantedAuthority(it.authority) }

                //set cookie role
                StringBuilder roles = new StringBuilder();
                int count = 0;
                for (UserRole userRole1 : userRole) {
                    if (count == 0) {
                        count++;
                        roles.append(userRole1.role.roleGroup.authority)
                    } else {
                        roles.append("-" + userRole1.role.roleGroup.authority)
                    }
                }
                CookieService cookieService = new CookieService();
                cookieService.setCookie("role", roles.toString(), 24 * 60 * 60, "/")

                //uuid
                UUID uuid = UUID.randomUUID();
                String randomUUIDString = uuid.toString();
                cookieService.setCookie("uuid", randomUUIDString, 60 * 60, "/")

                UserDetails userDetails = new CustomUserDetails(username, user.password, user.enabled, false, false, false, authority, user.id, user.fullname)
                return userDetails
            } else {
                UserDetails userDetails = new CustomUserDetails(username, '', true, false, false, false, NO_ROLES, 0, '')
                return userDetails
            }
        } else {
            Collection<GrantedAuthority> authority = user.getAuthorities().collect { new SimpleGrantedAuthority(it.authority) }

            UserDetails userDetails = new CustomUserDetails(username, user.password, user.enabled, false, false, false, authority, user.id, user.fullname)
            return userDetails
        }

    }

    @Override
    void mapUserToContext(UserDetails user, DirContextAdapter ctx) {
        throw new IllegalStateException("Only retrieving data from AD is currently supported")
    }
}
