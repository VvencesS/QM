<%@ page import="com.melanin.security.UserRole" %>
<%@ page import="com.melanin.security.RoleGroup" %>
<%@ page import="com.melanin.security.User" %>
<%@ page import="com.melanin.fingerprint.Module" %>
<%@ page import="com.melanin.security.Role" %>

<g:form name="m-melanin-form-role-details" id="m-melanin-form-role-details"
        controller="fingerprint" action="addRoleGroup" class="form-horizontal">
    <g:hiddenField name="edit_or_new" id="edit_or_new" value="${edit_or_new}"/>
    <g:hiddenField name="role_id_div_addupdate_rolegroup" id="role_id_div_addupdate_rolegroup" value="${role_group?.id}"/>
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box deepblue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-reorder"></i> Thêm mới/ Cập nhật nhóm quyền
                    </div>
                </div>

                <div class="portlet-body form">
                    <g:form class="form-horizontal" name="formTimKiem"
                            data-toggle="validator" id="formTimKiem">
                        <div class="form-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-2">Mã nhóm quyền*</label>

                                        <div class="col-md-4">
                                            <input
                                                    class="form-control clearText requiredz" maxlength="255"
                                                    type="text" id="authority"
                                                    value="${role_group?.authority}"
                                                    data-minlength="4" name="authority">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-2">Tên nhóm *</label>

                                        <div class="col-md-4">
                                            <input
                                                    class="form-control clearText requiredz" maxlength="255"
                                                    type="text" id="name"
                                                    value="${role_group?.name}"
                                                    data-minlength="4" name="name">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-actions fluid">
                                <div class="col-md-offset-3 col-md-9">
                                    <g:hiddenField name="roleId" value="${role_group?.id}"/>
                                    <button class="btn btn-save" type="button"
                                            name="m-melanin-form-button-save">
                                        <i class="icon-ok"></i> Save
                                    </button>
                                    <button class="btn red"
                                            name="m-melanin-form-button-delete">
                                        <i class="icon-trash"></i> Delete
                                    </button>
                                    <button name="m-melanin-form-button-cancel"
                                            class="btn yellow">
                                        <i class="icon-ban-circle"></i> Cancel
                                    </button>
                                </div>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </div>
</g:form>
<script type="application/javascript">
    $(function () {
        melanin_validate.valid_form('#m-melanin-form-role-details');

        $('button[name=m-melanin-form-button-save]').click(function (e) {
            debugger;
            if ($('#m-melanin-form-role-details').valid()) {
                $('form[name=m-melanin-form-role-details]').submit();
            }
        });

        $("button[name=m-melanin-form-button-cancel]").click(function (e) {
            $("#m-melanin-form-section").hide('blind');
            $('#div_themmoi_capnhat_role').empty();
            e.preventDefault();
        });

        $("button[name=m-melanin-form-button-delete]").click(function (e) {
            e.preventDefault();
            var rid = $(this).attr("rel");
            var messageContent = common.messageContent('icon-ok-sign', 'M', null, 'Bạn chắc chắn muốn xóa nhóm quyền này?');
            var titleContent = common.titleContent(null, 'Xác nhận');

            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa nhóm quyền này?', function (result) {
                if (result) {
                    common.showSpinner();
                    document.location = "${createLink(controller:'fingerprint',action:'deleteRoleGroup')}/" + rid;
                    common.hideSpinner();
                }
            });
        });

        $('#module').change(function () {
            if (!$('#module').val() || $('#module').val() == '') {
                $('#div_dschucnang').empty();
                $('#div_dschucnangdaphanquyen').empty();
            } else {
                var module = $('#module').val();
                common.showSpinner();
                $.ajax({
                    type: "POST",
                    async: false,
                    data: {module: module},
                    url: "${createLink(controller:'fingerprint',action:'laydanhsachchucnangtheomodule')}",
                    success: function (data) {
                        common.hideSpinner();
                        $('#div_dschucnang').html(data.divCC);
                    },
                    error: function (err) {
                        $('#div_dschucnang').empty();
                        $('#div_dschucnangdaphanquyen').empty();
                        common.hideSpinner();
                        common.showToastr('error', 'Lỗi', err, 'toast-bottom-right');
                    }
                });
            }
        });
    });

</script>