<%@ page import="com.commons.Constant; com.melanin.fingerprint.*" %>

<html>
<head>
    <meta name="layout" content="m-melanin-admin-layout"/>
    <title>Control Panel | Branch Management</title>
</head>

<body>
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN PAGE -->
    <div class="page-content">
        <!-- BEGIN PAGE CONTENT -->
        <!-- BEGIN PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">
                    Branch
                    <small>thông tin Branch</small>
                </h3>
                <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
                    <g:render template="/templates/m-melanin-action-bar"
                              model="${[
                                      buttons: [[name: 'm-melanin-action-bar-button-create-branch', label: 'Create', class: 'primary']]
                              ]}"/>
                    <g:render template="/templates/m-melanin-breadcrum"
                              model="${[
                                      items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                              [href: createLink(controller: 'fingerprint', action: 'index'), title: 'Fingerprint Control Panel', label: 'Fingerprint'],
                                              [href: createLink(controller: 'fingerprint', action: 'role'), title: 'Role Management', label: 'Branch Management']]
                              ]}"/>
                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->

        <div id="m-melanin-main-content">
            <g:if test="${flash.message}">
                <div id="flash-message" class="alert-message info" style="display:none;">${flash.message}</div>
            </g:if>
            <div class="row">
                <div class="col-md-4">
                    <div class="portlet box lpbblue">
                        <div class="portlet-title">
                            <div class="caption" id="">
                                <i class="icon-reorder"></i>
                                Cơ cấu tổ chức
                            </div>
                        </div>

                        <div class="portlet-body form">
                            <div class="m-melanin-hierarchy-tree" id="m-melanin-fingerprint-branch-tree"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div id="branch-info-section" class="left " style="display:none;">
                        <form id="branch-form" class="form-horizontal">
                            <div class="portlet box lpbblue">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="icon-reorder"></i>
                                        Thông tin đơn vị / phòng ban
                                    </div>
                                </div>

                                <div class="portlet-body form">
                                    <div class="form-body">
                                        <div id="alert-danger" class="alert alert-danger display-hide">
                                            <button class="close" data-dismiss="alert"></button>
                                            Bạn có một số lỗi. Hãy kiểm tra lại các trường bên dưới !
                                        </div>

                                        <div id="div_donviquanly">
                                            <div class="form-group">
                                                <label for="parentid"
                                                       class="col-md-3 control-label">Đơn vị quản lý</label>

                                                <div class="col-md-6">
                                                    <g:select name="parentid"
                                                              from="${Branch.findAllByStatusIsNullAndLevelLessThan(2, [sort: "code", order: "asc"])}"
                                                              class="form-control input-lg select2 required"
                                                              noSelection="${['': '--Chọn--']}"
                                                              optionKey="id"
                                                              optionValue="${{ b -> "${b.code} - ${b.name}" }}"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="name" class="col-md-3 control-label">Tên đơn vị / phòng ban<span
                                                    class="required">*</span></label>

                                            <div class="col-md-6">
                                                <input id="name" class="form-control" maxlength="255" name="name"
                                                       required/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="name" class="col-md-3 control-label">Tên viết tắt<span
                                                    class="required">*</span></label>

                                            <div class="col-md-6">
                                                <input id="shortname" class="form-control" maxlength="255"
                                                       name="shortname" required/>
                                            </div>
                                        </div>

                                        <div class="form-group" id="div_realName">
                                            <label for="name"
                                                   class="col-md-3 control-label">Tên đơn vị/ phòng ban khi In</label>

                                            <div class="col-md-6">
                                                <input id="realName" class="form-control" maxlength="255"
                                                       name="realName"/>
                                            </div>
                                        </div>

%{--                                        <div class="form-group">--}%
%{--                                            <label for="name"--}%
%{--                                                   class="col-md-3 control-label">Sản phẩm được SD</label>--}%

