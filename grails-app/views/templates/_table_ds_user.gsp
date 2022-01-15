<%@ page import="com.melanin.security.RoleGroup; com.melanin.fingerprint.Branch" %>
<%@ page import="com.melanin.security.User" %>
<%@ page import="com.melanin.security.UserRole" %>
<table id="table_ds_user" class="table compact table-striped table-bordered">
    <thead>
    <tr>
        <th>STT</th>
        <th>ID</th>
        <th>Username</th>
        <th>Fullname</th>
        <th>Role</th>
        <th>Diễn giải</th>
        <th>Remove</th>
    </tr>
    </thead>
    <tbody id="tbody_table_ds_user">
    <g:each in="${User.findAllByBranch(Branch.get(branchid))}" status="i"
            var="rs">
        <tr>
            <td>${i + 1}</td>
            <td>${rs?.id}</td>
            <td>${rs?.username}</td>
            <td>${rs?.fullname}</td>
            <td>${UserRole.findAllByUser(rs).role.authority}</td>
            <td>${UserRole.findAllByUser(rs).role.diengiai}</td>
            <td><a href="#" class="remove-user2" rel="${rs?.id}"><i
                    class="icon-trash"></i></a></td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(function () {
        $(".remove-user2").live('click', function (e) {
            e.preventDefault();
            var myA = $(this);
            $.get('${createLink(controller:'fingerprint',action:'removeUserFromBranch')}',
                    {id: $(myA).attr('rel'), branch: $('#branch-form #id').val()}, function (data) {
                        $(myA).closest('tr').hide('highlight');
                    });
            common.showToastr('success', 'Thông báo', 'Xóa user thành công!', 'toast-top-right');
        });
    });
</script>

