<%@page import="java.util.Calendar"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo"%>
<%@page import="java.util.Hashtable"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%ArrayList prescriptionList = (ArrayList) request.getAttribute("prescriptionList");%>
<%String pageIdx = (String)request.getAttribute("pageIdx");%>
<%String maxPageIdx = (String)request.getAttribute("maxPageIdx");%>
<%String sortType = (String)request.getAttribute("sortType");%>
<%String sortCourse = (String)request.getAttribute("sortCourse");%>
<%UserInfo LoginuserInfo = (UserInfo)session.getAttribute("LoginuserInfo");%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="java.util.Collections"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Prescription Info List</title>
<link href="/PromesService/css/jquery.toastmessage.css" rel="stylesheet" type="text/css" />
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript"src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/PromesService/js/jquery.toastmessage.js" type="text/javascript"></script>
<script type="text/javascript">
<!--
var G_prescriptionId,
	G_userId, 
	G_status, 
	G_hospital="";
	
$(document).ready(function(){

			
	$('#Image002').on("click", function(){
		$('#TakenSubmitdiv').fadeOut(400);
		$('.takenRDObtnList').each(function(){			
			$('.takenRDObtnList:checked').attr('checked',false);
		});
	});
	$('#Image001').on("click" ,function(e){		
		if(!$('.takenRDObtnList').is(':checked')){
			$().toastmessage('showNoticeToast', "<fmt:message key='check_up_the_status_changed' />");
			//alert('변경상태를 체크해주세요.');				
		}else{		
			parent.deletePrescription(G_prescriptionId, G_userId, G_status, G_hospital,$('.takenRDObtnList:checked').val());						
		}
	});
	$('.PrescriptionChangeBtn').on("click", function(e){
		var Y = e.clientY;
		if(Y>200)
			Y=Math.abs(70 - e.clientY);
		$('#TakenSubmitdiv').css('top',Y);
	});
});
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
	  window.open(theURL,winName,features);
	}

function loadModifyPrescription(value, hospital){	
	parent.changeMenu("modify");	
	var mainForm = document.form;
	mainForm.cmd.value = 'loadModifyPrescriptionPage';
	mainForm._prescriptionId.value = value;
	mainForm._hospital.value = hospital;	
	mainForm._type.value = parent.getType();
	
	
	
	if('${LoginuserInfo.type}' == "ADMIN"){
		mainForm.target = "managementMainPage";
	}else{
		mainForm.target = "prescriptionMainPage";	
	}
	
	mainForm.submit();
}
function deletePrescription(prescriptionId, userId, status, hospital){
			
	if($(this).attr("src")=="/PromesService/images/common/bt_empty.gif"){			
		return;
	}
	$('#TakenSubmitdiv').fadeIn(500);	
	G_prescriptionId = prescriptionId;
	G_userId = userId;
	G_status = status;
    G_hospital = hospital;
}

function lodeReceivePill()
{
	window.location = "/PromesService/home/prescription/receivePill.jsp";
}

function lodeConsultation()
{
	window.location = "/PromesService/home/prescription/consultation.jsp";
}

function loadDosagePage(value1, value2, hospital)
{	
	parent.changeMenu("none");
	//parent.changeTitle("복용현황");
	var mainForm = document.form;
	mainForm.cmd.value = 'loadDosagePage';
	mainForm._prescriptionId.value = value1;
	mainForm._userId.value = value2;	
	mainForm._hospital.value = hospital;
	
	if('${LoginuserInfo.type}' == "ADMIN"){
		mainForm.target = "managementMainPage";
	}else{
		mainForm.target = "prescriptionMainPage";	
	}
	mainForm.submit();
}

function initsize() {
	sortTableDiv();
	parent.initsize();
}

function changePage(idx, value){
	var mainForm = document.form;
	mainForm.cmd.value = 'searchPrescriptionPage';
	mainForm._type.value = parent.getType();
	mainForm._loginId.value = parent.getLoginId();	
	
	var pageIdx = '<%=pageIdx%>';
	
	if(value == null){
		pageIdx = idx;
	}else{
		if(value == 'sub'){
			pageIdx = Number(pageIdx) - 1;
		}else{
			pageIdx = Number(pageIdx) + 1;
		}
	}
	mainForm._pageIdx.value = pageIdx;
	<%if(sortType != null && !sortType.equals("")){%>
		mainForm._sortType.value = '<%=sortType%>';
	<%}%>
	<%if(sortType != null && !sortType.equals("")){%>
		mainForm._sortCourse.value = '<%=sortCourse%>';
	<%}%>
	//mainForm._searchDate.value=parent.form._searchDate.value;
	
	console.log("pageIdx : " + pageIdx + " value : " + value + " idx : "+ idx + " mainForm._type.value : " + mainForm._type.value + " mainForm._loginId.value : " + mainForm._loginId.value + " mainForm._searchDate.value : " + mainForm._searchDate.value);
	mainForm.target = "prescriptionListPage";
	mainForm.submit();
}

