<html><h1>Long Tran says: </h1><br/>
Please implement this search in any controller, eg. SearchController,
and pass the 'searchAction' params in to the m-melanin-header template in your <u>main.gsp</u> layout, eg.: <br/><br/>
&lt;g:render template="/templates/m-melanin-header"<br/>
		model="$ {[	<b><u>searchAction:'$ {createLinkTo(controller:"search",action:"globalSearch")}'</u></b>,<br/>
					logoURL:createLinkTo(dir:'images',file:'logo.png'),<br/>
					appDescriptions:'To be written',<br/>
					user:'LongTD']}"/&gt;
					<br/><br/>
					User params['global-search'] for the search term.
		<br/><br/>
		Also, when implement this Global Search function, use this Grails Searchable plugin: <br/>
		<a href="http://www.grails.org/plugin/searchable">Grails Searchable</a>