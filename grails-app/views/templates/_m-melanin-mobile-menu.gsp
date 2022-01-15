
	<ul class="page-sidebar-menu visible-sm visible-xs">
		<g:each in="${tabs}" var="tab">
			<sec:ifAnyGranted roles="${tab.roles}">
				<li>
					<a href="${tab.controller?createLink(controller:tab.controller,action:tab.action):tab.url}" title="${tab.title?:''}"
						class="melanin-mobile-menu ${tab.active?'active':''}" id="m-melanin-mobile-menu-${tab.name}">
						<span>${tab.label}</span>
					</a>
				</li>
			</sec:ifAnyGranted>
	    </g:each>
	</ul>