function sortTable(type){	
	var mainForm = document.form;
	mainForm.cmd.value = 'searchPrescriptionPage';
	mainForm._type.value = parent.getType();
	mainForm._sortType.value = type;
	mainForm._loginId.value = parent.getLoginId();	
	mainForm._sortCourse.value = "UP";
	<%if(sortType != null && !sortType.equals("")){%>
		if(type == '<%=sortType%>'){
			<%if(sortCourse != null && !sortCourse.equals("")){
				if(sortCourse.equals("UP")){%>
					mainForm._sortCourse.value = "DOWN";
				<%}%>
			<%}%>
		}
	<%}%>
	mainForm._pageIdx.value = '<%=pageIdx%>';
	mainForm.target = "prescriptionListPage";
	mainForm.submit();
}

function sortTableDiv(){
	<%
	if(sortType != null && !sortType.equals("")){
	%>
		var tmpHtml = "";
		<%if(sortCourse.equals("UP")){%>
			tmpHtml = "<img src=\"/PromesService/images/common/icon_07_b.gif\" width=\"7\" height=\"12\" />";
		<%}else{%>
			tmpHtml = "<img src=\"/PromesService/images/common/icon_07_a.gif\" width=\"7\" height=\"12\" />";
		<%}
		if(sortType.equals("HOSPITAL")){%>
			tableDiv[0].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[0].innerHTML = "";
		<%}
		if(sortType.equals("NAME")){%>
			tableDiv[1].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[1].innerHTML = "";
		<%}
		if(sortType.equals("STARTDATE")){%>
			tableDiv[2].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[2].innerHTML = "";
		<%}
		if(sortType.equals("DISEASE")){%>
			tableDiv[3].innerHTML = tmpHtml;
		<%}
		if(sortType.equals("STATUS")){%>
			tableDiv[4].innerHTML = tmpHtml;
		<%}%>
	<%}else{%>
		tableDiv[0].innerHTML = "";
		tableDiv[1].innerHTML = "";
		tableDiv[2].innerHTML = "";
		tableDiv[3].innerHTML = "";
// 		tableDiv[4].innerHTML = "";
	<%}%>
}

function modifyUser(userId, prescriptionId, hospital){
	
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

	var point = "width=820, height=320, top=" + y + " ,left=" + x + " scrollbars=YES , scrolling=AUTO";	
	var tmpUrl = '/PromesService/PromesServerServlet?cmd=LoadUserModifyPopupPage&_userId=' + userId + '&_prescriptionId=' +prescriptionId +'&_hospital='+hospital;	
	MM_openBrWindow(tmpUrl,'findUserPopup',point);
}

function gifview(takengifsrc){		
	var span = document.getElementById("gifview");	
	if(takengifsrc != ""){	
		span.innerHTML="<iframe id=\"takenimageView\" src=\"" + takengifsrc + "\" width=340 height=270></iframe>";
		span.style.display="inline";		
	}
}


function hidebox() {
	var span = document.getElementById("gifview");
	span.style.display="none";
}

function movebox() {
	var span = document.getElementById("gifview");
	span.style.pixelTop=event.y+document.body.scrollTop;
	span.style.pixelLeft=event.x+document.body.scrollLeft+5;	
}

function takensubmit(value1,value2, hospital, confirmday,value3,value4){		
	var mainForm = document.form;
	mainForm.cmd.value='loadTakensubmit';
	mainForm._prescriptionId.value = value1;
	mainForm._userId.value = value2;	
	mainForm._hospital.value = hospital;	
	mainForm._confirmday.value = confirmday;
	mainForm._filename.value = value3+'_'+value4;	
	mainForm.target = "TakenSubmitResultPage";	

	mainForm.submit();	
}

