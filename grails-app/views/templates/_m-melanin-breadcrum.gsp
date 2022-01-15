	<li>
		<g:each in="${buttons}" var="button">
		<button value="${button.label}" class="btn small ${button.class}" name="${button.name}">${button.label}</button>
	</g:each>
	</li>
	<li><a href="${createLink(controller: 'direct', action:'index')}" title='${items[0].title?:''}'>Home</a>
		<span class="divider">/</span>
	</li>
	<g:each in="${items}" var="item" status="i">
		<g:if test="${i>0 && i<items.size() - 1}">
			<li><a href="${item.href}" title="${item.title?:''}">${item.label}</a>
			<span class="divider">/</span>
			</li>
		</g:if>
		<g:if test="${i==items.size() - 1}">
			<li>${item.label}</li>
		</g:if>
    </g:each>
