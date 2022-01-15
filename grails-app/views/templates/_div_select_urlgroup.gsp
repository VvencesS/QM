<g:select id="urlgroup" name="urlgroup" noSelection="${['':'--Chọn--']}"
	class="form-control" from="${urlgroup_by_module}" optionKey="id" optionValue="${{it.name +' ('+it.usecasename+')'}}" />