function refresh(){	
	parent.init();
}
//document.onmousemove=movebox;
//-->
</script>
</head>
<body onload="javascript:initsize();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/prescription/left_menu_a_.gif','/PromesService/images/prescription/left_menu_c_.gif','/PromesService/images/common/bt_inquiry_.gif','/PromesService/images/common/bt_revision2_.gif','/PromesService/images/common/bt_internal_.gif','/PromesService/images/common/bt_delete2_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_type" type="hidden" value=""/>
<input name="_pageIdx" type="hidden" value=""/>
<input name="_sortType" type="hidden" value=""/>
<input name="_sortCourse" type="hidden" value=""/>
<input name="_loginId" type="hidden" value=""/>
<input name="_boxtype" type="hidden" value=""/>
<input name="_searchDate" type="hidden" value="" />
<input name="_confirmday" type="hidden" value="" />
<input name="_filename" type="hidden" value="" />
<div id="test"></div>
<table width="756" border="0" cellpadding="1" cellspacing="1" bgcolor="#ececec">
	<tr>
		<td width="32" height="22" bgcolor="#e4eff0" class="td_table02">No.</td>
		<td width="120" bgcolor="#e4eff0" class="td_table02"><table width="120" border="0" cellspacing="0" cellpadding="0">
	  	<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('HOSPITAL');"><fmt:message key='the_health_institute_to_report' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="140" bgcolor="#e4eff0" class="td_table02"><table width="140" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('NAME');"><fmt:message key='name' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
	
		<td width="35" bgcolor="#e4eff0"><table width="35" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle"><fmt:message key='age' /></td>
			
		</tr>
		</table></td>
		<td width="35" bgcolor="#e4eff0"><table width="35" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle"><fmt:message key='gender' /></td>
			
		</tr>
		</table></td>

		<td width="120" bgcolor="#e4eff0" class="td_table02"><table width="120" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('STARTDATE');"><fmt:message key='the_beginning_date_of_registration' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="70" bgcolor="#e4eff0" class="td_table02"><table width="70" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle">&nbsp;<font color="#3c5f84"><fmt:message key='the_control_status' /></font></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
<!-- 		<td width="80" bgcolor="#e4eff0" class="td_table02" colspan="2"><table width="80" border="0" cellspacing="0" cellpadding="0"> -->
<!-- 		<tr> -->
<%-- 			<td class="td_table02" valign="middle">&nbsp;<font color="#3c5f84"><fmt:message key='medication_status_and_time' /></font></td> --%>
<!-- 			<td width="7" align="right"><div id="tableDiv"></div></td> -->
<!-- 		</tr> -->
<!-- 		</table></td> -->
		<td width="200" bgcolor="#e4eff0" class="td_table02">&nbsp;</td> 
	</tr>
	<tr>
		<td height="3" colspan="10" bgcolor="#a7c2bc"></td>
	</tr>
