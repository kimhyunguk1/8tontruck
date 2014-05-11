<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%String msg = (String) request.getAttribute("msg");%>
<%String userName = (String) request.getAttribute("userName");%>
<%String userId = (String) request.getAttribute("userId");%>
<%String searchDate = (String)request.getAttribute("searchDate");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Prescription Search</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/PromesService/js/common.js" ></script> 
<script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}


function MM_openBrWindow(theURL,winName,features) {
  var mainForm = document.form;
  window.open(theURL,winName,features);
}

//초기화
function init(){	
	
	var mainForm = document.form;
	mainForm._loginId.value = parent.getId();	
	<%if(userName != null && !userName.equals("")){%>
		mainForm._name.value = '<%=userName%>';		
	<%}%>
	
	<%if(userId != null && !userId.equals("")){%>
		mainForm._id.value = '<%=userId%>';
	<%}%>
	
	<%if(msg != null && !msg.equals("")){%>		
		parent.changeMenu('none');
	<%}%>	
	mainForm.cmd.value = 'searchPrescriptionPage';	                      
	mainForm._type.value = parent.getType();
	mainForm.target = "prescriptionListPage";
	mainForm.submit();
}

function initsize() {
	//prescriptionListPage.resizeTo(prescriptionListPage.document.body.scrollWidth, prescriptionListPage.document.body.scrollHeight);
	var _height = document.getElementById('prescriptionListPage').contentWindow.document.body.scrollHeight;
    document.getElementById('prescriptionListPage').height=_height;
	parent.initsize();
}

function getUserId(){
	return "";
}

function setUserId(value){
	var mainForm = document.form;
	mainForm._id.value = value;
}

function setUserName(value){
	var mainForm = document.form;
	mainForm._name.value = value;
}

function returnUserName(){
	var mainForm = document.form;
	mainForm._id.value = "";
	mainForm._name.value = "";
}

function getType(){	
	return parent.getType();
}

function getLoginId(){
	var mainForm = document.form;
	return mainForm._loginId.value;
}

function getBoxType(){
	
	var mainForm = document.form;
	var index = mainForm._gubun.selectedIndex;	
	mainForm._boxtype.value = mainForm._gubun.options[index].value;		
	if(mainForm._boxtype.value == null || mainForm._boxtype.value == ""){		
		mainForm._boxtype.value = "";
	}
	return mainForm._boxtype.value;
}

function clear(){
	var mainForm = document.form;
	mainForm._id.value = "";
	mainForm._name.value = "";
	mainForm._prescriptionId.value = "";
	mainForm._startDate.value = "";
	mainForm._endDate.value = "";
	mainForm._takenSatus.value = "";
}

function changeMenu(value){		
	parent.changeMenu(value);	
}

function changeTitle(value){
	parent.changeTitle(value);
}

function findUser(){
	var mainForm = document.form;
	if(mainForm._name.value != null && mainForm._name.value != ''){
		var tmpName = mainForm._name.value;
		var x = 0; 
		var	y = 0;
		var w = 700;
		var h = 280;
	 	if (self.innerHeight) { // IE 외 모든 브라우저 
	        x = (screen.availWidth - w) / 2; 
	        y = (screen.availHeight - h) / 2; 
	    }else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict 모드 
	        x = (screen.availWidth - w) / 2; 
	        y = (screen.availHeight - h) / 2; 
	    }else if (document.body) { // 다른 IE 브라우저( IE < 6) 
	        x = (screen.availWidth - w) / 2; 
	        y = (screen.availHeight - h) / 2; 
	    } 
		var point = "width=700, height=280, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
		var tmpUrl = '/PromesService/PromesServerServlet?cmd=loadUserListPopupPage&_userName=' + tmpName + '&_target=searchResultPage';
		MM_openBrWindow(tmpUrl,'findUserPopup',point);
	}
}

function searchPrescription(userName, userId, prescriptionId, startDate, endDate, status){	
	var mainForm = document.form;
	mainForm.cmd.value = 'searchPrescriptionPage';
	mainForm.target = "prescriptionListPage";
	mainForm.submit();
	//var index = mainForm._gubun.selectedIndex;
	//mainForm._boxtype.value = mainForm._gubun.options[index].value;	
	//if(mainForm._boxtype.value == null || mainForm._boxtype.value == ""){		
		//mainForm._boxtype.value = "";
	//} 
	//if(mainForm._name.value == null || mainForm._name.value == ""){
		//mainForm._id.value = "";
	//} 

}


