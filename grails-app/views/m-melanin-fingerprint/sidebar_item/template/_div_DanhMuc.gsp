<%@ page import="com.commons.Constant;" %>

<div class="portlet box lpbblue">
    <div class="portlet-title">
        <div class="caption">
%{--            id="m-melanin-form-user-details-legend"--}%
            <i class="icon-reorder"/>
            <span>Danh mục Sidebar item</span>
        </div>
        <div class="tools">
            <a class="collapse"/>
        </div>
    </div>

    <div class="portlet-body">
        <div class="table-responsive">
            <table id="dm-Item-table"
                   class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th style="width: 45% !important;">Nội dung Sidebar Item</th>
                    <th style="width: 15% !important;">Menu Item</th>
                    <th style="width: 15% !important;">Các role được phép truy cập</th>
                    <th style="width: 8% !important;">Số thứ tự<br>hiển thị</th>
                    <th style="width: 3% !important;">Controller</th>
                    <th style="width: 3% !important;">Action</th>
                    <th style="width: 8% !important;">Icon</th>
                    <th style="width: 1% !important;">Level</th>
                    <th style="width: 3% !important;">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${com.melanin.commons.SidebarItem.findAll("from SidebarItem as t order by t.menuItem.ordernumber, t.menuItem.label, t.ordernumber ")}" var="item">
                    <tr>
                        <td>
                            <span>${item.label}</span>
                        </td>
                        <td style="text-align: left;">${item.menuItem.label}</td>
                        <td style="text-align: left;">${item.roles}</td>
                        <td style="text-align: right;">${item.ordernumber}</td>
                        <td style="text-align: left;">${item.controller}</td>
                        <td style="text-align: left;">${item.action}</td>
                        <td style="text-align: left;">${item.icon}</td>
                        <td style="text-align: right;">${item.level}</td>
                        <td style="text-align: center;">
                            <a href='#' rel='${item.id}' class='editRow icon-edit'></a>
                        </td>
                    </tr>
                </g:each>

                </tbody>
            </table>
        </div>
    </div>
    <div class="col-xs-12"></div>
</div>
<script type="text/javascript">
    $(function () {
        $("#dm-Item-table").DataTable({
            "scrollX": true,
            "bSort": false,
            "scrollX": true,
            "processing": true,
            // them trang dau trang cuoi "sPaginationType": "full_numbers",
            //neu muon su dung ajax thi them thang serverside vao
            // "serverSide": true,
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
            },
            columnDefs: [
                {"targets": 2, render: $.fn.dataTable.render.ellipsis(30, false, true)}
            ]
        });
    });
</script>