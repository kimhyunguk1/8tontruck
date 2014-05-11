<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="java.util.Hashtable"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%String type = (String) request.getAttribute("type");%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 User Search</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
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

var userType = "patient";
function init(){
	<%if(type != null && !type.equals("")){%>
		userType = '<%=type %>';
	<%}%>
	parent.changeMenu('changeList');
	changeTitleTable(userType);
}

function setUserCount(value1, value2, value3){
	parent.setUserCount(value1, value2, value3);
}

function initsize() {
	//userListPage.resizeTo(userListPage.document.body.scrollWidth, userListPage.document.body.scrollHeight);
	var _height = document.getElementById('userListPage').contentWindow.document.body.scrollHeight;
    document.getElementById('userListPage').height=_height;
	parent.initsize();
}

function changeTitleTable(value){
	var tmpHtml = "";
	tmpHtml += "<table width=\"192\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
	tmpHtml += "<tr><td width=\"95\">";
	if(value == 'patient'){
		tmpHtml += "<a href=\"javascript:changeTitleTable('patient');\"><img src=\"/PromesService/images/management/tab_01.gif\" width=\"94\" height=\"29\" id=\"Image3\" border=\"0\" /></a></td>";
	    tmpHtml += "<td width=\"95\"><a href=\"javascript:changeTitleTable('incharge');\"><img src=\"/PromesService/images/management/tab_02_.gif\" width=\"94\" height=\"29\" id=\"Image5\" border=\"0\" onmouseover=\"MM_swapImage('Image5','','/PromesService/images/management/tab_02.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    
	}else if(value == 'incharge'){
		tmpHtml += "<a href=\"javascript:changeTitleTable('patient');\"><p><img src=\"/PromesService/images/management/tab_01_.gif\" width=\"94\" height=\"29\" id=\"Image3\" border=\"0\" onmouseover=\"MM_swapImage('Image3','','/PromesService/images/management/tab_01.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></p></a></td>";
	    tmpHtml += "<td width=\"95\"><a href=\"javascript:changeTitleTable('incharge');\"><img src=\"/PromesService/images/management/tab_02.gif\" width=\"94\" height=\"29\" id=\"Image5\" border=\"0\" /></a></td>";	   
	}
	tmpHtml += "</tr></table>"
	tabieDiv.innerHTML = tmpHtml;
	changeTable(value);
}

