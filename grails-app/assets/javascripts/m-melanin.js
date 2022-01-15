$(function(){
	$(".delete-confirm").click(function(event){
		jquery_confirm('Xác nhận', 'Bạn có thật sự muốn xoá dữ liệu này không?',function(){
			document.location = $(event.target).attr('href');
		});
		return false;
	});
	
	$(".m-melanin-tooltip").tooltip({
		// tweak the position
	   offset: [-5, 40],
	   // use the "slide" effect
	   effect: 'slide'

	});
	$(".m-melanin-toggle-side-bar").click(function(){
		toggle_side_bar();
	});
	$("#load_spinner").dialog({
	    bgiframe: true,
	    modal: true,
	    autoOpen: false
	});
	$(window).scroll( function() {
		if($('#m-melanin-tab-header').length > 0){
	        if ($(window).scrollTop() > $('#m-melanin-tab-header').offset().top){
	            $('#m-melanin-tab-header-inner').addClass('floating');
	            $('#m-melanin-tab-header-inner').width($('#m-melanin-tab-header').width());
	        }else{
	            $('#m-melanin-tab-header-inner').removeClass('floating');
	        }
		}
    } );
	
	$.ajaxSetup({
			error:function(x,e){
				if(x.status==0 || e=='timeout'){
					jquery_alert('Thông báo','Mạng có vấn đề: xin vui lòng kiểm tra lại dây mạng/wifi.');
				}else if(x.status==401 || x.status==403 || x.responseText.error=='access denied'){
					jquery_alert('Thông báo','Bạn đã bị log out khỏi phần mềm hoặc không có quyền truy cập chức năng này. Xin vui lòng <strong><u>lưu lại các dữ liệu đang xử lý vào file word bên ngoài</u></strong> và login lại.');
				}else {
					jquery_alert_default_error();
				}
			}
		});
	
	$("input.m-melanin-datepicker").datepicker({dateFormat:'dd/mm/yy'});

	$(".formatNumber").autoNumeric('init',{
		maximumValue: '99999999999999999999',
		decimalPlacesOverride: '2',
		emptyInputBehavior: 'zero'
	});

	$(".formatNumberN").autoNumeric('init',{
		maximumValue: '99999999999999999999',
		minimumValue: '0',
		decimalPlacesOverride: '0',
		emptyInputBehavior: 'zero'
	});

	$(".formatNumber3cents").autoNumeric('init',{
		maximumValue: '99999999999999999999',
		decimalPlacesOverride: '3',
		emptyInputBehavior: 'zero'
	});
	$(".formatNumber0cents").autoNumeric('init',{
		maximumValue: '99999999999999999999',
		decimalPlacesOverride: '0',
		emptyInputBehavior: 'zero'
	});
	$(".formatNumberTang").autoNumeric('init',{
		maximumValue: '9999',
		decimalPlacesOverride: '0',
		emptyInputBehavior: 'zero',
		digitGroupSeparator: ''
	});
	$(".formatNumberNam").autoNumeric('init',{
		maximumValue: '9999',
		decimalPlacesOverride: '0',
		emptyInputBehavior: 'zero',
		digitGroupSeparator: ''
	});
	$('.formatNumber0cents, .formatNumber, .formatNumber3cents, .formatNumberTang, .formatNumberNam, .formatNumberN').each(function(i){
		var self = $(this);
		try{
			var v = (parseFloat(self.val().toString().replace(/,/g , "") )|| 0)
			self.val(v)
		}catch(err){

		}
	});
	$(".formatNumber0cents").autoNumeric('reSet');
	$(".formatNumber3cents").autoNumeric('reSet');
	$(".formatNumber").autoNumeric('reSet');
	$(".formatNumberTang").autoNumeric('reSet');
	$(".formatNumberNam").autoNumeric('reSet');
	$(".formatNumberN").autoNumeric('reSet');
});
function parse_money(number,locale){
	var locale = locale?locale:'vn';
	var format = (locale == 'vn'?'#,###':'#,###.00');
	return $.parseNumber(number, {format:format,locale:locale});
}
function format_money(number,locale){
	var locale = locale?locale:'vn';
	var format = (locale == 'vn'?'#,###':'#,###.00');
	return $.formatNumber(number, {format:format,locale:locale});
}
var m_melanin_side_bar = false;
function toggle_side_bar(){
	m_melanin_side_bar = !m_melanin_side_bar;
	set_side_bar(m_melanin_side_bar);
}
function set_side_bar(flag){
	m_melanin_side_bar = flag;
	if(flag){
		$("#m-melanin-page-wrap").addClass("m-melanin-left-sidebar")
	}else{
		$("#m-melanin-page-wrap").removeClass("m-melanin-left-sidebar");
	}
}
function clear_tabs(){
	$("#m-melanin-navigation ul").html('');
}
function add_tab(href,title,id,order){
	
	// check for existing menu
	if($("#m-melanin-menu-"+id).length > 0) return;
	
	// TODO: implement add tab with order
	if(order){
		console.log('function add_tab(href,title,id,order): Not implemented. Please do not pass in "order" parameter');
	}
	$("#m-melanin-navigation ul").append(
		'<li><a href="'+href+'" title="'+title+'"'+
				' id="m-melanin-menu-'+id+'"><span>'+title+'</span>'+
		'</a></li>'
		);
	
}
function set_active_tab(tab){
	$("#m-melanin-navigation a").removeClass('active');
	$("#m-melanin-navigation #m-melanin-menu-"+tab).addClass('active');
	$("#m-melanin-mobile-menu-"+tab).addClass('active');
}

