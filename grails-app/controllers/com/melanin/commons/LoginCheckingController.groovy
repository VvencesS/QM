package com.melanin.commons

/**
 * @author anhnnt1
 * Check login. Các controller khác chỉ cần extend thằng này, tự động logout nếu k có login
 */
class LoginCheckingController {

    def index() { }
	def springSecurityService
	def beforeInterceptor = {
		if(springSecurityService.principal.toString().equals("anonymousUser")){
			println('chua log in, log out...')
			redirect(controller:"melanin",action: "logout")
			return false
		}
	}
}