<%
	String tmpColot = "#FFFFFF";	
	if(prescriptionList != null){	
		
	for(int i=0; i < prescriptionList.size();i++){
		if(i % 2 == 0){
			tmpColot = "#edfaf7";
		}else{
			tmpColot = "#FFFFFF";
		}
		int todayAge= 0;
		PrescriptionInfo prescriptionInfo = (PrescriptionInfo) prescriptionList.get(i);
		if(prescriptionInfo.getAge() != null && prescriptionInfo.getAge() != "" )
		{
			String age = prescriptionInfo.getAge();
			for(int j = age.length(); j < 8; j++){
				if(j%2 == 0){
					age = age+"0";
				}else{
					age = age+"1";
				}
			}
			int byear = Integer.parseInt(age.substring(0, 4));
			int bmonth = Integer.parseInt(age.substring(4, 6));
			int bday = Integer.parseInt(age.substring(6, 8));
			
			Calendar cal = Calendar.getInstance();
			int tYear = cal.get(Calendar.YEAR);
			int tMonth = cal.get(Calendar.MONTH+1);
			int tday = cal.get(Calendar.DAY_OF_MONTH);
			
			
			if(tYear <= byear){
				todayAge = 0;
			}else{
				todayAge = tYear - byear;
				if(tMonth>bmonth || (tMonth==bmonth && tday > bday)){
					todayAge =todayAge+1;
				}
			}
		}
		
		%>
		<tr>
			<td height="22" align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=(i + 1) %></td>
			<td bgcolor='<%=tmpColot%>' class="td_table02"><%=prescriptionInfo.getHospital() %></td>
			
			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02" style="cursor:pointer;" onclick="javascript:modifyUser('<%=prescriptionInfo.getMember_id()%>','<%=prescriptionInfo.getId()%>','<%=prescriptionInfo.getHospital()%>')"><%=prescriptionInfo.getName() %></td>
<%-- 			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=prescriptionInfo.getName() %></td> --%>
			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=todayAge %></td>
			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=prescriptionInfo.getGender() %></td>
			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=prescriptionInfo.getStartDate() %></td>			
			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=prescriptionInfo.getStatus() %></td>
<%-- 			<%if(prescriptionInfo.getScheduleList().size() >0) {			 --%>
<%-- 				if(prescriptionInfo.getScheduleList().get(0).getImage().equals("")){%> --%>
<%-- 					<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"></td> --%>
<%-- 					<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"></td> --%>
<%-- 				<%}else {%> --%>
<%-- 					<td align="center" bgcolor='<%=tmpColot%>' class="td_table02" onmouseout="javascript:hidebox()" onmouseover="javascript:gifview('<%=prescriptionInfo.getScheduleList().get(0).getGifImage()%>');"><img src="<%=prescriptionInfo.getScheduleList().get(0).getImage()%>" width="9" height="9"></td>	 --%>
<%-- 					<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=prescriptionInfo.getScheduleList().get(0).getFormatTime(3) %></td> --%>
<%-- 				<%}%>				 --%>
				
<%-- 			<%}else{ %> --%>
<%-- 				<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"></td> --%>
<%-- 				<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"></td> --%>
<%-- 			<%} %> --%>
			
			
			
			<td align="center" bgcolor='<%=tmpColot%>'><table  width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
<%-- 					<%if(prescriptionInfo.getScheduleList().size() > 0){  --%>
<%-- 						if(prescriptionInfo.getScheduleList().get(0).getTakenStatus().equals("PRETAKEN")){%> --%>
<%-- 							<td align="left"><a href="javascript:takensubmit('<%=prescriptionInfo.getScheduleList().get(0).getPrescription_id() %>', '<%=prescriptionInfo.getMember_id() %>', '<%=prescriptionInfo.getScheduleList().get(0).getHospital() %>', '<%=prescriptionInfo.getScheduleList().get(0).getAlarmStart() %>', '<%=prescriptionInfo.getScheduleList().get(0).getPillboxId() %>', '<%=prescriptionInfo.getScheduleList().get(0).getAlarmStart().substring(0,8) %>');"><img src="/PromesService/images/common/bt_takensubmit.gif" width="44" height="22" border="0" id="Image5<%=i %>" onmouseover="MM_swapImage('Image5<%=i %>','','/PromesService/images/common/bt_takensubmit_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td> --%>
<%-- 						<%}else{ %> --%>
<%-- 							<td align="left"><img src="/PromesService/images/common/bt_empty.gif" width="44" height="22" border="0" id="Image5<%=i %>" /></td> --%>
<%-- 						<%} %> --%>
<%-- 					<%}else{ %> --%>
<%-- 						<td align="left"><img src="/PromesService/images/common/bt_empty.gif" width="44" height="22" border="0" id="Image5<%=i %>" /></td> --%>
<%-- 					<%} %> --%>
					<td align="center"><a href="javascript:loadDosagePage('<%=prescriptionInfo.getId()%>', '<%=prescriptionInfo.getMember_id()%>', '<%=prescriptionInfo.getHospital() %>');" class="bt_internal"></a></td>					
					<%if(prescriptionInfo.getStatusKor().equals("알림전")) { %>
						<td align="center"><a href="javascript:deletePrescription('<%=prescriptionInfo.getId()%>', '<%=prescriptionInfo.getMember_id() %>', '<%=prescriptionInfo.getStatus() %>', '<%=prescriptionInfo.getHospital() %>');"><img src="/PromesService/images/common/bt_delete2.gif" width="44" height="22" class = "PrescriptionChangeBtn"id="Image7<%=i %>" border="0" onmouseover="MM_swapImage('Image7<%=i %>','','/PromesService/images/common/bt_delete2_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
					<%}else if(prescriptionInfo.getStatusKor().equals("관리중") ){ %>
						<td align="center"><a href="javascript:deletePrescription('<%=prescriptionInfo.getId()%>', '<%=prescriptionInfo.getMember_id() %>', '<%=prescriptionInfo.getStatus() %>', '<%=prescriptionInfo.getHospital() %>');" class="bt_change"></a></td>
					<%}else if(prescriptionInfo.getStatusKor().equals("관리중단") ){ %>
						<td style="font-size: 11px"><fmt:message key='Quit_the_management_or_stop_the_management' /></td>
					<%}else if(prescriptionInfo.getStatusKor().equals("관리완료")){ %>
						<td style="font-size: 11px" ><fmt:message key='finish_the_management_or_finish_the_update' /></td>
						<!--  <td align="left"><img src="/PromesService/images/common/bt_empty.gif" width="44" height="22" class = "PrescriptionChangeBtn" id="Image7<%=i %>" border="0" onmouseover="MM_swapImage('Image7<%=i %>','','/PromesService/images/common/bt_empty.gif',1)" onmouseout="MM_swapImgRestore()" /></td>-->
					<%} %>				
				
				</tr>
			</table></td>
		</tr>
	<%}
		for(int i = prescriptionList.size(); i < 10;i++){
			if(i % 2 == 0){
				tmpColot = "#edfaf7";
			}else{
				tmpColot = "#FFFFFF";
			}%>
			<tr>
				<td height="22" align="center" bgcolor='<%=tmpColot%>' class="td_table02"></td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
<%-- 				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td> --%>
<%-- 				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td> --%>
			</tr>
		<%}
	}else{
		for(int i=0;i < 10;i++){
			if(i % 2 == 0){
				tmpColot = "#edfaf7";
			}else{
				tmpColot = "#FFFFFF";
			}
			%>
			<tr>
				<td height="22" align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=(i+1)%></td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
<%-- 				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td> --%>
<%-- 				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td> --%>
			</tr>
	<%}}%>
