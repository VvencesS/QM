<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		<div id="m-melanin-tab-header">
			<div id="m-melanin-tab-header-inner">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[
						[name:'m-test-button-3',label:'Toggle sidebar',class:'primary m-melanin-toggle-side-bar']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:'#',title:'home',label:'Home'],
						[href:'#',title:'Melanin',label:'Melanin'],
						[href:'#',title:'Plugin page',label:'Plugin']]
					]}"/>
			</div>
			<div class="clear"></div>
		</div>
		<div id="m-melanin-left-sidebar">
			<ul class="m-melanin-vertical-navigation">
				<li><span class=" ss_sprite ss_email">&nbsp;</span><a>Test Inbox</a><div class="right"><span class=" ss_sprite ss_arrow_refresh">&nbsp;</span></div></li>
				<li class="active"><span class=" ss_sprite ss_email_go">&nbsp;</span><a>Documentation</a> </li>
				<li><span class=" ss_sprite ss_bin">&nbsp;</span><a>Trash</a> <div class="right"><span class=" ss_sprite ss_tab_delete">&nbsp;</span></div></li>
			</ul>
		</div>
		<div id="m-melanin-main-content">
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-largel-panel-1">	
			<h3>DNA - Document Management</h3>
			<div>
				<p>Source code: <a href="#"></a>Source code</p>
				<p>Descriptions: This plugin provides you with access to low level file system such as: disk drives, Alfresco servers...</p>
				<p>Services (available via Dependency Injection):</p> 
				<p>- dnaDocumentService</p>
				<pre class="prettyprint lang-java">
package msb.platto.dna.service;

import java.util.List;
import java.util.Map;
import java.io.File;
import java.io.InputStream;

public interface DnaDocumentService {

	/*
	* input: 	type = abc, prefix = abc/xyz
	*/
	boolean createDefaultDocumentStructure(String type, String prefix );

	boolean updateServiceProperty();

	String getRootNodeId();

	String getRootNodeName();

	/*
	* input: 	folderName = abc, parentNodeRef = <ID>
	* output:	<ID>
	*/
	String createFolder(String folderName, String folderDesc, String parentNodeRef);

	String createFileFromStream(String parentId, String fileName, String fileDescription, InputStream inputStream);

	boolean editNode(String nodeId, String newName, String newDescription);

	boolean deleteNode(String nodeId);

	String isNodeExisted(String myId, String checkName, String parentId);

	String isParentExisted(String parentId);

	Map getProperties(String nodeId);

	boolean copyNodes(List originalNodeIds, String destinationContainerID);

	boolean moveNodes(List originalNodeIds, String destinationContainerID);

	List getTreeData(String nodeId);

	File getNodeContent(String nodeId);

	Map getParentNode(String nodeId);

	/*
	* input: 	path = abc/xyz/qwe
	* output:	<ID from rootPath+path>
	*/
	String getId(String path);

	List listFiles(String id);

	List listFolders(String id);

	List listChildren(String id);

	String getLimitedId();
	String getTopLevelId();
	String getParentTopLevelId();

	List getChildrenByLevel(String nodeId,int level);

	/*
	* input: 	nodeId = ID
	* output:	"file"/"folder"
	*/
	String getNodeRef(String nodeId);
}
				</pre>
		
				</div>
			</div>
			
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-largel-panel-2">	
				<h3>SENSE - Dynamic form</h3>
				<div>
					<p>Source code:</p>
					<p>Description: Form builder (textfields, text areas, select boxes, radio boxes...) and form runner.</p>
					<p>Templates:</p>
					<pre class="prettyprint">
<div id="m-melanin-main-content">
	&lt;g:form name="m-sense-form-instance" action="submitData" controller="myApplicationProcessor">
		&lt;g:render template="/m-sense-templates/m-sense-form" model="$ {[form:form]}"/>
	&lt;/g:form>
</div>						
					</pre>
				</div>
			</div>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-largel-panel-3">	
				<h3>VEIN - Workflow Management</h3>
				<div>TBD
				</div>
			</div>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-largel-panel-4">	
				<h3>NEURO - Rule Engines</h3>
				<div>TBD
				</div>
			</div>
			


		</div>


		<script type="text/javascript">
		$(function(){
			set_active_tab('plugins');
			$("#datatables-test").dataTable();
			$("#sprites-section").scrollbar();
			$(".m-melanin-large-panel").panel({
				width:940,
				cookie:true
			});
			prettyPrint();
		});
		
		
	    </script>
	
	</body>
</html>