<form id="form_addupdate" novalidate="novalidate" style="margin-bottom: 1rem;">
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box deepblue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-reorder"/>
                        <span>Thêm mới Nhãn</span>
                    </div>

                    <div class="tools">
                        <a class="collapse"></a>
                    </div>
                </div>

                <div class="portlet-body">
                    <g:hiddenField name="crud" value="${crud}"/>

                    <div class="row">
                        <div class="col-md-12">

                            <div class="form-group">
                                <label class="control-label col-md-2">
                                    Mã nhãn <span style="color: red">*</span>
                                </label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint requiredz"
                                                 type="text" name="maNhan"
                                                 value="${hdr?.maNhan}"
                                                 oninput="this.value = this.value.toLowerCase()"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2">
                                    Tên nhãn <span style="color: red">*</span>
                                </label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint requiredz"
                                                 type="text" name="tenNhan"
                                                 value="${hdr?.tenNhan}"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2">
                                    Nhãn cha
                                </label>

                                <div class="col-md-4">
                                    <g:select name="parentItem"
                                              class="form-control clearText select2"
                                              noSelection="['': '']"
                                              from="${nhanArrayList}"
                                              optionKey="id"
                                              optionValue="${{ b -> "${b.maNhan} - ${b.tenNhan}" }}"
                                              value="${hdr?.parentItem?.id}"/>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <g:hiddenField name="hdrId" value="${hdr?.id}"/>
                                <div class="col-xs-3"></div>

                                <div class="col-xs-9">
                                    <button class="btn btn-save" name="form-button-save">
                                        <i class="icon-ok"></i> Lưu
                                    </button>

                                    <button name="form-button-cancel" class="btn yellow">
                                        <i class="icon-ban-circle"></i> Hủy
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12"></div>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">
    $(function () {
        $('.select2').select2({
            allowClear: true   // Shows an X to allow the user to clear the value.
        });

        // nút thêm mới
        $('button[name=form-button-save]').on('click', function (e) {
            e.preventDefault();
            if ($('#form_addupdate').valid()) {
                $.ajax({
                    type: "POST",
                    async: true,
                    data: $("#form_addupdate").serialize(),
                    url: "${createLink(controller:'nhan',action:'crudNhan')}",
                    success: function (data) {
                        if (!data.success) {
                            common.showToastr('error', 'Lỗi', data.msg, 'toast-top-right');
                        } else {
                            common.showToastr('success', 'Thông báo', data.msg, 'toast-top-right');
                            $('#div_ThemMoi').hide('blind', function () {
                                $('#div_ThemMoi').empty();
                            });

                            // Load lại dm
                            $.ajax({
                                type: "POST",
                                async: false,
                                url: "${createLink(controller:'nhan',action:'layDivDMNhan')}",
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
        });
    });
</script>