</table>
<table width="756" border="0">
	<tr>
		<td height="23" align="center" bgcolor="#FFFFFF"><table width="735" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center"><table border="0" cellspacing="0" cellpadding="0">
					<%
					if(pageIdx == null){
						pageIdx = "0";
						maxPageIdx = "0";
					}
					if(Integer.parseInt(pageIdx) == 1){ %>
						<td align="center"><img src="/PromesService/images/common/icon_04.gif" width="10" height="9" /></td>
					<%}else{ %>
						<td align="center"><a href="javascript:changePage('','sub');"><img src="/PromesService/images/common/icon_04.gif" border="0" width="10" height="9" /></a></td>
					<%} %>
					<td width="5">
					</td>
				<%for(int i = 0;i < Integer.parseInt(maxPageIdx);i++){
					if(pageIdx.equals(""+(i+1))){%>
						<td align="center" valign="bottom" width="15" class="td_table11">
						<font class="#3c5f84"><%=(i+1)%></font>
					<%}else{%>
						<td align="center" valign="bottom"  width="10" class="td_table11_">
						<a href="javascript:changePage('<%=(i+1)%>');"><font color="#3c5f84"><%=(i+1)%></font></a>
					<%}%>
					</td>
					<td width="5">
					</td>
				<%}%>
					<%if(Integer.parseInt(maxPageIdx) == Integer.parseInt(pageIdx)){ %>
						<td align="center"><img src="/PromesService/images/common/icon_05.gif" width="10" height="9" /></td>
					<%}else{ %>
						<td align="center"><a href="javascript:changePage('','add');"><img src="/PromesService/images/common/icon_05.gif" border="0" width="10" height="9" /></a></td>
					<%} %>
					
				</table>
				</td>
			</tr>
		</table></td>
	</tr>
</table>
<div id ="TakenSubmitdiv" class="view" style="top: 100px; left: 530px; display: none;  width: 200px; height: 120px" >
<table>
<tr>
<td colspan="2" align="left">
<input type="radio" name = "takenRDObtn"class = "takenRDObtnList" value="FINISH"><fmt:message key='finish_the_management_or_finish_the_update' /><br>
<input type="radio" name = "takenRDObtn"class = "takenRDObtnList" value="STOP"><fmt:message key='Quit_the_management_or_stop_the_management' /><br>
<input type="radio" name = "takenRDObtn"class = "takenRDObtnList" value="CHANGE" disabled="disabled"><fmt:message key='edit_the_management' /><br>
</td>
</tr>
<tr>
<td align="center" ><img src="/PromesService/images/common/bt_ok.gif" border="0" id = "Image001"onmouseover="MM_swapImage('Image001','','/PromesService/images/common/bt_ok_.gif',1)" onmouseout="MM_swapImgRestore()" /></td>
<td align="center" ><img src="/PromesService/images/common/bt_colse.gif" border="0" id = "Image002"onmouseover="MM_swapImage('Image002','','/PromesService/images/common/bt_colse_.gif',1)" onmouseout="MM_swapImgRestore()" /></td>
</tr>
</table>
</div>
<iframe name="TakenSubmitResultPage" id="TakenSubmitResultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0" style="display: none;"></iframe>
<span id="gifview" class="view" style="top: 40px; left: 150px;"></span>
</form>
</body>
</html>