function jquery_alert_default_error(){
	jquery_alert('Thông báo','Lỗi hệ thống: xin vui lòng liên hệ IT Service Desk');
}

function jquery_alert(title,content,callback){

    var div = '<div id="alert_dialog" title="'+title+'" style="display: none">'+
        '<p>'+content+'</p>'+
        '</div>';

    $("body").append(div);

    $("#alert_dialog").dialog({
        bgiframe: true,
        modal: true,
        buttons: {
            OK: function() {
                $(this).dialog('close');
                $("#alert_dialog").replaceWith('');
                if(callback) callback();
            }
        }
    });
}
function jquery_input(title,content,callback){
	var div = '<div id="m_melanin_input_dialog" title="'+title+'" style="display: none">'+
    '<p>'+content+'</p>'+
    '<input name="m_melanin_input_dialog_value" type="text" class="e-xxl"/>'
    '</div>';

	$("body").append(div);
	
	$("#m_melanin_input_dialog").dialog({
	    bgiframe: true,
	    modal: true,
	    buttons: {
	        OK: function() {
	        	$(this).dialog('close');
	        	callback($("#m_melanin_input_dialog input[name=m_melanin_input_dialog_value]").val());
	            $("#m_melanin_input_dialog").replaceWith('');
	            
	        },
	        Cancel: function() {
	            $(this).dialog('close');
	            $("#m_melanin_input_dialog").replaceWith('');
	        }
	    }
	});
}
function jquery_confirm(title,content,callback,cancelCallback){

    var div = '<div id="alert_dialog" title="'+title+'" style="display: none">'+
        '<p>'+content+'</p>'+
        '</div>';

    $("body").append(div);

    $("#alert_dialog").dialog({
        bgiframe: true,
        modal: true,
        buttons: {
            OK: function() {
                $(this).dialog('close');
                $("#alert_dialog").replaceWith('');
                if(callback) callback();
            },
            Cancel: function() {
                $(this).dialog('close');
                $("#alert_dialog").replaceWith('');
                if(cancelCallback) cancelCallback();
            }
        }
    });
}

