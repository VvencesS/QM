<div class="modal-dialog" style="width: 60%;">
    <div class="modal-content">
        <div class="modal-header modal-import">
            <button class="close" aria-hidden="true" data-dismiss="modal"
                    type="button"></button>
            <h4 class="modal-title">
                Import nhân viên bằng file Excel
            </h4>
        </div>

        <div class="modal-body">
            <div class="form-body">
                <div class="row">
                    <div class="col-sm-12">
                        <form id="form-upload_h" method="post"
                              controller="fingerprint"
                              action="importExcel" enctype="multipart/form-data">
                            <div class="form-group">
                                <div class="col-sm-8">
                                    <input class="form-control" type="file" name="file" id="file_h"/>
                                    <br>
                                    <a href="${createLink(controller: 'fingerprint', action: 'exportFileMau')}"
                                       title="File mẫu">Tải file mẫu<i
                                            class="icon-download-alt"></i></a>
                                </div>

                                <div class="col-sm-2">
                                    <button type="button" class="btn green default" disabled="disabled"
                                            name="btn_import_h"
                                            id="btn_import_h"><i
                                            class="icon-upload"></i> Import nhân viên
                                    </button>
                                </div>

                                <div class="col-sm-2">
                                    <div class="progressz" id="progress_h"
                                         style="display: none">
                                        <div class="barz" id="bar_h"></div>

                                        <div class="percentz" id="percent_h">0%</div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <br>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div id="rowError"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="application/javascript">
    %{--Check file type & file size--}%
    $('#file_h').change(function () {
        if (this.files[0]) {
            var filesize = this.files[0].size;
            if (filesize > 20000000) {
                common.showToastr('error', 'Lỗi', 'File lớn hơn giá trị cho phép ( 20MB ) !', 'toast-top-right');
                this.value = '';
            } else {
                var res = this.value.split(".");
                //var ext = this.value.match(/\.(.+)$/)[1];
                var ext = res[res.length - 1];
                ext = ext.toString().toLowerCase();
                switch (ext) {
                    case 'xls':
                    case 'xlsx':
                        $('#btn_import_h').attr('disabled', false);
                        break;
                    default:
                        $('#btn_import_h').attr('disabled', true);
                        common.showToastr('error', 'Lỗi', 'Chỉ chấp nhận các định dạng sau: xls,xlsx!', 'toast-top-right');
                        this.value = '';
                }
            }
        }
    });

    $(function () {
        $('#btn_import_h').click(function () {
            $('#btn_import_h').attr('disabled', true);
            $('#form-upload_h').submit();
        });
    });

    var div_bar_h = $('#progress_h');
    var bar_h = $('#bar_h');
    var percent_h = $('#percent_h');
    var result_h = $('#result_h');
    var percentValue_h = "0%";
    $('#form-upload_h').ajaxForm({
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
            if (xhr.responseJSON.result == 'error') {
                common.showToastr('error', 'Lỗi', xhr.responseJSON.message, 'toast-top-right');
                div_bar_h.hide();
                $("#div_import_dialog .close").click();
            } else {
                if (xhr.responseJSON.rowComplete == xhr.responseJSON.rowExcel) {
                    common.showToastr('success', 'Thông báo', 'Import thành công ' + xhr.responseJSON.rowComplete + ' nhân viên!', 'toast-top-right');
                    /* tat div upload*/
                    $("#div_import_dialog .close").click();
                } else {
                    common.showToastr('warning',
                        'Thông báo', 'Import thành công ' +
                        xhr.responseJSON.rowComplete +
                        ' nhân viên. ' + 'Có ' +
                        xhr.responseJSON.rowError + ' nhân viên đã tồn tại, thông tin nhập không đúng hoặc có lỗi khi tạo!',
                        'toast-top-right');
                    $("#rowError").html(xhr.responseJSON.textAreaError);
                }
            }
        }
    });
</script>
