<%@ page import="com.melanin.security.UserRole" %>
<%@ page import="com.melanin.security.RoleGroup" %>
<%@ page import="com.melanin.security.User" %>
<%@ page import="com.melanin.fingerprint.Module" %>
<%@ page import="com.melanin.security.Role" %>

<g:form name="m-melanin-form-role-details" id="m-melanin-form-role-details"
        controller="fingerprint" action="addRole2" class="form-horizontal">
    <g:hiddenField name="edit_or_new" id="edit_or_new" value="${edit_or_new}"/>
    <g:hiddenField name="role_id_div_addupdaterole" id="role_id_div_addupdaterole" value="${role?.id}"/>
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
                                        <label class="control-label col-md-2">Tên role*</label>

                                        <div class="col-md-4">
                                            <input placeholder="Tên role phải bắt đầu bằng chữ ROLE. VD: ROLE_DEV"
                                                   class="form-control clearText requiredz" maxlength="255"
                                                   type="text" id="rolename"
                                                   value="${role?.authority}"
                                                   oninput="this.value = this.value.toUpperCase()"
                                                <g:if test="${edit_or_new == "edit"}">
                                                    readonly="readonly"
                                                </g:if>
                                                   data-minlength="4" name="rolename">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-2">Tên nhóm quyền*</label>

                                        <div class="col-md-4">
                                            <g:select id="roleGroup" name="roleGroup"
                                                      noSelection="${['': '--Chọn--']}"
                                                      class="form-control clearText requiredz"
                                                      from="${RoleGroup.list()}" optionKey="id"
                                                      optionValue="name" value="${role?.roleGroup?.id}"/>
                                        </div>
                                        <label class="control-label col-md-2">Trạng thái*</label>

                                        <div class="col-md-4">
                                            <g:select id="active" name="active"
                                                      noSelection="${['': '--Chọn--']}"
                                                      class="form-control clearText requiredz"
                                                      from="['Active', 'Inactive']"
                                                      keys="${['true', 'false']}" value="${role?.active}"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-2">Diễn giải</label>

                                        <div class="col-md-10">
                                            <textarea name="diengiai" id="diengiai" rows="3"
                                                      cols="10" maxlength="500"
                                                      class="form-control clearArea">${role?.diengiai}</textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            %{--<div class="row">--}%
                            %{--<div class="col-md-12">--}%
                            %{--<div class="form-group">--}%
                            %{--<label class="control-label col-md-2">Người dùng</label>--}%

                            %{--<div class="col-md-10">--}%
                            %{--<g:if test="${role}">--}%
                            %{--<g:select id="users" name="users" multiple="multiple"--}%
                            %{--class="form-control select2 clearText"--}%
                            %{--from="${msb.platto.fingerprint.User.list()}"--}%
                            %{--optionKey="id" optionValue="username" value="${msb.platto.fingerprint.UserRole.findAllByRole(role)*.user}"/>--}%
                            %{--</g:if>--}%
                            %{--<g:else>--}%
                            %{--<g:select id="users" name="users" multiple="multiple"--}%
                            %{--class="form-control select2 clearText"--}%
                            %{--from="${msb.platto.fingerprint.User.list()}"--}%
                            %{--optionKey="id" optionValue="username"/>--}%
                            %{--</g:else>--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            <div class="row" style="display: none;">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-2">Danh sách chức năng theo module</label>

                                        <div class="col-md-10">
                                            <input
                                                    class="form-control clearText"
                                                    type="text" id="list_function_by_module"
                                                    data-minlength="4"
                                                    name="list_function_by_module" value="${role?.dschucnang}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-2">Chọn module</label>

                                        <div class="col-md-4">
                                            <g:select id="module" name="module"
                                                      noSelection="${['': '--Chọn--']}"
                                                      class="form-control clearText"
                                                      from="${Module.findAll("from Module where code <> 'QTHT'")}"
                                                      optionKey="id"
                                                      optionValue="name"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <div id="div_dschucnang" class="div_dschucnang"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <div id="div_dschucnangdaphanquyen"
                                                 class="div_dschucnangdaphanquyen"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-actions fluid">
                                <div class="col-md-offset-3 col-md-9">
                                    <g:hiddenField name="roleId" value="${role?.id}"/>
                                    <button class="btn btn-save" type="button"
                                            name="m-melanin-form-button-save">
                                        <i class="icon-ok"></i> Save
                                    </button>
                                    <g:if test="${role?.canbedeleted}">
                                        <button class="btn red"
                                                name="m-melanin-form-button-delete">
                                            <i class="icon-trash"></i> Delete
                                        </button>
                                    </g:if>

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
        var edit_or_new = $('#edit_or_new').val();
        if (edit_or_new == 'edit') {
            var role_id_div_addupdaterole = $('#role_id_div_addupdaterole').val();
            $.ajax({
                type: "POST",
                async: false,
                data: {role_id: role_id_div_addupdaterole},
                url: "${createLink(controller:'fingerprint',action:'lay_div_dschucnangdaphanquyen')}",
                success: function (data) {
                    common.hideSpinner();
                    $('#div_dschucnangdaphanquyen').html(data.divCC);
                },
                error: function (err) {
                    $('.div_dschucnangdaphanquyen').empty();
                    common.hideSpinner();
                    common.showToastr('error', 'Lỗi', err, 'toast-bottom-right');
                }
            });
        }

        $('.select2').select2();
        $('button[name=m-melanin-form-button-save]').click(function (e) {
            // debugger;
            if ($('#m-melanin-form-role-details').valid()) {
                common.showSpinner();
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
            var messageContent = common.messageContent('icon-ok-sign', 'M', null, 'Bạn chắc chắn muốn xóa role này?');
            var titleContent = common.titleContent(null, 'Xác nhận');

            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa role này?', function (result) {
                if (result) {
                    common.showSpinner();
                    document.location = "${createLink(controller:'fingerprint',action:'deleteRole')}/" + rid;
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