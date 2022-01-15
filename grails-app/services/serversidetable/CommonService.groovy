package serversidetable

import com.melanin.fingerprint.Branch
import com.melanin.security.User
import grails.plugin.springsecurity.SpringSecurityService

class CommonService {

    def index() {}

    def getListUsers() {
        def listUser = User.findAll("from User u where u.username <> 'admin' order by u.fullname")
        return listUser
    }

    def getListUsersInBranch(def branch) {
        def listUser = User.findAll("from User u where u.branch = :branch order by u.fullname", [branch: branch])
        return listUser
    }

    def getListBranch() {
        def listBranch = Branch.findAll("from Branch b where active = true and status is null order by b.id")
        return listBranch
    }

    def getListDonViSuDungInBranchToString(Branch branch) {
        def listBranch = Branch.findAll("from Branch b where b.level in (1, 2) AND active = true AND status is null AND (b.id =:id OR b.parent =:branch) order by b.code",
                [id: branch.id, branch: branch])
        StringBuilder listBranchString = new StringBuilder()
        if (listBranch) {
            for (def br : listBranch) {
                listBranchString.append(br.id);
                listBranchString.append(", ");
            }
            listBranchString.append("0")
            return listBranchString.toString()
        } else {
            return ""
        }
    }

    def getListBranchView() {
        def listBranch = Branch.findAll("from Branch b where b.level = 1 AND status is null order by b.id")
        return listBranch
    }

    def changeListObjIdToStringId(def listObj) {
        StringBuilder listObjString = new StringBuilder()
        if (listObj) {
            for (def obj : listObj) {
                listObjString.append(obj.id);
                listObjString.append(", ");
            }
            listObjString.append("0")
            return listObjString.toString()
        } else {
            return ""
        }
    }

    // comment => tắt chương trình lưu trũ notification
    def save_notification(def type, def title, def linkId, def oneOrTowLv) {
//        def notif = new Notification()
//        notif.saveViewAccount = springSecurityService.currentUser.username + ","
//        notif.typeNotify = type;
//        notif.titleNotify = title;
//        notif.roleShow = (oneOrTowLv == 1 ? ROLE_LV1() : ROLE_LV2())
//        notif.createBy = springSecurityService.currentUser.username;
//        switch (type) {
//            case Constant.LOAIPHIEU_NHAPKHO:
//                notif.linkPage = '/quanLyNhapKho/create_update_nhapkho?id=' + linkId
//                break
//            case Constant.LOAIPHIEU_KHAITANG:
//                notif.linkPage = '/quanLyKhaiTangKho/create_update_phieu_khaitang?id=' + linkId
//                break
//            case Constant.LOAIPHIEU_XUATKHO:
//                break
//            case Constant.LOAIPHIEU_SUA_TAISAN:
//                break
//            case Constant.LOAIPHIEU_DCDV:
//                notif.linkPage = '/thuHoiDieuchuyenDv/create_update_th_dc?method=DC&id=' + linkId
//                break
//            case Constant.LOAIPHIEU_THUHOI:
//                notif.linkPage = '/thuHoiDieuchuyenDv/create_update_th_dc?method=TH&id=' + linkId
//                break
//            case Constant.LOAIPHIEU_DIEUCHUYEN_NB:
//                break
//            case Constant.LOAIPHIEU_THANHLY_TS:
//                break
//            case Constant.LOAIPHIEU_NANGCAP_TS:
//                break
//            default:
//                notif.linkPage = "";
//                break
//        }
//        notif.save(flush: true, failOnError: true)
    }

}
