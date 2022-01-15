<%@ page import="com.melanin.commons.MenuItem; com.melanin.commons.SidebarItem" %>
<g:each in="${SidebarItem.findAll("from SidebarItem where menuItem = :menuItem and level =1 order by ordernumber",
        [menuItem: MenuItem.findByName(menuItemName)])}"
        var="item">
    <g:if test="${item.roles}">
        <sec:ifAnyGranted roles="${item.roles}">
            <li>
                <a id="${item.htmlElementId}"
                    <g:if test="${item.urlParam}">
                        href="${item.controller ? createLink(controller: item.controller, action: item.action) + '?' + item.urlParam : ""}"
                    </g:if>
                    <g:else>
                        href="${item.controller ? createLink(controller: item.controller, action: item.action) : ""}"
                    </g:else>>
                    <i class= ${item.icon}></i>

                    <g:if test="${item.label.contains('g.message')}">
                        <span class="title">
                            <g:message code="${item.label}"/>
                        </span>
                    </g:if>
                    <g:else>
                        <span class="title">${item.label}</span>
                    </g:else>

                    <g:set var="child_List"
                           value="${SidebarItem.findAll("from SidebarItem where parentItem = :parentItem and level =2 order by ordernumber",
                                   [parentItem: item])}"/>

                    <g:if test="${child_List.size() > 0}">
                        <span class="arrow "></span>
                    </g:if>
                </a>
                <g:if test="${child_List.size() > 0}">
                    <ul class="sub-menu">
                        <g:each in="${child_List}"
                                var="child">
                            <sec:ifAnyGranted roles="${child.roles}">
                                <li>
                                    <g:if test="${child.urlParam}">
                                        <a id="${child.htmlElementId}"
                                           style="border-top: 0px !important;"
                                           href="${child.controller ? createLink(controller: child.controller, action: child.action) + '?' + child.urlParam : ''}">
                                            <i class= ${child.icon}></i>
                                            <span class="title">${child.label}</span>
                                        </a>
                                    </g:if>
                                    <g:else>
                                        <a id="${child.htmlElementId}"
                                           style="border-top: 0px !important;"
                                           href="${child.controller ? createLink(controller: child.controller, action: child.action) : ''}">
                                            <i class= ${child.icon}></i>
                                            <span class="title">${child.label}</span>
                                        </a>
                                    </g:else>

                                </li>
                            </sec:ifAnyGranted>
                        </g:each>
                    </ul>
                </g:if>
            </li>
        </sec:ifAnyGranted>
    </g:if>
    <g:else>
        <li>
            <a id="${item.htmlElementId}"
                <g:if test="${item.urlParam}">
                    href="${item.controller ? createLink(controller: item.controller, action: item.action) + '?' + item.urlParam : ""}"
                </g:if>
                <g:else>
                    href="${item.controller ? createLink(controller: item.controller, action: item.action) : ""}"
                </g:else>>
                <i class= ${item.icon}></i>

                <g:if test="${item.label.contains('g.message')}">
                    <span class="title">
                        <g:message code="${item.label}"/>
                    </span>
                </g:if>
                <g:else>
                    <span class="title">${item.label}</span>
                </g:else>

                <g:set var="child_List"
                       value="${SidebarItem.findAll("from SidebarItem where parentItem = :parentItem and level =2 order by ordernumber",
                               [parentItem: item])}"/>

                <g:if test="${child_List.size() > 0}">
                    <span class="arrow "></span>
                </g:if>
            </a>
            <g:if test="${child_List.size() > 0}">
                <ul class="sub-menu">
                    <g:each in="${child_List}"
                            var="child">
                        <g:if test="${child.roles}">
                            <sec:ifAnyGranted roles="${child.roles}">
                                <li>
                                    <g:if test="${child.urlParam}">
                                        <a id="${child.htmlElementId}"
                                           style="border-top: 0px !important;"
                                           href="${child.controller ? createLink(controller: child.controller, action: child.action) + '?' + child.urlParam : ''}">
                                            <i class= ${child.icon}></i>
                                            <span class="title">${child.label}</span>
                                        </a>
                                    </g:if>
                                    <g:else>
                                        <a id="${child.htmlElementId}"
                                           style="border-top: 0px !important;"
                                           href="${child.controller ? createLink(controller: child.controller, action: child.action) : ''}">
                                            <i class= ${child.icon}></i>
                                            <span class="title">${child.label}</span>
                                        </a>
                                    </g:else>
                                </li>
                            </sec:ifAnyGranted>
                        </g:if>
                        <g:else>
                            <li>
                                <g:if test="${child.urlParam}">
                                    <a id="${child.htmlElementId}"
                                       style="border-top: 0px !important;"
                                       href="${child.controller ? createLink(controller: child.controller, action: child.action) + '?' + child.urlParam : ''}">
                                        <i class= ${child.icon}></i>
                                        <span class="title">${child.label}</span>
                                    </a>
                                </g:if>
                                <g:else>
                                    <a id="${child.htmlElementId}"
                                       style="border-top: 0px !important;"
                                       href="${child.controller ? createLink(controller: child.controller, action: child.action) : ''}">
                                        <i class= ${child.icon}></i>
                                        <span class="title">${child.label}</span>
                                    </a>
                                </g:else>
                            </li>
                        </g:else>
                    </g:each>
                </ul>
            </g:if>
        </li>
    </g:else>

</g:each>
