<%@ page import="com.commons.Constant;" %>
%{----}%
%{--<g:set var="hdr" value="${new com.melanin.commons.SidebarItem()}"/>--}%
%{--<g:set var="hdr" value="${hdr}"/>--}%

<form id="update_ThemMoi" novalidate="novalidate">

    <g:hiddenField name="edit_or_new" value="${edit_or_new}"/>
    <g:hiddenField name="id_div_addupdate" value="${hdr?.id}"/>

    <div class="row">
        <div class="col-md-12">
            <div class="portlet box deepblue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-reorder"/>
                        <span>Chỉnh sửa Sidebar item</span>
                    </div>
                    <div class="tools">
                        <a class="collapse"></a>
                    </div>
                </div>

                <div class="portlet-body">

                    <div class="row">
                        <div class="col-md-12">

                            <div class="form-group">
                                <label class="control-label col-md-2">Nội dung hiển thị *</label>

                                <div class="col-md-4">

                                    <g:textField class="form-control clearTextPoint requiredz" maxlength="500"
                                           type="text" name="label"
                                           value="${hdr?.label}"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2">Thuộc về Menu Item nào? *</label>

                                <div class="col-md-4">

                                    <g:select name="menuItem"
                                              noSelection="['': '']"
                                              class="form-control clearText requiredz"
                                              from="${com.melanin.commons.MenuItem.findAll("from MenuItem as t order by t.ordernumber")}"
                                              optionKey="id" optionValue="${{ b -> "${b.label}" }}"
                                              value="${hdr?.menuItem?.id}"
                                              disabled="true"/>
                                </div>
                                <script>
                                    $('#menuItem').select2({
                                        placeholder: "Chọn trong danh sách",
                                        allowClear: true
                                    });
                                </script>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2">Các role được phép truy cập*</label>

                                <div class="col-md-4">
                                    <g:select name="rolez" id="rolez"
                                              from="${com.melanin.security.Role.findAll()}"
                                              class="form-control input-sm"
                                              optionKey="authority"
                                              optionValue="authority"
                                              multiple="true"
                                              noSelection="['': '']"/>
%{--                                    <g:textArea class="form-control clearTextPoint requiredz" maxlength="500"--}%
%{--                                           name="roles" rows="4" style="font-size: 10px;"--}%
%{--                                           value="${hdr?.roles}"/>--}%
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2">Số thứ tự hiển thị*</label>

                                <div class="col-md-4">
                                    <g:field class="form-control clearTextPoint requiredz"
                                             min = "0" name="ordernumber" type="number"
                                             value="${hdr?.ordernumber}"/>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2">Controller*</label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint requiredz" maxlength="200"
                                                 type="text" name="controller_input"
                                                 value="${hdr?.controller}"
                                                 disabled="true" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2">Action*</label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint requiredz" maxlength="200"
                                                 type="text" name="action_input"
                                                 value="${hdr?.action}"
                                                 disabled="true"/>
                                </div>

                            </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">

                            <div class="form-group">
                                <label class="control-label col-md-2">URL Param*</label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint requiredz" maxlength="200"
                                                 type="text" name="urlParam"
                                                 value="${hdr?.urlParam}"
                                                 disabled="true" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2">Level*</label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint requiredz" maxlength="200"
                                                 type="text" name="level"
                                                 value="${hdr?.level}"
                                                 disabled="true" />
                                </div>
                            </div>




                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2">Item mẹ *</label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint requiredz" maxlength="200"
                                                 type="text" name="parentItem"
                                                 value="${hdr?.parentItem?.htmlElementId}"
                                                 disabled="true"/>
                                </div>

                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2">ID của HTML Element*</label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint" maxlength="200"
                                                 type="text" name="htmlElementId"
                                                 value="${hdr?.htmlElementId}" disabled="true"/>

                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="control-label col-md-2 col-md-offset-6">Icon</label>

                                <div class="col-md-4">
                                    <g:textField class="form-control clearTextPoint" maxlength="200"
                                                 type="text" name="icon"
                                                 value="${hdr?.icon}"/>
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

<script type="application/javascript">
    $(function () {
        melanin_validate.valid_form('#update_ThemMoi');

        var edit_or_new = $('#edit_or_new').val();

        $('#rolez').select2({
            placeholder: "-Chọn quyền sử dụng-",
            allowClear: true
        });

        $('button[name=form-button-save]').click(function (e) {
            e.preventDefault();
            if ($('#update_ThemMoi').valid()) {
                // common.showSpinner();
                $.ajax({
                    type: "POST",
                    async: true,
                    data: $("#update_ThemMoi").serialize(),
                    url: "${createLink(controller:'sidebar',action:'add_Item')}",
                    success: function (data) {
                        // common.hideSpinner();
                        if (!data.success) {
                            common.showToastr('error', 'Lỗi', data.msg, 'toast-top-right');
                        } else {
                            common.showToastr('success', 'Thông báo', data.msg, 'toast-top-right');
                            $('#div_ThemMoi').hide('blind',function () {
                                $('#div_ThemMoi').empty();
                            });

                            $.ajax({
                                type: "POST",
                                async: false,
                                url: "${createLink(controller:'sidebar',action:'lay_div_DMuc_Item')}",
                                success: function (data) {
                                    // common.hideSpinner();
                                    $('#div_dm_Item').html(data.divCC);
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    // common.hideSpinner();
                                    if (textStatus === "timeout") {
                                        jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                                    } else {
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

        $("button[name=form-button-cancel]").click(function (e) {
            $('#div_ThemMoi').hide('blind',function () {
                $('#div_ThemMoi').empty();
                // $('#div_ThemMoi').show('blind');
            });
            e.preventDefault();
        });

    });

</script>