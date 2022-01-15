import config.CustomUserDetailsService
import config.UserPasswordEncoderListener
import org.springframework.web.servlet.i18n.SessionLocaleResolver
import config.CustomUserDetailsContextMapper

// Place your Spring DSL code here
beans = {
    ldapUserDetailsMapper(CustomUserDetailsContextMapper)
    userDetailsService(CustomUserDetailsService)

    userPasswordEncoderListener(UserPasswordEncoderListener)
    localeResolver(SessionLocaleResolver) {
        defaultLocale= new java.util.Locale('vi');
    }
    xmlns task: "http://www.springframework.org/schema/task"
    task.'annotation-driven'('proxy-target-class': true)


}