function changeTable(value){
	var tmpHtml = "";
	var tmpSmsHtml = "&nbsp; ";
	if(value == 'patient'){
		userType = "PATIENT";
		tmpHtml ="<iframe name=\"userListPage\" id=\"userListPage\" src=\"/PromesService/PromesServerServlet?cmd=searchUserInfoList&type=PATIENT\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		tmpSmsHtml = "<a href=\"javascript:openSmsPopup();\"><img src=\"/PromesService/images/common/bt_sms.gif\" width=\"74\" height=\"22\" id=\"Image9\" border=\"0\" onmouseover=\"MM_swapImage('Image9','','/PromesService/images/common/bt_sms_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a>";
	}else if(value == 'incharge'){
		userType = "INCHARGE";
		tmpHtml ="<iframe name=\"userListPage\" id=\"userListPage\" src=\"/PromesService/PromesServerServlet?cmd=searchUserInfoList&type=INCHARGE\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}
	userListDiv.innerHTML = tmpHtml;
	smsDiv.innerHTML = tmpSmsHtml;
}

function searchUser(){
	var mainForm = document.form;
	mainForm.cmd.value = "searchUserInfoList";
	mainForm.type.value = userType;
	mainForm.target = "userListPage";
	mainForm.submit();
}

function changeMenu(value){	
	parent.changeMenu(value);
}

function deleteUser(){
	userListPage.deleteUser();
}

function deleteAllUser(){
	userListPage.deleteAllUser();
}

function openSmsPopup(){
	var userList = userListPage.getSelectUserList();
	if(userList == null || userList == ""){
		alert("<fmt:message key='You_should_choose_more_than_one_user._' />");
		return;
	}
	var x = 0; 
	var	y = 0;
	var w = 243;
	var h = 546;
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
	var point = "width=243, height=546, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	MM_openBrWindow('/PromesService/home/common/phone_popup.jsp?userList=' + userList,'idCheckPopup',point);
}

//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/pharmacist/left_menu_b_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/management/left_menu_b_.gif','/PromesService/images/common/bt_delete_.gif','/PromesService/images/common/bt_all delete_.gif','/PromesService/images/common/bt_inquiry2_.gif','/PromesService/images/common/bt_sms_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet" onsubmit="return false">
<input name="cmd" type="hidden" value=""/>
<input name="type" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="/PromesService/images/management/main_title_i.gif" width="794" height="35" /></td>
	</tr>
	<tr>
		<td height=5></td>
	</tr>
	<tr>
		<td>
		<table width="756" border="0" cellspacing="0" cellpadding="0">
			<tr height="2"><td width="756"><div id="tabieDiv"><table width="192" border="0" cellspacing="0" cellpadding="0">
						<tr height="29">
							<td width="95">
							<img src="/PromesService/images/management/tab_01.gif" width="94" height="29" id="Image3" />
							</td>
							<td width="95"><a href="javascript:changeTitleTable('incharge');"><img src="/PromesService/images/management/tab_02_.gif" width="94" height="29" id="Image5" border="0" onmouseover="MM_swapImage('Image5','','/PromesService/images/management/tab_02.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
							
							<td>&nbsp; </td>
						</tr>
					</table></div>
				</td>
			</tr>
			<tr>
				<td><div id="userListDiv" >				
					<iframe name="userListPage" id="userListPage" src="/PromesService/home/management/patient.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
				</div></td>
			</tr>
			<tr>
				<td height="39" align="center" background="/PromesService/images/common/box_01.gif" style="background-repeat: no-repeat;">
				<table width="735" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="140" align="right"><img src="/PromesService/images/common/dot_01.gif" width="11" height="11" /></td>
						<td width="70" class="td_table01"><fmt:message key='search' /></td>
						<td width="90" align="right"><select name="_keyType" class="select_white" style="width: 90px" id=""_keyType"">
							<option value="id">ID</option>
							<option value="name"><fmt:message key='name' /></option>
							<option value="email">EMAIL</option>
						</select></td>
						<td align="right" valign="top"><input name="_key" type="text"  size="70" id="_key" onkeydown="javascript:if(event.keyCode==13){searchUser();}" /></td>
						<td width="50" align="center"><a href="javascript:searchUser();">
							<img src="/PromesService/images/common/bt_inquiry2.gif" width="44" height="22" border="0" id="Image7" onmouseover="MM_swapImage('Image7','','/PromesService/images/common/bt_inquiry2_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="15">&nbsp;</td>
			</tr>
			<tr>
				<td height="2">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
						<td width="80" valign="bottom"><div id="smsDiv"><a href="javascript:openSmsPopup();"><img src="/PromesService/images/common/bt_sms.gif" width="74" height="22" id="Image9" border="0" onmouseover="MM_swapImage('Image9','','/PromesService/images/common/bt_sms_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></div></td>
						<td width="80" valign="bottom"><a href="javascript:deleteAllUser();"><img src="/PromesService/images/common/bt_all delete.gif" width="74" height="22" id="Image4" border="0" onmouseover="MM_swapImage('Image4','','/PromesService/images/common/bt_all delete_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
						<td width="74" valign="bottom"><a href="javascript:deleteUser();"><img src="/PromesService/images/common/bt_delete.gif" width="74" height="22" id="Image8" border="0" onmouseover="MM_swapImage('Image8','','/PromesService/images/common/bt_delete_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="15">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>