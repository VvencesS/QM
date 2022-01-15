<li  class="btn-group">
	<g:each in="${buttons}" var="button">
		<button value="${button.label}" class="btn ${button.class}" name="${button.name}" data-toggle="modal"
				data-target="${button.modal}"><i class="${button?.icon}"></i> ${button.label}</button>
	</g:each>
</li>