%{--                                            <div class="col-md-6">--}%
%{--                                                <g:select name="sanPham"--}%
%{--                                                          from="${listSanPham}"--}%
%{--                                                          class="form-control input-lg select2"--}%
%{--                                                          multiple="true"--}%
%{--                                                          optionKey="id"--}%
%{--                                                          optionValue="${{ b -> "${b.maSanPham} - ${b.tenSanPham}" }}"/>--}%
%{--                                            </div>--}%
%{--                                        </div>--}%

                                        <div class="form-group">
                                            <label for="name" class="col-md-3 control-label">Level</label>

                                            <div class="col-md-6">
                                                <input id="level" class="form-control " name="level" readonly/>
                                            </div>
                                        </div>

                                        <div class="form-group" style="display: none;">
                                            <label for="name" class="col-md-3 control-label">Tình/ TP* <span
                                                    class="required">*</span></label>

                                            <div class="col-md-6">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="name" class="col-md-3 control-label">Trạng thái <span
                                                    class="required">*</span></label>

                                            <div class="col-md-6">
                                                <g:select id="active" name="active"
                                                          noSelection="${['': '--Chọn--']}"
                                                          class="form-control clearText required"
                                                          from="['Active', 'Inactive']"
                                                          keys="${['true', 'false']}"/>
                                            </div>
                                        </div>

                                        <div class="form-group" style="display: none;">
                                            <label class="col-md-3 control-label">ID</label>

                                            <div class="col-md-6">
                                                <input id="id" name="id" class="form-control" readonly="true"/>
                                            </div>
                                        </div>

                                        <div id="div_maSequence">
                                            <div class="form-group">
                                                <label for="sequenceCode"
                                                       class="col-md-3 control-label">Mã Sequence<span
                                                        class="required">*</span></label>

                                                <div class="col-md-6">
                                                    <input id="sequenceCode" class="form-control" name="sequenceCode"
                                                           maxlength="10" required/>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="div_maDonvi">
                                            <div class="form-group">
                                                <label for="code"
                                                       class="col-md-3 control-label">Mã đơn vị / phòng ban</label>

                                                <div class="col-md-6">
                                                    <input id="code" class="form-control" name="code" readonly="true"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-actions fluid">
                                            <div class="col-md-offset-3 col-md-9">
                                                <button name="save-button" class="btn btn-save"><i
                                                        class="icon-ok"></i> Save</button>
                                                <button name="delete-button" class="btn btn-delete"><i
                                                        class="icon-remove"></i> Delete</button>
                                                <button class="btn btn-cancel" id="cancel-button"><i
                                                        class="icon-ban-circle"></i> Cancel</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>

                        %{--                        <div class="portlet box lpbblue">--}%
                        %{--                            <div class="portlet-title">--}%
                        %{--                                <div class="caption">--}%
                        %{--                                    <i class="icon-reorder"></i>--}%
                        %{--                                    Danh sách user trong đơn vị / phòng ban--}%
                        %{--                                </div>--}%
                        %{--                            </div>--}%

                        %{--                            <div class="portlet-body form">--}%
                        %{--                                <div class="form-group" style="display: none;">--}%
                        %{--                                    <div class="col-md-12">--}%
                        %{--                                        <span id="users-list"></span>--}%
                        %{--                                    </div>--}%
                        %{--                                </div>--}%

                        %{--                                <p></p>--}%

                        %{--                                <div class="form-actions fluid">--}%
                        %{--                                    <div class="from-group">--}%
                        %{--                                        <label for="code" class="col-md-3 control-label">Thêm vào danh sách:</label>--}%

                        %{--                                        <div class="col-md-6">--}%
                        %{--                                            <g:textField name="add-user-field" class="form-control"--}%
                        %{--                                                         placeholder="Tìm theo tên, username."/>--}%
                        %{--                                        </div>--}%
                        %{--                                        <button name="add-user-button" class="btn green" disabled="disabled"><i--}%
                        %{--                                                class="icon-plus"></i></button>--}%
                        %{--                                    </div>--}%
                        %{--                                </div>--}%

                        %{--                                <div class="form-group">--}%
                        %{--                                    <div class="col-md-12">--}%
                        %{--                                        <div id="div_table_ds_user"></div>--}%
                        %{--                                    </div>--}%
                        %{--                                </div>--}%
                        %{--                            </div>--}%
                        %{--                        </div>--}%
                    </div>

                    <div class="clear"></div>
                </div>
            </div>

        </div>
        <!-- END PAGE CONTENT -->
    </div>
    <!-- END PAGE -->
</div>
<!-- END CONTAINER -->

