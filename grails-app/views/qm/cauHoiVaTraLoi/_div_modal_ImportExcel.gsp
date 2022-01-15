<style>
div#modal_ImportExcel ul.nav-tabs li {
    padding: 0px;
}

div#modal_ImportExcel ul.nav-tabs li a {
    overflow-x: hidden;
    display: block;
}

div#modal_ImportExcel ul.nav-tabs li.active a {
    font-weight: 400;
    border-top: 3px solid #393393 !important;
}
</style>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button class="close" aria-hidden="true" data-dismiss="modal"
                    type="button"></button>
            <h4 class="modal-title">Import Excel câu hỏi và trả lời</h4>
        </div>

        <div class="modal-body">
            <fieldset class="tam_fieldset" style="min-width: 0; background: white">
                <legend class="tam_legend">1. Thông tin nhãn</legend>

                <form id="thongTinNhan_ImportExcel" novalidate>
                    <g:render template="/qm/cauHoiVaTraLoi/div_nhapLieuNhan_ImportExcel"/>
                </form>
            </fieldset>
            <fieldset class="tam_fieldset" style="min-width: 0; background: white">
                <legend class="tam_legend">2. Import Excel</legend>

                <g:form name="formUpload" novalidate="" method="post" controller="cauHoiVaTraLoi"
                        action="importExcel" enctype="multipart/form-data">
                    <div class="form-group col-md-5 col-md-offset-2">
                        <g:field class="form-control" type="file" name="file"/>
                    </div>

                    <div class="form-group col-md-2 ">
                        <button type="button" class="btn green default"
                                disabled="disabled" id="btnImport">
                            <i class="icon-upload"></i> Import file
                        </button>
                    </div>

                    <div style="clear: both"></div>

                    <div class="form-group col-md-5 col-md-offset-2">
                        <a href="<g:createLink controller='cauHoiVaTraLoi' action='exportTemplateExcel'/>"
                           title="File template mẫu">Tải file template Excel
                            <i class="icon-download-alt"></i>
                        </a>
                    </div>

                    <div style="clear: both"></div>

                    <div class="col-md-offset-2 col-sm-5" style="display: none">
                        <div class="progressz" id="progress_h">
                            <div class="barz" id="bar_h"></div>
                            <div class="percentz" id="percent_h">0%</div>
                        </div>
                    </div>
                    <div style="clear: both"></div>

                    <div id="loiDuLieu_upLoadExcel" class="alert alert-danger"
                         style="max-width: 600px; margin: auto; display: none">
                    </div>
                </g:form>
            </fieldset>
            <fieldset class="tam_fieldset" style="min-width: 0; background: white">
                <legend class="tam_legend">3. Thông tin câu hỏi và trả lời</legend>

                <g:render template="/qm/cauHoiVaTraLoi/table_dsCauHoiVaTraLoi_ImportExcel"/>
            </fieldset>

            <div class="row">
                <div class="col-xs-12" style="padding-top: 15px; text-align: center" id="saveAndCancelButtonGroup_ImportExcel">
                    <button class="btn green search" name="form-button-save_ImportExcel">
                        <i class="icon-ok"></i> Lưu và kết thúc
                    </button>
                    <button class="btn btn-save" name="form-button-cancel_ImportExcel">
                        <i class="icon-ban-circle"></i> Thoát
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="application/javascript">
    $(function () {
        $('div#saveAndCancelButtonGroup_ImportExcel button[name=form-button-save_ImportExcel]').on('click', function (e) {
            e.preventDefault();
            $(":button:contains('OK')").attr('disabled', true);
            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn lưu?', function (result) {
                if (result) {
                    var fdata = tao_formData()
                    if (fdata == "loiDuLieu") {
                        common.showToastr('warning', 'Cảnh báo', 'Kiểm tra các trường thông tin nhập!', 'toast-top-right');
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
                                $('#thongTinNhan_ImportExcel [name="nhans_ImportExcel"]').val(null).trigger('change');
                                window.dataDsCH_TL = []
                                window.dataDsCH_TLXoa = []
                                $('#modal_ImportExcel').modal('hide');
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

        function tao_formData() {
            var fdata = new FormData();

            if (!$('form#thongTinNhan_ImportExcel').valid() || $('form#thongTinNhan_ImportExcel [name=nhans_ImportExcel]').val() == null) {
                return "loiDuLieu";
            }
            var objNhan = {};
            objNhan = window.luuThongTinNhan_ImportExcel(objNhan);
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

    $(function () {
        $('#file').change(function () {
            if (this.files[0]) {
                var filesize = this.files[0].size;
                if (filesize > 20000000) {
                    common.showToastr('error', 'Lỗi', 'File lớn hơn giá trị cho phép ( 20MB ) !', 'toast-top-right');
                    this.value = '';
                } else {
                    var res = this.value.split(".");
                    var ext = res[res.length - 1];
                    ext = ext.toString().toLowerCase();
                    switch (ext) {
                        case 'xls':
                        case 'xlsx':
                            $('#btnImport').attr('disabled', false);
                            break;
                        default:
                            $('#btnImport').attr('disabled', true);
                            common.showToastr('error', 'Lỗi', 'Chỉ chấp nhận các định dạng sau: xls,xlsx!', 'toast-top-right');
                            this.value = '';
                    }
                }
            } else {
                $('#btnImport').attr('disabled', true);
            }
        });
    });

    $(function () {
        $('#btnImport').click(function () {
            if ($('#file').val() != '' ) {
                common.showToastr('warning', 'Thông báo', 'Đang upload, xin chờ đợi', 'toast-top-right');

                $('#loiDuLieu_upLoadExcel').html('')
                $('#loiDuLieu_upLoadExcel').css('display','none')
                $('#loiDuLieu_ItemTable').html('')
                $('#loiDuLieu_ItemTable').css('display','none')

                $('#formUpload').submit();
                $('#file').val('').change();
            } else {
                common.showToastr('error', 'Thông báo', 'Chưa lựa chọn file Excel/Txt', 'toast-top-right');
            }
        });
    });

    var dataSet;
    var div_bar_h = $('#progress_h');
    var bar_h = $('#bar_h');
    var percent_h = $('#percent_h');
    var result_h = $('#result_h');
    var percentValue_h = "0%";

    $('#formUpload').ajaxForm({
        // Do something before uploading
        beforeUpload: function () {
            result_h.empty();
            percentValue_h = "0%";
            bar_h.width = percentValue_h;
            percent_h.html(percentValue_h);
        },
        // Do somthing while uploading
        uploadProgress: function (event, position, total, percentComplete) {
            div_bar_h.show();
            var percentValue = percentComplete + '%';
            bar_h.width(percentValue)
            percent_h.html(percentValue);
        },
        // Do something while uploading file finish
        success: function () {
            var percentValue = '100%';
            bar_h.width(percentValue)
            percent_h.html(percentValue);
        },
        // Add response text to div #result when uploading complete
        complete: function (xhr) {
            // dataSet = JSON.parse(xhr.responseText).dataSet
            // tableDmItem.clear().rows.add(dataSet).draw()
            window.dataDsCH_TL = JSON.parse(xhr.responseText).data_import;
            window.tableDmItem_ImportExcel.clear().rows.add(dataDsCH_TL).draw();
            if (JSON.parse(xhr.responseText).danhSachLoi.length > 0) {
                common.showToastr('warning', 'Thông báo', 'Đã load dữ liệu vào bảng<br>Gặp lỗi tại một số ô dữ liệu', 'toast-top-right');
                hienThiLoi_fileUpload(JSON.parse(xhr.responseText).danhSachLoi)
            } else {
                common.showToastr('success', 'Thông báo', 'Đã load dữ liệu vào bảng', 'toast-top-right');
            }
        }
    });

    function hienThiLoi_fileUpload(dsLoi) {
        var strHTML = '';
        var intSoDong = 0;
        for (var i1 = 0; i1 < dsLoi.length; i1++) {
            strHTML += dsLoi[i1] + '<br>'
            intSoDong++
            if (intSoDong > 5) break;
        }
        $('#loiDuLieu_upLoadExcel').html(strHTML)
        $('#loiDuLieu_upLoadExcel').css('display', 'block')
    }
</script>

<style>
#modal_ImportExcel .modal-dialog {
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