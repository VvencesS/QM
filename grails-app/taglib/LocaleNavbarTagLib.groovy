import grails.config.Config
import grails.core.support.GrailsConfigurationAware
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

class LocaleNavbarTagLib implements GrailsConfigurationAware {

    static namespace = 'navBar'

    static defaultEncodeAs = [taglib: 'none']

    MessageSource messageSource

    List<String> languages

    @Override
    void setConfiguration(Config co) {
        languages = co.getProperty('guide.languages', List) // <1>
    }

    def localeDropdownListItems = { args ->
        String uri = args.uri
        for (String lang : languages) {
            String languageCode = "language.$lang"

            def locale = LocaleContextHolder.locale
            def msg = messageSource.getMessage(languageCode, [] as Object[], null, locale) // <3>
            out << "<li id='lang_${lang}'><span style='display: none'>${lang}</span><a href='#'><img src='/assets/${lang}.jpg' alt='language_logo_${lang}'/> ${msg}</a></li>"
        }
    }
}

