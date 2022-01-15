package melanin.common

class MelaninCommonService {

    def serviceMethod() {

    }

    def validateAndSave(def saveObj, String name){
        if (!saveObj.validate()) {
            saveObj.errors.each {
                println "ERROR WHEN VALIDATING "+name
                println it
            }
        }else{
            if (!saveObj.save(flush:true)) {
                saveObj.errors.each {
                    println "ERROR WHEN SAVING "+name
                    println it
                }
            }
        }
    }

    def getIpAddressClient(def request){
        def ipAddress = request.getHeader("Client-IP")
        log.info ipAddress
        if (!ipAddress){
            ipAddress=request.getHeader("X-Forwarded-For")
            log.info "Used X-Forwarded-For header: $ipAddress"
        }
        if (!ipAddress){
            ipAddress=request.getRemoteAddr()
            log.info "Used RemoteAddr attribute: $ipAddress"
        }
        return ipAddress
    }

    def encodeString(def stringToEncode) {

        def reservedCaracters = [32: 1, 33: 1, 42: 1, 34: 1, 39: 1, 40: 1, 41: 1, 59: 1, 58: 1, 64: 1, 38: 1, 61: 1, 43: 1, 36: 1, 33: 1, 47: 1, 63: 1, 37: 1, 91: 1, 93: 1, 35: 1]
        def encoded = stringToEncode.collect { letter ->
            reservedCaracters[(int) letter] ? "%" +Integer.toHexString((int) letter).toString().toUpperCase() : letter
        }
        return encoded.join("")
    }
}
