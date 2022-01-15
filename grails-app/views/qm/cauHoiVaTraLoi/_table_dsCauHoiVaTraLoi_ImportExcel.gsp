<table id="dm-Item-table_ImportExcel"
       class="table table-striped table-bordered table-hover ">
</table>

<div id="loiDuLieu_itemTable_ImportExcel" class="alert alert-info" style="max-width: 600px; margin: auto; display: none">

</div>

<script type="text/javascript">
    window.int_dmItem_newRow = 0
    window.dataDsCH_TL = []
    window.dataDsCH_TLXoa = []
    window.tableDmItem_ImportExcel = $("#dm-Item-table_ImportExcel").DataTable({
        processing: true,
        dom: 'Br<".phiaTren"><".cuonNgang"t>ip',
        lengthMenu: [[10, 30], [10, 30]],
        buttons: [
            // {extend: 'excelHtml5',
            //     text: 'Export Excel',
            //     exportOptions: {columns: [0, 1, 2]} },
            // {extend: 'colvis',
            //     columns: ':not(.ko_ApDungColvis)',
            //     columnText: function (dt, idx, title) {
            //         return (idx - 1) + ': ' + title;
            //     },
            //     text: "Ẩn hiện cột"},
            // { extend: "create", editor: editor },
            // { extend: "edit",   editor: editor },
            // { extend: "remove", editor: editor },
            // {text: "Thêm dòng", action: themDongNewItem},
        ],
        order: [[0, "asc"]],
        columns: [
            {
                data: null, title: "STT",
                className: 'dt-body-right ko_ApDungColvis', width: "5%", orderable: true, searchable: false,
                render: function (data, type, row, meta) {
                    return parseInt(meta.row) + 1
                }
            },
            {
                data: 'newRow',
                name: 'newRow',
                title: "newRow",
                visible: false,
                className: 'ko_ApDungColvis'
            },
            {
                data: 'cauHoiId',
                name: 'cauHoiId',
                title: "cauHoiId",
                visible: false,
                className: 'ko_ApDungColvis'
            },
            {
                data: 'cauTraLoiId',
                name: 'cauTraLoiId',
                title: "cauTraLoiId",
                visible: false,
                className: 'ko_ApDungColvis'
            },
            {
                data: 'updateRow',
                name: 'updateRow',
                title: "updateRow",
                visible: false,
                className: 'ko_ApDungColvis'
            },
            {data: 'cauHoi', name: 'cauHoi', title: "Câu hỏi", width: '40%', render1: $.fn.dataTable.render.text()},
            {
                data: 'cauTraLoi',
                name: 'cauTraLoi',
                title: "Câu trả lời",
                width: '50%',
                render1: $.fn.dataTable.render.text()
            },
            {
                data: null, title: "Hành động", width: '5%', className: 'dt-body-center choPhepEdit',
                render: function (data, type, row, meta) {
                    return "<a href='#' class='editRowCH_TL_ImportExcel icon-edit' title='Edit'></a> <a href='#' class='deleteRowCH_TL_ImportExcel icon-trash' title='Delete'></a> "
                }
            }
        ],

        language: {
            sSearch: "<g:message code= 'data.table.sSearch' /> ",
            sZeroRecords: "<g:message code= 'data.table.sZeroRecords' /> ",
            sEmptyTable: "<g:message code= 'data.table.sEmptyTable' /> ",
            sInfo: "<g:message code= 'data.table.sInfo' /> ",
            lengthMenu: "<g:message code= 'data.table.lengthMenu' /> ",
            paginate: {
                first: "<g:message code= 'data.table.paginate.first' /> ",
                last: "<g:message code= 'data.table.paginate.last' /> ",
                next: "<g:message code= 'data.table.paginate.next' /> ",
                previous: "<g:message code= 'data.table.paginate.previous' /> "
            },
            sInfoFiltered: "",
            sInfoEmpty: '<g:message code= 'data.table.sInfoEmpty' /> '
        },
    });

    $('#dm-Item-table_ImportExcel').on('click', 'a.deleteRowCH_TL_ImportExcel', function (e) {
        e.preventDefault();
        var deleteRow = $(this).closest('tr');
        var dataDsCH_TL_Copy = window.dataDsCH_TL;
        common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa dòng này?', function (result) {
            if (result) {
                dataDsCH_TL_Copy.forEach(function (item) {
                    if (item.cauHoiId == tableDmItem_ImportExcel.row(deleteRow).data().cauHoiId && item.newRow == tableDmItem_ImportExcel.row(deleteRow).data().newRow) {
                        window.dataDsCH_TLXoa.push(item);
                    }
                });
                dataDsCH_TL = window.dataDsCH_TL.filter(function (item) {
                    return (item.cauHoiId != tableDmItem_ImportExcel.row(deleteRow).data().cauHoiId || item.newRow != tableDmItem_ImportExcel.row(deleteRow).data().newRow);
                });

                tableDmItem_ImportExcel.clear().rows.add(dataDsCH_TL).draw();
            }
        })
    });
    $('#dm-Item-table_ImportExcel').on('click', 'a.editRowCH_TL_ImportExcel, a.viewRowCH_TL_ImportExcel', function (e) {
        e.preventDefault();

        $('#loiDuLieu_itemTable_ImportExcel').html('').css('display', 'none');

        var selectRow = $(this).closest('tr');
        var objCH_TL = window.dataDsCH_TL.find(function (item) {
            return (item.cauHoiId == tableDmItem_ImportExcel.row(selectRow).data().cauHoiId && item.newRow == tableDmItem_ImportExcel.row(selectRow).data().newRow);
        })
        $("#modal_Update [name='cauHoiId_copy']").val(objCH_TL.cauHoiId);
        $("#modal_Update [name='cauTraLoiId_copy']").val(objCH_TL.cauTraLoiId);
        $("#modal_Update [name='newRow_copy']").val(objCH_TL.newRow);
        $("#modal_Update [name='updateRow_copy']").val(objCH_TL.updateRow);
        window.loadHienThiForm(objCH_TL);

        if ($(this).hasClass('viewRowCH_TL_ImportExcel')) {
            $('#modal_Update button[name=form-button-save]').css('display', 'none');
        } else if ($(this).hasClass('editRowCH_TL_ImportExcel')) {
            $('#modal_Update button[name=form-button-save]').css('display', 'inline');
        }

        $('#modal_Update').modal('show');
    });

    function themDongNewItem() {
        // window.int_dmItem_newRow ++
        $("#modal_Update [name='cauHoiId_copy']").val(-1);
        $("#modal_Update [name='newRow_copy']").val('newRow');
        $("#modal_Update [name='updateRow_copy']").val(-1);
        $('#modal_Update').modal('show');
    }

    function data_ItemTable() {
        var dsLoi = []
        var data2 = []

        var dsCH_TL = window.dataDsCH_TL;
        if (dsCH_TL.length == 0) {
            dsLoi.push([1, 'Chưa có Câu hỏi và trả lời nào!']);
        }

        if (dsLoi.length > 0) {
            hienThiLoi_ItemTable(dsLoi);
            return 'loiDuLieu';
        } else {
            data2 = window.dataDsCH_TL;
            $('#loiDuLieu_itemTable_ImportExcel').html('').css('display', 'none');
            return JSON.stringify(data2);
        }
    }

    function hienThiLoi_ItemTable(dsLoi) {
        common.showToastr('warning', 'Thông báo', "Dữ liệu trong bảng đang gặp lỗi", 'toast-top-right');
        var strHTML = '';
        var intSoDong = 0;
        for (var i1 = 0; i1 < dsLoi.length; i1++) {
            strHTML += '<strong>Dòng ' + (dsLoi[i1][0] + 1) + ': </strong> ' + dsLoi[i1][1] + '<br>';
            intSoDong++;
            if (intSoDong > 2) break;
        }
        $('#loiDuLieu_itemTable_ImportExcel').html(strHTML).css('display', 'block');
    }
</script>
<style>
#dm-Item-table_ImportExcel td, th {
    border-left: 0px !important;
    border-bottom: 0px !important;
}

#dm-Item-table_ImportExcel_wrapper .dt-buttons {
    margin-left: 10px;
}

#dm-Item-table_ImportExcel_wrapper .cuonNgang {
    overflow-x: auto;
}

/*#dm-Item-table_ImportExcel_wrapper {*/
/*    width: 75% !important;*/
/*    margin:auto;*/
/*}*/
#dm-Item-table_ImportExcel_wrapper .phiaTren {
    clear: both;
    /*phải thêm style này , vì các element phía trước nó đều có float: left hoặc right*/
}

.table-striped > tbody > tr.highlight > td {
    background-color: #FFFBCC !important;
}
</style>