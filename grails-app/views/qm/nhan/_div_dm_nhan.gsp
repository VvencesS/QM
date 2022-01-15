<div class="portlet box lpbblue">
    <div class="portlet-title">
        <div class="caption">
            <i class="icon-reorder"/>
            <span>Danh sách nhãn</span>
        </div>

        <div class="tools">
            <a class="collapse"/>
        </div>
    </div>

    <div class="portlet-body">
        <div class="table-responsive">
            <table id="dm-status-table"
                   class="table table-striped table-bordered table-hover ">
                <thead>
                <tr>
                    <th style="width: 5% !important;">STT</th>
                    <th style="width: 25% !important;">Mã nhãn</th>
                    <th style="width: 30% !important;">Tên nhãn</th>
                    <th style="width: 15% !important;">Cấp</th>
                    <th style="width: 20% !important;">Nhãn cha</th>
                    <th style="width: 5% !important;">Hành động</th>
                </tr>
                </thead>

                <tbody>
                <g:each in="${com.qm.QmNhan.list()}" var="item" status="counter">
                    <tr>
                        <td style="text-align: center">${counter + 1}</td>
                        <td style="text-align: left;">${item?.maNhan}</td>
                        <td style="text-align: left;">${item?.tenNhan}</td>
                        <td style="text-align: right;">${item?.level}</td>
                        <td style="text-align: left;">${item?.parentItem?.maNhan} - ${item?.parentItem?.tenNhan}</td>
                        <td style="text-align: center;">
                            <a href='#' rel='${item?.id}' class='editRow icon-edit'></a>
                            <a href='#' rel='${item?.id}' class='deleteRow icon-trash'></a>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $("#dm-status-table").DataTable({
            "processing": true,
            "scrollX": true,
            "language": {
                "sSearch": "${message(code: 'data.table.sSearch')}",
                "sZeroRecords": "${message(code: 'data.table.sZeroRecords')}",
                "sEmptyTable": "${message(code: 'data.table.sEmptyTable')}",
                "sInfo": "${message(code: 'data.table.sInfo')}",
                "lengthMenu": "${message(code: 'data.table.lengthMenu')}",
                "paginate": {
                    "first": "${message(code: 'data.table.paginate.first')}",
                    "last": "${message(code: 'data.table.paginate.last')}",
                    "next": "${message(code: 'data.table.paginate.next')}",
                    "previous": "${message(code: 'data.table.paginate.previous')}"
                },
                "sInfoFiltered": "",
                "sInfoEmpty": '${message(code: 'data.table.sInfoEmpty')}'
            }
        });

        $('.editRow').live('click', function (e) {
            e.preventDefault();
            var id = $(this).attr("rel");
            $.ajax({
                type: "POST",
                async: false,
                data: {
                    id: id,
                    crud: "${com.commons.Constant.CRUD_0100}",
                },
                url: "${createLink(controller:'nhan',action:'layDivCRUDNhan')}",
                success: function (data) {
                    if ($('#div_ThemMoi').html() == '') {
                        common.showSpinner();
                        $('#div_ThemMoi').hide('blind', function () {
                            $('#div_ThemMoi').html(data.divCC);
                            $('#div_ThemMoi').show('blind');
                        });
                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300);
                    } else {
                        common.showSpinner();
                        $('#div_ThemMoi').html(data.divCC);
                        $('#div_ThemMoi').show('blind');
                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300)
                    }
                    $("html, body").animate({scrollTop: 0}, "slow");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // common.hideSpinner();
                    if (textStatus === "timeout") {
                        jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                    } else {
                        // common.hideSpinner();
                        if (jqXHR.status == '403') {
                            common.showToastr('error', 'Lỗi', 'Bạn không có quyền thực hiện thao tác này!', 'toast-top-right');
                        } else {
                            common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');
                        }
                    }
                }
            });
        });

        $('.deleteRow').live('click', function (e) {
            e.preventDefault();
            var id = $(this).attr("rel");
            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa bản ghi này?', function (result) {
                if (result) {
                    $.ajax({
                        type: "POST",
                        async: false,
                        data: {
                            hdrId: id,
                            crud: "${com.commons.Constant.CRUD_0001}",
                        },
                        url: "${createLink(controller:'nhan',action:'crudNhan')}",
                        success: function (data) {
                            if (!data.success) {
                                common.showToastr('error', 'Lỗi', data.msg, 'toast-top-right');
                            } else {
                                common.showToastr('success', 'Thông báo', data.msg, 'toast-top-right');

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
                            // common.hideSpinner();
                            if (textStatus === "timeout") {
                                jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                            } else {
                                // common.hideSpinner();
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
    });
</script>
