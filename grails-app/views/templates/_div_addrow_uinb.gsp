<%@ page import="com.melanin.security.RoleGroup; com.melanin.fingerprint.Branch" %>
<%@ page import="com.melanin.security.User" %>
<%@ page import="com.melanin.security.UserRole" %>
<tr>
    <td></td>
    <td>${rs?.id}</td>
    <td>${rs?.username}</td>
    <td>${rs?.fullname}</td>
    <td>${UserRole.findAllByUser(rs).role.authority}</td>
    <td>${UserRole.findAllByUser(rs).role.diengiai}</td>
    <td><a href="#" class="remove-user2" rel="${rs?.id}"><i
            class="icon-trash"></i></a></td>
</tr>