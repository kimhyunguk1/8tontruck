<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%PrescriptionInfo prescriptionInfo = (PrescriptionInfo) request.getAttribute("prescriptionInfo");%>
<%UserInfo userInfo = (UserInfo) request.getAttribute("userInfo");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Detail Schedule</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css" media="print">
 .noprint { display:none; }
</style>
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

function initsize() {
	//dosageInfoPage.resizeTo(dosageInfoPage.document.body.scrollWidth, dosageInfoPage.document.body.scrollHeight);
	var _height = document.getElementById('dosageInfoPage').contentWindow.document.body.scrollHeight;
    document.getElementById('dosageInfoPage').height=_height;
	parent.initsize();
}

function init(){
	<%if(prescriptionInfo != null){
		if(prescriptionInfo.getDetailSchedule().equals("0")){%>
			alert("<fmt:message key="the_schedule_in_detail_haven't_yet_registered." />");
		<%}%>
		setPrescription('<%=prescriptionInfo.getId()%>', '<%=prescriptionInfo.getMember_id()%>', '<%=userInfo.getName()%>', '<%=prescriptionInfo.getTotalDays()%>', '<%=prescriptionInfo.getFrequency()%>', '<%=prescriptionInfo.getPillBox_id()%>', '<%=prescriptionInfo.getDisease()%>', '<%=prescriptionInfo.getHospital()%>');
	<%}%>
}

function setPrescription(prescriptionId, userId, userName, totalDays, frequency, pillBoxId, disease, hospital){
	var mainForm = document.form;
	mainForm._prescriptionId.value = prescriptionId;
	mainForm._userId.value = userId;
	mainForm._hospital.value = hospital;
	//mainForm._userName.value = userName;
	//mainForm._totalDays.value = totalDays;
	//mainForm._frequency.value = frequency;
	//mainForm._pillBoxId.value = pillBoxId;
	//mainForm._disease.value = disease;
	mainForm.cmd.value = 'loadDetailSchedulePage';
	mainForm.target = "dosageInfoPage";
	mainForm.submit();
}

function loadSearch(){
	parent.changeMenu('list');
}

function getPrescriptionId(){
	<%if(prescriptionInfo != null){%>
		return '<%=prescriptionInfo.getId()%>'
	<%}%>
	return "";
}

function getUserId(){
	<%if(userInfo != null){%>
		return '<%=userInfo.getId()%>'
	<%}%>
	return "";
}

function getHospital(){
	<%if(prescriptionInfo != null){%>
		return '<%=prescriptionInfo.getHospital()%>'
	<%}%>
	return "";
}

function getType(){
	return parent.getType();	
}

function changeDosage(value){
	var tmpHtml = "";
	if(value == '1'){
		var url = '/PromesService/PromesServerServlet';
		url += '?cmd=loadDetailSchedulePage';
		url += '&_prescriptionId=' + '<%=prescriptionInfo.getId()%>';
		url += '&_userId=' + '<%=prescriptionInfo.getMember_id()%>';
		url += '&_hospital=' + '<%=prescriptionInfo.getHospital()%>';
		tmpHtml = "<iframe name=\"dosageInfoPage\" id=\"dosageInfoPage\" src=\"" + url + "\" frameborder=\"0\" scrolling=\"NO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		saveDiv.innerHTML = "";
	}else if(value == '2'){
		var url = '/PromesService/PromesServerServlet';
		url += '?cmd=loadChartPage';
		url += '&_prescriptionId=' + '<%=prescriptionInfo.getId()%>';
		url += '&_userId=' + '<%=prescriptionInfo.getMember_id()%>';
		url += '&_hospital=' + '<%=prescriptionInfo.getHospital()%>';
		url += '&_type=' + parent.getType();
		tmpHtml = "<iframe name=\"dosageInfoPage\" id=\"dosageInfoPage\" src=\"" + url + "\" frameborder=\"0\" scrolling=\"NO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		saveDiv.innerHTML = "";
	}else if(value == '3'){
		var url = '/PromesService/home/common/dosageReport.jsp';
		tmpHtml = "<iframe name=\"dosageInfoPage\" id=\"dosageInfoPage\" src=\"" + url + "\" frameborder=\"0\" scrolling=\"NO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		saveDiv.innerHTML = "<td width=\"74\" valign=\"bottom\"><a href=\"javascript:saveReport();\"><img src=\"/PromesService/images/common/bt_save.gif\" width=\"74\" height=\"22\" id=\"Image44\" border=\"0\" onmouseover=\"MM_swapImage('Image44','','/PromesService/images/common/bt_save_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	}
	dosageDiv.innerHTML = tmpHtml;
}

function saveReport(){
	var mainForm = document.form;
	mainForm._prescriptionId.value = '<%=prescriptionInfo.getId()%>';
	mainForm._userId.value = '<%=prescriptionInfo.getMember_id()%>';
	mainForm._hospital.value = '<%=prescriptionInfo.getHospital()%>';

	mainForm.cmd.value = 'saveReportPage';
	mainForm.submit();
}

function detailTimePopup(day, value, times){
	var mainForm = document.form;
	var tmpDate = "";
	if(day < 10){
		tmpDate = mainForm._year.value + "-" + mainForm._month.value + "-0" + day + "";
	}else{
		tmpDate = mainForm._year.value + "-" + mainForm._month.value + "-" + day + "";
	}
	var x = 0; 
	var	y = 0;
	var w = 442;
	var h = 126;
	h = h + (26 * value);
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
	var point = "width=442, height=" + h + ", top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	var url = '/PromesService/home/common/dosageCalendarPrint.jsp';
	url += '?prescriptionId=' + parent.getPrescriptionId();
	url += '&userId=' + parent.getUserId();
	url += '&hospital=' + parent.getHospital();
	url += '&type=' + parent.getType();
	url += '&day=' + tmpDate;
	url += '&frequency=' + value;
	url += '&timeStr=' + times;
	MM_openBrWindow(url,'detailDosagePopup',point);
}
function setMonthlyTaken(Totalday , Takenday){
	alert(Toralday + "    " + Takenday);
}

//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/common/bt_inquiry2_.gif','/PromesService/images/common/bt_graph_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="/PromesService/images/prescription/main_title_c.gif" width="794" height="35" /></td>
	</tr>
<!--    <tr class="noprint"> -->
<!--       <td background="/PromesService/images/prescription/main_title_c.gif" width ="780" height="35"> -->
<!--       <table width="790" border="0" cellspacing="0" cellpadding="0"> -->
<!--         <tr> -->
<!--           <td height="35"> -->
<!--           <table width="100%" border="0" cellspacing="0" cellpadding="0"> -->
<!--             <tr> -->
<!--               <td width="150" align="right">&nbsp;</td> -->
<!--               <td width="20"><input type="radio" name="_dosageType" id="_dosageType" value="일별정보" checked="checked" onclick="javascript:changeDosage('1');" /></td> -->
<!--               <td width="80">일별정보</td> -->
<!--               <td width="20"><input type="radio" name="_dosageType" id="_dosageType" value="순응률" onclick="javascript:changeDosage('2');" /></td> -->
<!--               <td width="80">순응률</td> -->
<!--               <td width="20"><input type="radio" name="_dosageType" id="_dosageType" value="보고서 출력" onclick="javascript:changeDosage('3');" /></td> -->
<!--               <td>보고서 출력</td> -->
<!--               </tr> -->
<!--           </table> -->
<!--           </td> -->
<!--         </tr> -->
<!--       </table> -->
<!--       </td> -->
<!--    </tr> -->
   <tr>
      <td><table width="756" border="0" cellspacing="" cellpadding="0">
	   <tr>
		  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>

					<td width="4" valign="middle"><img src="/PromesService/images/common/icon_08.gif" width="4" height="7" id="Image4" border="0" onmouseover="MM_swapImage('Image9','','/PromesService/images/common/bt_list_.gif',1)"/></td>
					<td width="131" class="td_table08" >&nbsp;<fmt:message key='patient_name' /> : </td>
					<td><%=userInfo.getName() %></td>
					<td width="4" valign="middle"><img src="/PromesService/images/common/icon_08.gif" width="4" height="7" id="Image4" border="0" onmouseover="MM_swapImage('Image9','','/PromesService/images/common/bt_list_.gif',1)"/></td>
					<td width="206" class="td_table08" >&nbsp;<fmt:message key='the_beginning_date_of_medication' /> : </td>
					<td><%=prescriptionInfo.getStartDate() %></td>
<!-- 					<td width="4" valign="middle"><img src="/PromesService/images/common/icon_08.gif" width="4" height="7" id="Image4" border="0" onmouseover="MM_swapImage('Image9','','/PromesService/images/common/bt_list_.gif',1)"/></td> -->
<%-- 					<td width=200 class="td_table08 MonthlyTakenCnt" valign="bottom">&nbsp;복용횟수 : <%=prescriptionInfo.getFrequency() %>회/일</td> --%>
					<td class="noprint"><input type="button" value="<fmt:message key='print' />" onclick="javascript:window.print();"></td>
					<td>&nbsp;</td>
				</tr>
				</table></td>	
			</tr>
		 </table></td>
	   </tr>
	   <tr>
			<td height="15">&nbsp;</td>
	   </tr>
	   <tr>
		  <td>
		  	<div id="dosageDiv">
		   	  <iframe name="dosageInfoPage" id="dosageInfoPage" src="/PromesService/PromesServerServlet?cmd=loadDetailSchedulePage" frameborder="0" scrolling="NO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
			</div>
		  </td>
	   </tr>
	   <tr>
	     <td height="15" ></td>
	   </tr>
	   <tr class="noprint">
	   	 <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td>&nbsp;</td>
	          <td width="74" valign="bottom"><div id="saveDiv"></div></td>
	          <td width="5">&nbsp;</td>
	          <td width="74" valign="bottom"><a href="javascript:loadSearch();"><img src="/PromesService/images/common/bt_list.gif" width="74" height="22" id="Image4" border="0" onmouseover="MM_swapImage('Image4','','/PromesService/images/common/bt_list_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
	        </tr>
	     </table></td>
	   </tr>
	   <tr>
	     <td height="50">&nbsp;</td>
	   </tr>
	</table></td>
   </tr>
</table></td>
 </form>
</body>
</html>