function deletePrescription(prescriptionId, userId, status, hospital,changeStatus){
	if(status == "ON"){	
		if(changeStatus == "STOP"){
			if(!confirm("<fmt:message key='are_you_sure_to_stop_the_management_of_prescription' />"))
				return;
		}else if(changeStatus == "FINISH"){
			if(!confirm("<fmt:message key='Are_you_sure_to_finish_the_management_of_prescription?' />"))
				return;		
		}	
		var mainForm = document.form;
		mainForm._status.value = changeStatus;
		mainForm.cmd.value = 'finishPrescription';
		mainForm._delPrescriptionId.value = prescriptionId;
		mainForm._userId.value = userId;
		mainForm._hospital.value = hospital;
		mainForm.target = "deleteResultPage";
		mainForm.submit();
		
		
	}else{
		if(!confirm(prescriptionId + "<fmt:message key='Are_you_sure_to_delete_this_prescription?' />")){
			return;
		}
		var mainForm = document.form;
		mainForm._status.value = status;
		mainForm.cmd.value = 'deletePrescription';
		mainForm._delPrescriptionId.value = prescriptionId;
		mainForm._userId.value = userId;
		mainForm._hospital.value = hospital;
		mainForm.target = "deleteResultPage";
		mainForm.submit();
	}
}

function openDetailSearch(){
	var mainForm = document.form;
	var tmpId = mainForm._id.value;
	var tmpName = mainForm._name.value;
	
	var x = 0; 
	var	y = 0;
	var w = 400;
	var h = 260;
 	if (self.innerHeight) { // IE 외 모든 브라우저 
        x = (screen.availWidth - w) / 2; 
        y = (screen.availHeight - h) / 2; 
    }else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict 모드 
        x = (screen.availWidth - w) / 2; 
        y = (screen.availHeight - h) / 2; 
    }else if (document.body) { // 다른 IE 브라우저( IE < 6) 
        x = (screen.availWidth - w) / 2; 
        y = (screen.availHeight - h) / 2; 
    } 
	var point = "width=400, height=260, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	var tmpUrl = '/PromesService/home/prescription/detailSearch_popup.jsp?id=' + tmpId + '&name=' + tmpName;
	MM_openBrWindow(tmpUrl,'detailSearchPopup',point);
}
function get_xy(type){	
	var _style = alt_div.style;	
	var x = 0;
	var y = 0;
	x = point_x;
	y = point_y;
	if(x < 780 && y < 610){
	  _style.left = x - 5;
	  _style.top = y - 5;
	}
}
document.onmousemove = out_xy;
var point_x;
var point_y;
function out_xy(){
//  alert(event.y+document.body.scrollTop);
  if(_out == "true"){
    var layer_x = alt_div.style.left;
    var layer_y = alt_div.style.top;
    layer_x = layer_x.substring(0, layer_x.length - 2);
    layer_y = layer_y.substring(0, layer_y.length - 2);
    var out_x = event.x+document.body.scrollLeft;
    var out_y = event.y+document.body.scrollTop;
    if(layer_x - 5 > out_x || out_x > Number(layer_x) + 225){
      alt();
    }
    if(layer_y - 5 > out_y || Number(layer_y) + 208 < out_y){
      alt();
    }
  }else{
  	point_x = event.x+document.body.scrollLeft;
    point_y = event.y+document.body.scrollTop;
  }
}
var _out = "false";
function alt(type,id,_width,_height){  	
	  if(type != null){
	    _out = "true";
	  }else{
	    _out = "false";
	  }
	  var content ="<TABLE HEIGHT='205' WIDTH='220' BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR=#FFFF00>";
	  content += "<TR><TD>";
	  content += "<iframe name=\"calendarPopup\" id=\"calendarPopup\" src=\"/PromesService/PromesServerServlet?cmd=loadCalendarPage&_parentType=PARENT&type=";
	  content += type +"\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" height=\"100%\" width=\"100%\" ></iframe>";
	  content += "</TD></TR><TABLE>";	  
	  get_xy(type);	 
	  var _style = alt_div.style;
	  if( type != null ){
	    alt_div.innerHTML = content;
	    _style.visibility = "visible";
	    if( _width != null ){
	      if( alt_div.offsetWidth > _width ){
	        _style.width = _width;
	      }
	    }
	    if( _height != null ){
	      if( alt_div.offsetHeight > _height ){
	        _style.height = _height;
	      }
	    }
	  }else{
	    _style.visibility = "hidden";
	  }
  
}
function changeDate(type, value)
{	
	var mainForm = document.form;
	var todayDt = new Date();
	var dt = new Date();
	if(type == 'start')
	{
		mainForm._searchDate.value = value;
	}
	
	//getdate(mainForm._searchDate.value);
	
	init();
	
	alt();
}
document.write(
	    "<div id=alt_div style=\"" +
	    "padding:0;" +
	    "border:0 solid #FF7200;" + // 말풍선 테두리 컬러
	    "background-color:#efefef;color:#000;" + // 말풍선 테이블 백그라운드컬러 / 폰트컬러
	    "position:absolute;" +
	    "visibility:hidden;" +
	    "overflow:hidden;" +
	    "z-index:auto;" +
	    "width:auto;" +
	    "height:auto;" +
	    "filter:alpha(opacity=100);" + // 투명도
	    "\"></div>"
);
//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_search_.gif','/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/prescription/left_menu_a_.gif','/PromesService/images/prescription/left_menu_c_.gif','/PromesService/images/common/bt_inquiry_.gif','/PromesService/images/common/bt_revision2_.gif','/PromesService/images/common/bt_internal_.gif','/PromesService/images/common/bt_delete2_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet" onsubmit="return false">
<input name="cmd" type="hidden" value=""/>
<input name="_delPrescriptionId" type="hidden" value="" />
<input name="_type" type="hidden" value="" />
<input name="_userId" type="hidden" value="" />
<input name="_status" type="hidden" value="" />
<input name="_loginId" type="hidden" value="" />
<input name="_hospital" type="hidden" value="" />
<input name="_boxtype" type="hidden" value="" />
<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35"width="794" background="/PromesService/images/prescription/main_title_b.gif">
<!-- 		<table width="400" border="0" cellspacing="0" cellpadding="0"> -->
<!-- 			<tr> -->
<!-- 				<td width="110">  &nbsp;&nbsp;</td> -->
<%-- 				<td><input name="_searchDate" type="text" class="inputbox" size="20" id="_searchDate" align="center" readonly="true" value="<%=searchDate%>"/></td> --%>
<!-- 				<td width="40" align="center"><a href="javascript:alt('start');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td> -->
<!-- 				<td width="60">&nbsp;</td> -->
<!-- 				<td width="50"> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</table> -->
		</td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td>
		<table width="756" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				    <iframe name="prescriptionListPage" id="prescriptionListPage" src="" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
				</td>
			</tr>
			<tr>
				<td height="39" align="center" background="/PromesService/images/common/box_01.gif">
				<table width="735" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="120" align="right"><img src="/PromesService/images/common/dot_01.gif" width="11" height="11" /></td>
						<td width="50" class="td_table01"><fmt:message key='search' /></td>