function jquery_open_load_spinner(){
    $("#load_spinner").dialog('open');
}
function jquery_close_load_spinner(){
    $("#load_spinner").dialog('close');
}
function growl(message,type,title){
	if(!type)
		type='alert';
	if(!title)
		title = 'Thông báo';

	$.pnotify({
		pnotify_title: title,
		pnotify_text: message,
		pnotify_type: type,
		pnotify_opacity: .9
	});
}
Number.prototype.padLeft = function(width, char) {
  if (!char) {
    char = " ";
  }

  if (("" + this).length >= width) {
    return "" + this;
  }
  else {
    return arguments.callee.call(
      char + this, 
      width, 
      char
    );
  }
}
var mangso=['không','một','hai','ba','bốn','năm','sáu','bảy','tám','chín'];function dochangchuc(so,daydu){var chuoi="";chuc=Math.floor(so/10);donvi=so%10;if(chuc>1){chuoi=" "+mangso[chuc]+" mươi";if(donvi==1){chuoi+=" mốt"}}else if(chuc==1){chuoi=" mười";if(donvi==1){chuoi+=" một"}}else if(daydu&&donvi>0){chuoi=" lẻ"}if(donvi==5&&chuc>1){chuoi+=" lăm"}else if(donvi>1||(donvi==1&&chuc==0)){chuoi+=" "+mangso[donvi]}return chuoi}function docblock(so,daydu){var chuoi="";tram=Math.floor(so/100);so=so%100;if(daydu||tram>0){chuoi=" "+mangso[tram]+" trăm";chuoi+=dochangchuc(so,true)}else{chuoi=dochangchuc(so,false)}return chuoi}function dochangtrieu(so,daydu){var chuoi="";trieu=Math.floor(so/1000000);so=so%1000000;if(trieu>0){chuoi=docblock(trieu,daydu)+" triệu";daydu=true}nghin=Math.floor(so/1000);so=so%1000;if(nghin>0){chuoi+=docblock(nghin,daydu)+" nghìn";daydu=true}if(so>0){chuoi+=docblock(so,daydu)}return chuoi}function docso(so){if(so==0)return" không";var chuoi="",hauto="";do{ty=so%1000000000;so=Math.floor(so/1000000000);if(so>0){chuoi=dochangtrieu(ty,true)+hauto+chuoi}else{chuoi=dochangtrieu(ty,false)+hauto+chuoi}hauto=" tỷ"}while(so>0);return chuoi[1].toUpperCase()+chuoi.substr(2)}

// ****************************************

String.format = function() {
    // The string containing the format items (e.g. "{0}")
    // will and always has to be the first argument.
    var theString = arguments[0];
    
    // start with the second argument (i = 1)
    for (var i = 1; i < arguments.length; i++) {
        // "gm" = RegEx options for Global search (more than one instance)
        // and for Multiline search
        var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
        theString = theString.replace(regEx, arguments[i]);
    }
    
    return theString;
}

function isToday(someDate) {
	var today = new Date()
	return someDate.getDate() == today.getDate() &&
		someDate.getMonth() == today.getMonth() &&
		someDate.getFullYear() == today.getFullYear()
};

//hoavd2: check từ ngày <= đến ngày
function checkToDateWithFromDate (fromDate, toDate){
	// debugger
	var datePartFromDate = fromDate.split("/");
	var datePartToDate = toDate.split("/");
	var fromdate = new Date(+datePartFromDate[2], datePartFromDate[1] - 1, +datePartFromDate[0]);
	var todate = new Date(+datePartToDate[2], datePartToDate[1] - 1, +datePartToDate[0]);
	return fromdate.getDate() <= todate.getDate() &&
		fromdate.getMonth() <= todate.getMonth() &&
		fromdate.getFullYear() <= todate.getFullYear()

};

//hoavd2: show tooltip khi ấn vào column dataTable
$.fn.dataTable.render.ellipsis = function (cutoff, wordbreak, escapeHtml) {
	var esc = function (t) {
		return t
			.replace(/&/g, '&amp;')
			.replace(/</g, '&lt;')
			.replace(/>/g, '&gt;')
			.replace(/"/g, '&quot;');
	};

	return function (d, type, row) {
		// Order, search and type get the original data
		if (type !== 'display') {
			return d;
		}

		if (typeof d !== 'number' && typeof d !== 'string') {
			return d;
		}

		d = d.toString(); // cast numbers

		if (d.length < cutoff) {
			return d;
		}

		var shortened = d.substr(0, cutoff - 1);

		// Find the last white space character in the string
		if (wordbreak) {
			shortened = shortened.replace(/\s([^\s]*)$/, '');
		}

		// Protect against uncontrolled HTML input
		if (escapeHtml) {
			shortened = esc(shortened);
		}

		return '<span class="ellipsis" title="' + esc(d) + '">' + shortened + '&#8230;</span>';
	};
};