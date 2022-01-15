package config

import com.melanin.security.User
import com.melanin.security.UserRole
import grails.gorm.transactions.Transactional
import grails.plugin.cookie.CookieService
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.userdetails.GrailsUserDetailsService
import org.springframework.dao.DataAccessException
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.security.ldap.userdetails.LdapUserDetailsService

class CustomUserDetailsService implements GrailsUserDetailsService {

    LdapUserDetailsService ldapUserDetailsService

    static final List NO_ROLES = [new SimpleGrantedAuthority(SpringSecurityUtils.NO_ROLE)]

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        return loadUserByUsername(username, true)
    }

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username, boolean loadRoles) throws UsernameNotFoundException, DataAccessException {

        User user = User.findByUsername(username)
        if (!user) {
            throw new UsernameNotFoundException('User not found')
        }
        def authorities = user.getAuthorities().collect { new SimpleGrantedAuthority(it.authority) }

        //set cookie role
        def userRole = UserRole.findAllByUser(user)
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

        return new CustomUserDetails(user.username, user.password, user.enabled,
                !user.accountExpired, !user.passwordExpired,
                !user.accountLocked, authorities ?: NO_ROLES, user.id,
                user.username)
    }
}