<!-- 						<td width="50"> -->
<!-- 						     <select name="_gubun" class="select_white" style="width: 60px" id="_gubun"> -->
<!-- 							   <option value="">전체</option> -->
<!-- 							   <option value="로드셀형">new</option> -->
<!-- 							   <option value="연속형">old</option> -->
<!-- 						    </select>&nbsp; -->
<!-- 						</td> -->
						<td width="120"><select name="_keyType" class="select_white" style="width: 120px" id="_keyType">
							<option value="id"><fmt:message key='patient_name' /></option>
						</select></td>
						<td align="right"><input name="_name" type="text"  size="70" id="_name" onkeydown="javascript:if(event.keyCode==13 || window.event.keyCode ==9){findUser();}"  /><input name="_id" type="hidden" value=""/></td>
						<td width="50" align="center"><a href="javascript:searchPrescription();">
							<img src="/PromesService/images/common/bt_inquiry2.gif" width="44" height="22" border="0" id="Image9" onmouseover="MM_swapImage('Image9','','/PromesService/images/common/bt_inquiry2_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
<!-- 						<td width="75" align="center"><a href="javascript:openDetailSearch();"> -->
<!-- 							<img src="/PromesService/images/common/bt_search.gif" width="57" height="22" border="0" id="Image10" onmouseover="MM_swapImage('Image10','','/PromesService/images/common/bt_search_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td> -->
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<iframe name="searchResultPage" id="searchResultPage" src="/PromesService/home/user/userInfoResult.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0"></iframe></form>
<iframe name="deleteResultPage" id="deleteResultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="0" height="0"></iframe>
</form>
</body>
</html>
