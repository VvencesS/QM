package melanin.log

import com.melanin.commons.MelaninLogAction

class MelaninLogService {
    def melaninCommonService


    def savelog(String username, String actionname, String ipaddress, String parameters, String exception, String action_controller, String note) {
        def lg = new MelaninLogAction()
        lg.username = username
        lg.actiontime = new Date()
        lg.actionname = actionname
        lg.ipaddress = ipaddress
        lg.parameters = parameters
        lg.exception = exception
        lg.action_controller = action_controller
        lg.note = note
        melaninCommonService.validateAndSave(lg, "LOG FOR DEV")
    }

    def savelog(def request, def actionUri, def params, String actionname, Exception e) {
        if (!e) {
            savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", params, "", actionUri, "")
        } else {
            savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", params, e?.getMessage() + " || " + e?.class, actionUri, "ERROR")
        }
    }

    def savelog(def request, def actionUri, def params, String actionname, Exception e, String note) {
        if (!e) {
            savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", params, "", actionUri, note)
        } else {
            savelog("${request.remoteUser}", actionname, "${request.remoteAddr}", params, e?.getMessage() + " || " + e?.class, actionUri, "ERROR")
        }
    }
}
