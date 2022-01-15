<style>
div#modal_ViewOrInsertOrUpdate ul.nav-tabs li {
    padding: 0px;
}

div#modal_ViewOrInsertOrUpdate ul.nav-tabs li a {
    overflow-x: hidden;
    display: block;
}

div#modal_ViewOrInsertOrUpdate ul.nav-tabs li.active a {
    font-weight: 400;
    border-top: 3px solid #393393 !important;
}
</style>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button class="close" aria-hidden="true" data-dismiss="modal"
                    type="button"></button>
            <h4 class="modal-title">Thêm mới câu hỏi và trả lời</h4>
        </div>

        <div class="modal-body">
            <fieldset class="tam_fieldset" style="min-width: 0; background: white">
                <legend class="tam_legend">1. Thông tin nhãn</legend>

                <form id="thongTinNhan" novalidate>
                    <g:render template="/qm/cauHoiVaTraLoi/div_nhapLieuNhan"/>
                </form>
            </fieldset>
            <fieldset class="tam_fieldset" style="min-width: 0; background: white">
                <legend class="tam_legend">1. Thông tin câu hỏi và trả lời</legend>

                <g:render template="/qm/cauHoiVaTraLoi/table_dsCauHoiVaTraLoi"/>
            </fieldset>

            <div class="row">
                <div class="col-xs-12" style="padding-top: 15px; text-align: center" id="saveAndCancelButtonGroup">
                    <button class="btn green search" name="form-button-save">
                        <i class="icon-ok"></i> Lưu và kết thúc
                    </button>
                    <button class="btn btn-save" name="form-button-cancel">
                        <i class="icon-ban-circle"></i> Thoát
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function () {
        $('div#saveAndCancelButtonGroup button[name=form-button-save]').on('click', function (e) {
            e.preventDefault();
            $(":button:contains('OK')").attr('disabled', true);
            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn lưu?', function (result) {
                if (result) {
                    var fdata = tao_formData()
                    if (fdata == "loiDuLieu") {
                        common.showToastr('error', 'Lỗi', 'Có lỗi xảy ra!', 'toast-top-right');
                        return;
                    }
                    $.ajax({
                        type: "POST",
                        data: fdata,
                        url: "<g:createLink controller='cauHoiVaTraLoi' action='crudCauHoiVaTraLoi' />",
                        contentType: false,
                        processData: false,
                        success: function (data, textStatus, jqXHR) {
                            if (!data.success) {
                                common.showToastr('error', 'Lỗi', data.msg, 'toast-top-right');
                            } else {
                                common.showToastr('success', 'Thông báo', data.msg, 'toast-top-right');

                                $('#thongTinNhan [name="nhans"]').val(null).trigger('change');
                                window.dataDsCH_TL = []
                                window.dataDsCH_TLXoa = []
                                window.tableDmItem_1.clear().rows.add(dataDsCH_TL).draw();
                                $('#modal_ViewOrInsertOrUpdate').modal('hide');

                                setTimeout(function () {
                                    document.location = "${createLink(controller:'cauHoiVaTraLoi',action:'index_CauHoiVaTraLoi')}";
                                    location.reload();
                                }, 500);

                                $.ajax({
                                    type: "POST",
                                    async: false,
                                    url: "${createLink(controller:'cauHoiVaTraLoi',action:'layDivDMCauHoiVaTraLoi')}",
                                    success: function (data) {
                                        $('#portlet_danhMuc').html(data.divCC);
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        common.hideSpinner();
                                        if (textStatus === "timeout") {
                                            jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                                        } else {
                                            common.hideSpinner();
                                            if (jqXHR.status == '403') {
                                                common.showToastr('error', 'Lỗi', 'Bạn không có quyền thực hiện thao tác này!', 'toast-top-right');
                                            } else {
                                                common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');
                                            }
                                        }
                                    }
                                });

                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            if (textStatus === "timeout") {
                                jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                            } else if (jqXHR.status == '403') {
                                common.showToastr('error', 'Lỗi 403', 'Bạn không có quyền thực hiện thao tác này!', 'toast-top-right');
                            } else if (jqXHR.status == '500') {
                                common.showToastr('error', 'Lỗi 500', 'Gặp lỗi trong quá trình xử lý', 'toast-top-right');
                            } else {
                                common.showToastr('error', 'Lỗi ' + jqXHR.status, errorThrown, 'toast-top-right');
                            }
                        }
                    });
                }
            });

        });

        $('div#saveAndCancelButtonGroup button[name=form-button-cancel]').on('click', function (e) {
            e.preventDefault();
            $(":button:contains('OK')").attr('disabled', true);
            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn hủy thao tác?', function (result) {
                if (result) {
                    $('#thongTinNhan [name="nhans"]').val(null).trigger('change');
                    window.dataDsCH_TL = []
                    window.dataDsCH_TLXoa = []
                    window.tableDmItem_1.clear().rows.add(dataDsCH_TL).draw();
                    $('#modal_ViewOrInsertOrUpdate').modal('hide');
                }
            });
        });

        function tao_formData() {
            var fdata = new FormData();

            if (!$('form#thongTinNhan').valid() || $('form#thongTinNhan [name=nhans]').val() == null) {
                return "loiDuLieu";
            }
            var objNhan = {};
            objNhan = window.luuThongTinNhan(objNhan);
            fdata.append("objNhan", JSON.stringify(objNhan));

            var dataDsCH_TL = data_ItemTable();
            if (dataDsCH_TL == "loiDuLieu") {
                return "loiDuLieu";
            }
            fdata.append("dataDsCH_TL", dataDsCH_TL);
            fdata.append("dataDsCH_TLXoa", JSON.stringify(dataDsCH_TLXoa));
            return fdata;
        }


    });


</script>

<style>
#modal_ViewOrInsertOrUpdate .modal-dialog {
    /*transform: translate(0, 5vh) !important;*/
    /*top: 0% !important;*/
    width: 95%;
    min-width: 350px;
}

.modal {
    overflow-x: hidden;
    overflow-y: auto;
    width: 100vw !important;
}

.modal-open {
    overflow: hidden;
}

.modal.fade.show .modal-dialog {
    transform: translate(0, 3%) !important;
}
</style>