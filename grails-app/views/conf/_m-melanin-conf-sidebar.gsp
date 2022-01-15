<ul class="page-sidebar-menu">
    <li id="sidebar-conf">
        <a href="${createLink(controller: 'conf', action: 'index')}" class="">
            <i class="icon-cog"></i>
            <span class="title">Conf</span>
        </a>
    </li>

    <g:render template="/m-melanin-fingerprint/sidebar_item/template/div_DynamicSidebar"
        model="${[menuItemName: 'control-panel']}"/>
</ul>