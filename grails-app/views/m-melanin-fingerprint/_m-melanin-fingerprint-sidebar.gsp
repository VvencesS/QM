<%@ page import="com.melanin.commons.MenuItem" %>
<ul class="page-sidebar-menu">
%{--    <li>--}%
%{--        <a id="m-melanin-vertical-navigation-role-group"--}%
%{--           href="${createLink(controller: 'fingerprint', action: 'rolegroup')}" class="">--}%
%{--            <i class="icon-group"></i> <span class="title">Quản trị nhóm quyền</span>--}%
%{--        </a>--}%
%{--    </li>--}%
    <li>
        <a id="m-melanin-vertical-navigation-role"
           href="${createLink(controller: 'fingerprint', action: 'role')}" class="">
            <i class="icon-briefcase"></i> <span class="title">Quản trị quyền người dùng</span>
        </a>
    </li>

    <li>
        <a id="m-melanin-vertical-navigation-menuItem"
           href="${createLink(controller: 'fingerprint', action: 'menuItem')}" class="">
            <i class="icon-sitemap"></i>
            <span class="title">Menu Item</span>
        </a>
    </li>

    <li>
        <a id="m-melanin-vertical-navigation-sidebarItem"
           href="${createLink(controller: 'sidebar', action: 'index_sidebarItem')}" class="">
            <i class="icon-sitemap"></i>
            <span class="title">Sidebar</span>
        </a>
    </li>

%{--    <li>--}%
%{--        <a id="m-melanin-vertical-navigation-url"--}%
%{--           href="${createLink(controller: 'fingerprint', action: 'urlmng')}" class="">--}%
%{--            <i class="icon-folder-open"></i> <span class="title">Quản trị đường dẫn</span>--}%
%{--        </a>--}%
%{--    </li>--}%

    <li><a id="m-melanin-vertical-log"
           href="${createLink(controller: 'fingerprint2', action: 'logmng')}" class="">
        <i class="icon-time"></i> <span class="title">Lịch sử truy cập</span>
    </a></li>

    <li>
        <a id="m-melanin-vertical-navigation-user"
           href="${createLink(controller: 'fingerprint', action: 'user')}" class="">
            <i class="icon-user"></i> <span class="title">Quản trị người dùng</span>
        </a>
    </li>
    <li>
        <a id="m-melanin-vertical-navigation-branch"
           href="${createLink(controller: 'fingerprint', action: 'branch')}"
           class=""><i class="icon-home"></i> <span class="title">Quản lý đơn vị</span>
        </a>
    </li>

%{--    <g:render template="/m-melanin-fingerprint/sidebar_item/template/div_DynamicSidebar"--}%
%{--        model="${[menuItemName: 'login']}"/>--}%
</ul>