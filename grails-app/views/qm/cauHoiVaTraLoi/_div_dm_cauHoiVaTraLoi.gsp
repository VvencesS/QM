<div class="portlet box lpbblue">
    <div class="portlet-title">
        <div class="caption">
            <i class="icon-reorder"/>
            <span>Danh sách câu hỏi và trả lời</span>
        </div>

        <div class="tools">
            <a class="collapse"/>
        </div>
    </div>

    <div class="portlet-body">
        <div class="table-responsive">
            <table id="dm-buttonGroup-table"
                   class="table table-striped table-bordered table-hover ">
                <thead>
                <tr>
                    <th style="width: 5% !important;">STT</th>
                    <th style="width: 15% !important;">Nhãn</th>
                    <th style="width: 35% !important;">Câu hỏi</th>
                    <th style="width: 40% !important;">Trả lời</th>
                    <th style="width: 5% !important;">Hành động</th>
                </tr>
                </thead>

                <tbody>
                <g:each in="${cauHoiVaTraLoiList}" var="item" status="counter">
                    <tr>
                        <td style="text-align: center">${counter + 1}</td>
                        <td style="text-align: left;">
                            <a href='#' rel='${item?.map_nhan}' class='viewDsCH_TLTheoNhan'>${item?.map_nhan}</a>
                        </td>
                        <td style="text-align: left;">${item?.cau_hoi}</td>
                        <td style="text-align: left;">${item?.tra_loi}</td>
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
        $("#dm-buttonGroup-table").DataTable({
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

        $('.deleteRow').live('click', function (e) {
            e.preventDefault();
            var idCauHoi = $(this).attr("rel");
            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa bản ghi này?', function (result) {
                if (result) {
                    $.ajax({
                        type: "POST",
                        async: false,
                        data: {
                            hdrId: idCauHoi,
                            crud: "${com.commons.Constant.CRUD_0001}",
                        },
                        url: "${createLink(controller:'cauHoiVaTraLoi',action:'crudCauHoiVaTraLoi')}",
                        success: function (data) {
                            if (!data.success) {
                                common.showToastr('error', 'Lỗi', data.msg, 'toast-top-right');
                            } else {
                                common.showToastr('success', 'Thông báo', data.msg, 'toast-top-right');

                                // Load lại dm
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

        $('.editRow').live('click', function (e) {
            e.preventDefault();
            var idCauHoi = $(this).attr("rel");
            $.ajax({
                type: "POST",
                async: false,
                data: {
                    hdrId: idCauHoi,
                    crud: "${com.commons.Constant.CRUD_0100}",
                },
                url: "${createLink(controller:'cauHoiVaTraLoi',action:'layDsDuLieuCauHoi_TraLoi')}",
                success: function (data) {
                    if (data?.error == true) {
                        common.showToastr('error', 'Lỗi', data?.msg, 'toast-top-right');
                    } else {
                        common.showSpinner();
                        $('form#thongTinNhan [name=editOrView]').val('edit');
                        window.loadHienThiNhan(data?.nhans);
                        window.dataDsCH_TL = data?.dataDsCH_TL;
                        window.tableDmItem_1.clear().rows.add(dataDsCH_TL).draw();
                        $('#modal_ViewOrInsertOrUpdate').modal('show');

                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300)
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
        });

        $('.viewDsCH_TLTheoNhan').live('click', function (e) {
            e.preventDefault();
            var mapNhan = $(this).attr("rel");
            $.ajax({
                type: "POST",
                async: false,
                data: {
                    mapNhan: mapNhan,
                    crud: "${com.commons.Constant.CRUD_0100}",
                },
                url: "${createLink(controller:'cauHoiVaTraLoi',action:'layDsDuLieuCauHoi_TraLoi')}",
                success: function (data) {
                    if (data?.error == true) {
                        common.showToastr('error', 'Lỗi', data?.msg, 'toast-top-right');
                    } else {
                        common.showSpinner();
                        $('form#thongTinNhan [name=editOrView]').val('edit');
                        $('form#thongTinNhan').find('[name="nhans"]').val(data?.nhans?.split(",")).trigger('change');
                        // window.loadHienThiNhan(data?.nhans);
                        window.dataDsCH_TL = data?.dataDsCH_TL;
                        window.tableDmItem_1.clear().rows.add(dataDsCH_TL).draw();
                        $('#modal_ViewOrInsertOrUpdate').modal('show');

                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300)
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
        });
    });
</script>
