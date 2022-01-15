package qm

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
        "/"(controller:'melanin',action:'login')
//        "/"(view:"/index")
        "500"(view:'/errors/500')
        "403"(view:'/errors/403')
        "404"(view:'/errors/404')
    }
}