<script type="text/javascript">
    $(function () {
        set_side_bar(true);
        add_tab('#', 'Security', 'security');
        set_active_tab('security');select2(
        $("#m-melanin-vertical-navigation-branch").closest('li').addClass('active');
        $('#m-melanin-vertical-navigation-branch').append('<span class="selected"></span>');

        melanin_validate.branch();
        $('.select2').select2();
        common.setFullSidebar();

        $("#m-melanin-fingerprint-branch-tree a").live("dblclick", function () {
            $.get('${createLink(action:'findBranch',controller:'fingerprint')}/' +
                $(this).closest('li').attr('id'), function (data) {
                $("#branch-info-section").hide('slide');
                var _parentId = 0;
                if (data.branch.parent) {
                    _parentId = data.branch.parent.id;
                } else {
                    _parentId = null;
                }
                if (data.branch.active == 'true' || data.branch.active) {
                    $("#branch-form #active").val('true').attr('selected', true);
                } else if (data.branch.active == 'false' || !data.branch.active) {
                    $("#branch-form #active").val('false').attr('selected', true);
                } else {
                    $("#branch-form #active").val('');
                }

                $("#branch-form #id").val(data.branch.id);
                $("#branch-form #code").val(data.branch.code);
                $("#branch-form #name").val(data.branch.name);
                $("#branch-form #level").val(data.branch.level);
                $("#branch-form #shortname").val(data.branch.shortname);
                // $("#branch-form #vungMien").val(data.branch.vungMien);
                $("#branch-form #sequenceCode").val(data.branch.sequenceCode);
                $("#branch-form #realName").val(data.branch.realName);

                //TODO
                // if(data.branch.sanPham){
                //     $("#branch-form #sanPham").val(data.branch.sanPham.split(",")).trigger('change');
                // }
                // else {
                //     $("#branch-form #sanPham").val("").trigger('change');
                // }

                $("#branch-form #parentid").select2('val', _parentId);
                if (data.branch.level == 0) {
                    $("#branch-form #parentid").removeClass('required');
                    // $("#branch-form #vungMien").removeClass('required');
                    $("#branch-form #sequenceCode").removeClass('required');
                    $("#div_donviquanly").hide();
                    $("#div_maSequence").hide();
                    $("#div_maDonvi").hide();
                    // $("#div_vungmien").hide();
                    $("#div_realName").hide();
                } else {
                    $("#branch-form #parentid").removeClass('required');
                    $("#branch-form #parentid").addClass('required');
                    // $("#branch-form #vungMien").removeClass('required');
                    // $("#branch-form #vungMien").addClass('required');
                    $("#branch-form #sequenceCode").removeClass('required');
                    $("#branch-form #sequenceCode").addClass('required');
                    $("#div_donviquanly").show();
                    $("#div_maSequence").show();
                    $("#div_maDonvi").show();
                    // $("#div_vungmien").show();
                    $("#div_realName").show();
                    $("#branch-form #code").prop("disabled", true);
                }
                $('#add-user-field').val('');
                $("button[name=delete-button]").removeAttr('disabled');
                $("#users-list").html('');
                /*$(data.users).each(function (i, e) {
                    $("#users-list").append('<span>' + e.fullname + ' (' + e.username + ', <a href="#" class="remove-user" rel="' + e.id + '">remove</a>), </span>');
                });
                $('#div_table_ds_user').html(data.divCC);
                $("button[name=add-user-button]").attr('disabled', true).removeClass('primary');*/
                $("#branch-info-section").show('slide');
                $("html, body").animate({scrollTop: 0}, "slow");
            });
        });

        $("button[name=save-button]").click(function (e) {
            e.preventDefault();
            if ($("#branch-form").valid()) {
                common.showSpinner();
                %{--$.post("${createLink(controller:'fingerprint',action:'saveBranch')}", $("#branch-form").serialize(), function (data) {--}%
                %{--document.location = "${createLink(controller:'fingerprint',action:'branch')}";--}%
                %{--});--}%
                var parentid = $("#parentid").val()
                var id = $("#id").val()
                var name = $("#name").val()
                var shortname = $("#shortname").val()
                var level = $("#level").val()
                var active = $("#active").val()
                var code = $("#code").val()
                var sequenceCode = $("#sequenceCode").val()
                // var vungMien = $("#vungMien").val()
                var realName = $("#realName").val()
                // var sanPham = $("#sanPham").val()

                $.ajax({
                    type: "POST",
                    async: false,
                    //data:$("#branch-form").serialize(),
                    data: {
                        parentid: parentid,
                        id: id,
                        name: name,
                        shortname: shortname,
                        level: level,
                        active: active,
                        code: code,
                        sequenceCode: sequenceCode,
                        // vungMien: vungMien,
                        realName: realName
                        // ,sanPham: sanPham
                    },
                    url: "${createLink(controller:'fingerprint',action:'saveBranch')}",
                    success: function (data) {
                        common.hideSpinner();
                        document.location = "${createLink(controller:'fingerprint',action:'branch')}";
                    },
                    error: function (err) {
                        common.hideSpinner();
                        common.showToastr('error', 'Lỗi', err, 'toast-bottom-right');
                    }
                });
            }
        });
        $("button[name=delete-button]").live('click', function (e) {
            e.preventDefault();
            var uid = $("#id").val();
            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa chi nhánh này?', function (result) {
                if (result) {
                    common.showSpinner();
                    document.location = "${createLink(controller:'fingerprint',action:'deleteBranch')}/" + uid;
                    common.hideSpinner();
                }
            });
        });
        $("#cancel-button").click(function (e) {
            e.preventDefault();
            //$('#branch-info-section').css('display','none');
            $("#branch-info-section").hide('slide');
        });


        $("#m-melanin-fingerprint-branch-tree").jstree({
            "json_data": {
                "ajax": {"url": "${createLink(controller:'fingerprint',action:'branchTree')}"}
            },
            "themes": {
                "theme": "branch"
            },
            "plugins": ["themes", "json_data", "ui", "cookies"]
        });

        $(".remove-user").live('click', function (e) {
            e.preventDefault();
            var myA = $(this);
            $.get('${createLink(controller:'fingerprint',action:'removeUserFromBranch')}',
                {id: $(myA).attr('rel'), branch: $('#branch-form #id').val()}, function (data) {
                    // $(myA).closest('span').hide('highlight');
                    $(myA).closest('span').remove()
                });
            common.showToastr('success', 'Thông báo', 'Xóa user thành công!', 'toast-top-right');
        });

        $("button[name=add-user-button]").click(function (e) {
            console.log('ahihi');
            e.preventDefault();

            $.ajax({
                type: "POST",
                async: false,
                url: "${createLink(controller:'fingerprint',action:'addUserToBranch')}",
                data: {id: $(this).attr('title'), branch: $('#branch-form #id').val()},
                success: function (data) {
                    if (data.success) {
                        $("#users-list").append('<span>' + data.user.fullname + ' (' + data.user.username +
                            ', <a href="#" class="remove-user" rel="' + data.user.id + '">remove</a>), </span>');
                        $('#table_ds_user  > tbody').append(data.divCC);

                        $(this).attr('disabled', true);
                        $("#add-user-field").val('');

                        common.showToastr('success', 'Thông báo', data.msg, 'toast-top-right');
                    } else {
                        common.showToastr('error', 'Lỗi', data.msg, 'toast-top-right');
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    common.hideSpinner();
                    if (textStatus === "timeout") {
                        jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                    } else {
                        common.hideSpinner();
                        common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');
                    }
                }
            });

        });
//        $("#add-user-field").change(function () {
//            $("button[name=add-user-button]").attr('disabled', true).removeClass('primary');
//        });


        $("button[name=m-melanin-action-bar-button-create-branch]").click(function (e) {
            e.preventDefault();
//            $("#branch-form input").val('');
            $("#branch-form #name").val('');
            $("#branch-form #shortname").val('');
            $("#branch-form #level").val('');
            $("#branch-form #code").val('');
            $("#branch-form #id").val('');

            $("#branch-form #parentid").val('').trigger("change");
            ;
            // $("#branch-form #vungMien").val('');
            $("#branch-form #realName").val('');
            $("#branch-form #sequenceCode").val('');
            // $("#branch-form #sanPham").val("").trigger('change');

            $("#div_donviquanly").show();
            $("#div_maSequence").show();
            $("#div_maDonvi").show();
            // $("#div_vungmien").show();
            $("#div_realName").show();

            $("#user-list-section").hide();
            $("button[name=delete-button]").attr('disabled', true);
            $("#branch-info-section").show('slide');
        });
        setTimeout('$("#flash-message").hide("blind")', 2000);
    });

    $(function () {
        %{--$("#add-user-field").autocomplete({--}%
        %{--    source: "${createLink(controller:'fingerprint',action:'searchUser')}",--}%
        %{--    minLength: 2,--}%
        %{--    select: function (event, ui) {--}%
        %{--        $("#add-user-field").val(ui.item.fullname);--}%
        %{--        $("button[name=add-user-button]").attr('disabled', false).addClass('primary');--}%
        %{--        $("button[name=add-user-button]").attr('title', ui.item.id);--}%
        %{--        return false;--}%
        %{--    },--}%
        %{--    focus: function (event, ui) {--}%
        %{--        $("#add-user-field").val(ui.item.fullname);--}%
        %{--        return false;--}%
        %{--    }--}%
        %{--}).data("uiAutocomplete")._renderItem = function (ul, item) {--}%
        %{--    return $("<li></li>")--}%
        %{--        .data("item.autocomplete", item)--}%
        %{--        .append("<a>" + item.fullname + " (" + item.username + ")</a>")--}%
        %{--        .appendTo(ul);--}%

        %{--};--}%
    });
</script>

</body>
</html>