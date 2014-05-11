<%@page import="kr.re.etri.lifeinfomatics.promes.data.TakenOrderProperty"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo"%>
<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.Define"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%UserInfo userInfo = (UserInfo)request.getAttribute("userInfo"); %>
<%PrescriptionInfo prescriptionInfo = (PrescriptionInfo)request.getAttribute("prescriptionInfo"); %>
<%PillBoxInfo pillBoxInfo = (PillBoxInfo)request.getAttribute("pillBoxInfo"); %>
<%String msg = (String)request.getAttribute("msg"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 User Modify</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"src="http://code.jquery.com/jquery-latest.min.js"></script>
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
	//userInfoPage.resizeTo(userInfoPage.document.body.scrollWidth, userInfoPage.document.body.scrollHeight);
	var _height = document.getElementById('userInfoPage').contentWindow.document.body.scrollHeight;
    document.getElementById('userInfoPage').height=_height;
	//parent.initsize();
}





function init(){
	var tmpHtml = "";
	<%
	if(userInfo != null){
		session.setAttribute("userInfo",userInfo);
 		if(userInfo.getType().equals(Define.USER_PATIENT)){%>			 
			tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/home/management/modifyUser_patient.jsp\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		<%}else if(userInfo.getType().equals(Define.USER_DOCTOR)){%>
			tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/home/management/addUser_doctor.jsp\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";	
		<%}else {%>
			tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/PromesServerServlet?cmd=addUserPharmacist\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		<%}%>
		parent.changeMenu("Membermodify");
		addUserInfoDiv.innerHTML = tmpHtml;
	<%}
	if(msg != null && !msg.equals("")){
 	%> 
		alert('<%=msg%>');
	<%}%>	
}

function changeMail(){
  var mainForm = document.form;
  if(mainForm._email3.value != '직접입력'){
  	mainForm._email2.value = mainForm._email3.value;
  }else{
  	mainForm._email2.value = "";
  }
}

function modifyUser(){	
	if(fieldCheck()){
		var mainForm = document.form;
		var tmpTime = mainForm._inputTime.value;
		var tmpTimeArr = tmpTime.split(' ~ ');		
		mainForm._takenOrderProperties.value = "[1/1/" + tmpTimeArr[0].replace(':', '') + "/" + tmpTimeArr[1].replace(':', '') + "]";
		mainForm._startTakenOrder.value = "<%=prescriptionInfo.getStartTakenOrder()%>";		         
		mainForm._endTakenOrder.value = "<%=prescriptionInfo.getEndTakenOrder()%>";		
		mainForm.cmd.value = "modifyUserAndPrescription";
		var tmpType = mainForm._type.value;
		if(tmpType == "PATIENT"){
			mainForm._protectors.value = userInfoPage.getProtectors();
			if(!userInfoPage.checkTime()){
				return;
			}
// 			mainForm._timeList.value = userInfoPage.getTimeList();
// 			mainForm._timeList.value = userInfoPage.getTimeList();
			console.log(userInfoPage.getPillbox());
			mainForm._pillBoxs.value = userInfoPage.getPillbox();
			mainForm._receiptSMS.value = mainForm._sms.checked;
		}else{
			mainForm._company.value = userInfoPage.getCompany();
			mainForm._companyPh.value = userInfoPage.getPh();
			mainForm._addr.value = userInfoPage.getAddr();
			mainForm._receiptSMS.value = false;
		}
		mainForm.target = "modifyResultPage";
		mainForm.submit();		
	}
}

function fieldCheck(){
	var mainForm = document.form;
	if(mainForm._pw.value == null || mainForm._pw.value == ""){
		alert("비밀번호를 입력 하세요.");
		return false;
	}else if(mainForm._repw.value == null || mainForm._repw.value == ""){
		alert("비밀번호 확인을  입력 하세요.");
		return false;
	}else if(mainForm._pw.value != mainForm._repw.value){
		alert("비밀번호와 비밀번호 확인이 틀립니다.");
		return false;
	}else if(mainForm._pw.value == mainForm._id.value){
		alert("아이디와 동일한 비밀번호는 사용 할 수 없습니다.");
		return false;	
	}else if(!pwdCheck()){
		return false;
	}else if(mainForm._email1.value == null || mainForm._email1.value == ""){
		alert("이메일을 확인 하세요.");
		return false;
	}else if(mainForm._email2.value == null || mainForm._email2.value == ""){
		alert("이메일을 확인 하세요.");
		return false;
	}else if(!emailCheck()){
		return false;
	}else if(mainForm._hp2.value == null || mainForm._hp2.value == ""){
		alert("전화 번호를 확인 하세요.");
		return false;
	}
// 	else if(mainForm._hp3.value == null || mainForm._hp3.value == ""){
// 		alert("전화 번호를 확인 하세요.");
// 		return false;
// 	}
	if(!phoneCheck()){
		return false;
	}else{
		return true;
	}
}

function pwdCheck(){
	var mainForm = document.form;
	var chkNum = 0;
	var chkEng = 0;
	var pwd1=mainForm._pw.value;
	if(pwd1.length<3 || pwd1.length>8){
		alert("비밀번호는 3글자이상, 8글자 이하여야 합니다.");
		return false;
	}
	for(i=0;i<pwd1.length;i++){
		if(pwd1.charAt(i)>='0' && pwd1.charAt(i)<='9'){
			chkNum++;	
		}
		else if(pwd1.charAt(i)>='a' && pwd1.charAt(i)<='z'){
			chkEng++;
		}
	}
	if(pwd1.length!=(chkNum+chkEng) || chkEng == 0){
		alert("비밀번호는 영문과 숫자의 조합으로 입력하세요.");
		return false;
	}
	return true;
}

function phoneCheck(){
// 	var mainForm = document.form;
// 	var tmpHp1 = mainForm._hp2.value;
// 	var tmpHp2 = mainForm._hp3.value;
// 	var chkNum = 0;
// 	var chkEng = 0;
	
// 	for(var i=0;i<tmpHp1.length;i++){
// 		if(tmpHp1.charAt(i)>='0' && tmpHp1.charAt(i)<='9'){
// 			chkNum++;	
// 		}
// 		else if(tmpHp1.charAt(i)>='a' && tmpHp1.charAt(i)<='z'){
// 			chkEng++;
// 		}
// 	}
// 	if(tmpHp1.length!=(chkNum+chkEng) || chkEng != 0 || tmpHp1.length < 3 || tmpHp1.length > 4){
// 		alert("휴대폰의 앞자리는 3~4자리 숫자로 이루어져야 합니다.");
// 		return false;
// 	}
// 	chkNum = 0;
// 	chkEng = 0;
// 	for(i=0;i<tmpHp2.length;i++){
// 		if(tmpHp2.charAt(i)>='0' && tmpHp2.charAt(i)<='9'){
// 			chkNum++;	
// 		}
// 		else if(tmpHp2.charAt(i)>='a' && tmpHp2.charAt(i)<='z'){
// 			chkEng++;
// 		}
// 	}
// 	if(tmpHp2.length!=(chkNum+chkEng) || chkEng != 0 || tmpHp2.length != 4){
// 		alert("휴대폰의 뒷자리는 4자리 숫자로 이루어져야 합니다.");
// 		return false;
// 	}
	return true;
}

function numberText(){
	if((event.keyCode < 48) || (event.keyCode > 57))
  	event.returnValue = false;
}

function emailCheck(){
	var mainForm = document.form;
	var tmpEmail1 = mainForm._email1.value;
	var tmpEmail2 = mainForm._email2.value;
	var tmpEmail = tmpEmail1 + "@" + tmpEmail2;
	tmpEmail = tmpEmail.toLowerCase();

	var re=/^[0-9a-zA-Z-_\.]*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 

	if(!re.test(tmpEmail)) { 
		alert("이메일을 확인 하세요.");
		return false;
	}
	return true;
}

function takenTimeChange(){
	var mainForm = document.form;
	var startTime = mainForm._startAlarm1.value * 60 + Number(mainForm._startAlarm2.value);
	var stopTime = mainForm._stopAlarm1.value * 60 + Number(mainForm._stopAlarm2.value);	
	if(Number(startTime) >= Number(stopTime)){
		alert("beginning time of medication per day is in advance to beginning time of medication.");
		mainForm._startAlarm1.value=selectBoxValue[0];
		mainForm._startAlarm2.value=selectBoxValue[1];
		mainForm._stopAlarm1.value=selectBoxValue[2];
		mainForm._stopAlarm2.value=selectBoxValue[3];
		return;
	}
	mainForm._inputTime.value = mainForm._startAlarm1.value + ":" + mainForm._startAlarm2.value + " ~ "+ mainForm._stopAlarm1.value + ":" + mainForm._stopAlarm2.value;	
}

$(document).ready(function(){	
	$('#_inputTime').val($("#_startAlarm1 option:selected").text() + ":" + $("#_startAlarm2 option:selected").text()+ " ~ " + $("#_stopAlarm1 option:selected").text() + ":" + $("#_stopAlarm2 option:selected").text());
});

var selectBoxValue = new Array(4);
function saveValue(){
	
	var mainForm = document.form;
	selectBoxValue[0] = mainForm._startAlarm1.value;
	selectBoxValue[1] = mainForm._startAlarm2.value;
	selectBoxValue[2] = mainForm._stopAlarm1.value;
	selectBoxValue[3] = mainForm._stopAlarm2.value;
}

//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/common/bt_initialize_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/common/bt_id_.gif','/PromesService/images/common/bt_X_.gif','/PromesService/images/common/bt_add2_.gif','/PromesService/images/common/bt_registration_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_protectors" type="hidden" value=""/>
<input name="_timeList" type="hidden" value=""/>
<input name="_pillBoxs" type="hidden" value=""/>
<input name="_company" type="hidden" value=""/>
<input name="_companyPh" type="hidden" value=""/>
<input name="_addr" type="hidden" value=""/>
<input name="_receiptSMS" type="hidden" value=""/>
<input name="_startTakenOrder"	type="hidden" value="" />
<input name="_endTakenOrder"	type="hidden" value="" />
<input name="_takenOrderProperties"	type="hidden" value="" />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<!--   <tr> -->
<!--     <td><img src="/PromesService/images/management/main_title_d.gif" width="794" height="35" /></td> -->
<!--   </tr> -->
<!--   <tr> -->
<!--     <td height="15">&nbsp;</td> -->
<!--   </tr> -->
  <tr>
    <td><table width="756" border="0" cellspacing="0" cellpadding="0">
      <tr style="display: none ">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="3" bgcolor="#a7c2bc"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">구분</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                      	<%String type = "";
                      	if(userInfo != null){
                      		if(userInfo.getType().equals(Define.USER_PHARMACIST)){
                      			type="간호사";
                      		}else if(userInfo.getType().equals(Define.USER_DOCTOR)){
                      			type="의사";
                      		}else{
                      			type="환자";
                      		}
                      	}%>
                       <!-- <td width="20" align="left"><input name="_type" type="radio" id="_type"  value="<%=userInfo.getType() %>" checked="checked" /></td>-->
                        <td width="4" align="left">&nbsp;<input name="_type" type="hidden" id="_type"  value="<%=userInfo.getType() %>" checked="checked" /></td>
                        <td width="45" align="center"><%=type %></td>
                        <td>&nbsp;</td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">이름</td>
                  <td><input name="_name" type="hidden" id="_name" readonly="true" value="<% if(userInfo != null){%><%=userInfo.getName() %><%} %>" />&nbsp;&nbsp;<% if(userInfo != null){%><%=userInfo.getName() %><%}%></td>
                  <td width="60" height="25" bgcolor="#e1eeef" class="td_table02">&nbsp;&nbsp;생년</td>
                  <td><input name="_age" type="hidden"  id="_age" value="<% if(userInfo != null){%><%=userInfo.getAge() %><%} %>"/>&nbsp;&nbsp;<% if(userInfo != null){%><%=userInfo.getAge() %><%} %></td>
                  <td width="60" height="25" bgcolor="#e1eeef" class="td_table02">&nbsp;&nbsp;성별</td>
                  <td><input name="_gender" type="hidden"  id="_gender" value="<% if(userInfo != null){%><%=userInfo.getGender() %><%} %>"/>&nbsp;&nbsp;<% if(userInfo != null){%><%=userInfo.getGender() %><%} %></td>
                  
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">아이디</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="176"><input name="_id" type="hidden" id="_id" readonly="true" value="<% if(userInfo != null){%><%=userInfo.getId() %><%} %>" />&nbsp;&nbsp;<% if(userInfo != null){%><%=userInfo.getId() %><%} %></td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">비밀번호</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="180">&nbsp;
                            <input name="_pw" type="password" class="inputbox" size="25" id="_pw" value="<% if(userInfo != null){%><%=userInfo.getPw() %><%} %>" style="  text-transform:lowercase" /></td>
                        <td class="td_table03">(비밀번호는 3~8자 문자와 숫자를 조합하여 만들어 주세요)</td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">비밀번호 확인</td>
                  <td>&nbsp;
                      <input name="_repw" type="password" class="inputbox" size="25" id="_repw" value="<% if(userInfo != null){%><%=userInfo.getPw() %><%} %>" style="  text-transform:lowercase" /></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">이메일</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="167">&nbsp;
                        <%
                        	String[] e_mailArr = userInfo.getE_mailArr();
							if(e_mailArr.length != 2){
								e_mailArr = new String[]{"",""};
							}
                        %>
                            <input name="_email1" type="text" class="inputbox" size="25" id="_email1" value="<%=Util.toWebString(e_mailArr[0]) %>" style="  text-transform:lowercase" /></td>
                        <td width="30" align="center" >@</td>
                        <td width="135" align="left" ><input name="_email2" type="text" class="inputbox" size="20" id="_email2" value="<%=Util.toWebString(e_mailArr[1])%>" style="  text-transform:lowercase"/></td>
                        <td ><select name="_email3" class="select_white" style="width:120px" id="_email3" onchange="javascript:changeMail();">
                        	<option selected="true" value="직접입력" >직접입력</option>
<%--                         	<option <%if(e_mailArr[1].equals("empas.com")){ %> selected="true" <%} %> value="empas.com" >empas</option> --%>
<%--                         	<option <%if(e_mailArr[1].equals("google.co.kr")){ %> selected="true" <%} %> value="google.co.kr" >google</option> --%>
<%--                         	<option <%if(e_mailArr[1].equals("naver.com")){ %> selected="true" <%} %> value="naver.com" >naver</option> --%>
<%--                         	<option <%if(e_mailArr[1].equals("nate.com")){ %> selected="true" <%} %> value="nate.com" >nate</option> --%>
<%--                         	<option <%if(e_mailArr[1].equals("yahoo.co.kr")){ %> selected="true" <%} %> value="yahoo.co.kr" >yahoo</option> --%>
                        </select></td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">휴대폰 번호</td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
<!--                       <td width="60">&nbsp; -->
<%--                       <%String[] hpArr = userInfo.getHpArr();%> --%>
<!--                           <select name="_hp1" class="select_white" style="width:50px" id="_hp1"> -->
<!--                             <option selected="true" value="010">010</option> -->
<%--                             <option <%if(hpArr[0].equals("011")){ %> selected="true"<%} %> >011</option> --%>
<%--                             <option <%if(hpArr[0].equals("016")){ %> selected="true"<%} %> >016</option> --%>
<%--                             <option <%if(hpArr[0].equals("017")){ %> selected="true"<%} %> >017</option> --%>
<!--                         </select></td> -->
<!--                       <td width="25" align="center" >-</td> -->
                      <td width="175" >&nbsp;&nbsp;<input name="_hp2" type="text" class="inputbox" size="25" id="_hp2" value="${userInfo.hp }"   onkeypress="javascript:numberText();" /></td>
<!--                       <td width="25" align="center" >-</td> -->
<%--                       <td width="90" ><input name="_hp3" type="text" class="inputbox" size="12" id="_hp3" value="<%=hpArr[2] %>"   onkeypress="javascript:numberText();"/></td> --%>
                      <td class="inputbox" >
                      <% if(userInfo.getType().equals(Define.USER_PATIENT)){%>
                      <input type="checkbox" name="_sms" id="_sms" <%if(userInfo.isSms()){ %> checked="true" <%} %> />
                        복용알람 SMS 수신<%}else{ %>&nbsp;<%} %></td>
                      <td >&nbsp;</td>
                    </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
          	<td>
				<div id="addUserInfoDiv">
	            	<iframe name="userInfoPage" id="userInfoPage" src="/PromesService/home/management/modifyUser_patient.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
	            </div>
          	</td>
          </tr>
        </table></td>
      </tr>
      <tr style="display: block;">
      <td>
      <table>
	<tr>
		<td><img src="/PromesService/images/pharmacist/main_title_e.gif" width="794" height="35" /></td>
	</tr>
	<tr>
		<td>
		<table width="756" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
								
					<tr>
						<td height="1" bgcolor="#ececec"></td>
					</tr>
					<tr style="display:none;">
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">교부번호</td>
								<td width="281">&nbsp; <input name="_prescriptionId" type="text" class="inputbox" size="42" id="_prescriptionId" value="<% if(prescriptionInfo != null){%><%=prescriptionInfo.getId()%><%}%>" readonly="true" /></td>
								<td width="96" bgcolor="#ddebec" class="td_table02">처방병원</td>
								<td>&nbsp; <input name="_hospital" type="text" class="inputbox" size="42" id="_hospital" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getHospital()%>" <%}%> readonly="true" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr style="display: none;">
						<td>
						<table width="756%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">환자이름</td>
								<td width="281">&nbsp; <input name="_userName" type="text" class="inputbox" size="42" id="_userName" readonly="true" <%if(userInfo != null){ %> value="<%=userInfo.getName() %>" <%}%> /></td>
								<td width="96" bgcolor="#ddebec" class="td_table02">환자 ID</td>
								<td>&nbsp; <input name="_userId" type="text" class="inputbox" size="42" id="_userId" readonly="true" <%if(userInfo != null){ %> value="<%=userInfo.getId() %>" <%} %> /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr style="display: none;">
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">약상자</td>
								<td width="281">
								<table width="281%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="245">&nbsp; <input name="_pillBoxId" type="text" class="inputbox" size="37" id="_pillBoxId" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getPillBox_id()%>" <%} %> readonly="true" /></td>
										<%if(prescriptionInfo != null){
											if(prescriptionInfo.checkChange()){
										%>
											<td><a href="javascript:openPillBoxList();"><img src="/PromesService/images/common/icon_search.gif" width="25" height="25" border="0" /></a></td>																				
										<%	}else{%>
											<td><img src="/PromesService/images/common/icon_search.gif" width="25" height="25" border="0" /></td>	
										<%	}
										}else{%>
											<td><a href="javascript:openPillBoxList();"><img src="/PromesService/images/common/icon_search.gif" width="25" height="25" border="0" /></a></td>
										<%}%>
										
									</tr>
								</table>
								</td>
								<td width="96" bgcolor="#ddebec" class="td_table02">형태</td>
								<td>&nbsp; <input name="_pillBoxType" type="text" class="inputbox" size="42" id="_pillBoxType" readonly="true" <%if(pillBoxInfo != null){ %> value="<%=pillBoxInfo.getType() %>" <%} %> readonly="true" /></td>
							</tr>
						</table>
						</td>
					</tr>
					
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02"><fmt:message key='the_duration_of_medication'/></td>
								<td width="281">
								<table width="281" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="245">&nbsp; <input name="_totalDays" type="text" class="inputbox" size="37" id="_totalDays" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getTotalDays()%>" <%} if(prescriptionInfo != null){if(!prescriptionInfo.checkChange()){%> readonly="true" <%}else{%>onchange="javascript:changeTotalDays();" onkeydown="javascript:if(event.keyCode==13 || window.event.keyCode ==9){changeTotalDays();}" <%}}else{%>onchange="javascript:changeTotalDays();" onkeydown="javascript:if(event.keyCode==13 || window.event.keyCode ==9){changeTotalDays();}"<%}%> /></td>
										
									</tr>
								</table>
								</td>
								<td width="96" bgcolor="#ddebec" class="td_table02"><fmt:message key='the_frequency_of_medication'/></td>
								<td>&nbsp;<input type="hidden" id ="_frequency" name ="_frequency" value="<%=prescriptionInfo.getFrequency()%>"><%=prescriptionInfo.getFrequency()%> </td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="1" bgcolor="#ececec"></td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="38" bgcolor="#ddebec" class="td_table02"><fmt:message key='disease_name'/></td>
								<td>&nbsp; <textarea name="_disease" cols="103" class="select_white" id="_disease" <%if (prescriptionInfo != null && prescriptionInfo.getStatus().equals(Define.PRESCRIPTION_SATUS_FINISH)) {%>readonly="true"<%}%> onkeydown="javascript:checkDisease();"><%if (prescriptionInfo != null) { %><%=prescriptionInfo.getDisease().trim()%><%}%>
								</textarea></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="1" bgcolor="#ececec"></td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="38" bgcolor="#ddebec" class="td_table02"><fmt:message key='notice'/></td>
								<td>&nbsp; <textarea name="_direction" cols="103" class="select_white" id="_direction" <%if (prescriptionInfo != null && prescriptionInfo.getStatus().equals(Define.PRESCRIPTION_SATUS_FINISH)) {%>readonly="true"<%}%> onkeydown="javascript:checkDirection();"><%if (prescriptionInfo != null) {%><%=prescriptionInfo.getDirection().trim()%><%}%>
								</textarea></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="1" bgcolor="#ececec"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="15">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<div id="prescriptionTimeTableDiv">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#ececec">
					<tr>
						<td width="40" height="22" bgcolor="#e4eff0" class="td_table02">No.</td>						
						<td width="90" bgcolor="#e4eff0" class="td_table02"><fmt:message key='period'/></td>
						<td width="160" bgcolor="#e4eff0" class="td_table02"><fmt:message key='the_beginning_time'/></td>
						<td width="160" bgcolor="#e4eff0" class="td_table02"><fmt:message key='the_end_time'/></td>
						<td bgcolor="#e4eff0" class="td_table02"><fmt:message key='the_applied_time'/></td>
					</tr>

					<tr>
						<td height="22" align="center" bgcolor="#FFFFFF">1</td>
						<td style="display:none;" align="center" bgcolor="#FFFFFF"><select name="_containerSelect" id="containerSelect" class="select_white" style="width: 50px">
							<option selected="selected"></option>
						</select></td>
						<td align="center" bgcolor="#FFFFFF"><fmt:message key='direct_input'/></td>
						<td align="center" bgcolor="#FFFFFF">
						<div id="startAlarmDiv"><select name="_startAlarm1" id="_startAlarm1" class="select_white" style="width: 50px" onclick="javascript:saveValue();" onchange="javascript:takenTimeChange();">
						<%					
						String takentime_start = prescriptionInfo.getTakenOrderPropertyList().get(0).getStartTime();
						String takentime_stop = prescriptionInfo.getTakenOrderPropertyList().get(0).getEndTime();
						for(int i=0; i<24; i++){
							String selected="";
							String idx = "";
							if(i<10)
								idx="0";
							idx += Integer.toString(i);
							if(takentime_start.substring(0, 2).equals(idx))
								selected="selected";
						%>
							<option value="<%=idx %>"<%=selected%>><%=idx %></option>
						<%} %>						
						</select>&nbsp;:&nbsp;
						<select name="_startAlarm2" id="_startAlarm2" class="select_white" style="width: 50px"onclick="javascript:saveValue();" onchange="javascript:takenTimeChange();">
						<%for(int i=0; i<=59; i+=10) {
							String selected="";
							String idx = "";
							if(i<10)
								idx="0";
							idx += Integer.toString(i);
							if(takentime_start.substring(2).equals(idx))
								selected="selected";						
						%>
							<option value="<%=idx %>"<%=selected%>><%=idx %></option>
						<%} %>
						</select>
						</div>
						</td>
						<td align="center" bgcolor="#FFFFFF">
						<div id="stopAlarmDiv"><select name="_stopAlarm1" id="_stopAlarm1" class="select_white" style="width: 50px"onclick="javascript:saveValue();" onchange="javascript:takenTimeChange();">
						<%for(int i=0; i<24; i++){
							String selected="";
							String idx = "";
							if(i<10)
								idx="0";
							idx += Integer.toString(i);
							if(takentime_stop.substring(0, 2).equals(idx))
								selected="selected";
						%>
							<option value="<%=idx %>"<%=selected%>><%=idx %></option>
						<%} %>						
						</select>&nbsp;:&nbsp;
						<select name="_stopAlarm2" id="_stopAlarm2" class="select_white" style="width: 50px"onclick="javascript:saveValue();" onchange="javascript:takenTimeChange();">
						<%for(int i=0; i<=59; i+=10) {
							String selected="";
							String idx = "";
							if(i<10)
								idx="0";
							idx += Integer.toString(i);
							if(takentime_stop.substring(2).equals(idx))
								selected="selected";						
						%>
							<option value="<%=idx %>"<%=selected%>><%=idx %></option>
						<%} %>
						</select>
						</div>				
						</td>
						<td align="center" bgcolor="#FFFFFF"><input name="_inputTime" type="text" class="inputbox2" size="40" id="_inputTime" align="center" readonly="true" /></td>
					</tr>

				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="15">&nbsp;</td>
			</tr>
			<tr>
				<td height="39" align="center" background="/PromesService/images/common/box_01.gif" style="background-repeat: no-repeat; background-size: cover;">
				<table width="735" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="20"><img src="/PromesService/images/common/dot_01.gif" width="11" height="11" /></td>
								<td width="90" class="td_table01"><fmt:message key='the_beginning_date'/></td>
								<td><input name="_startDate" type="text" class="inputbox" size="20" id="_startDate" align="center" <%if(prescriptionInfo != null){%> value="<%=prescriptionInfo.getStartDate()%>" <%} %> readonly="true" /></td>
								<td width="40" align="center">
								<%if(prescriptionInfo != null){if(!prescriptionInfo.checkChange()){%>
									<img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" />
								<%}else{ %>
									<a href="javascript:alt('start');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a>
								<%}} %>
								</td>	
							</tr>
						</table>
						</td>
						<td width="20">&nbsp;</td>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="20"><img src="/PromesService/images/common/dot_01.gif" width="11" height="11" /></td>
								<td width="70" class="td_table01"><fmt:message key='the_end_date'/></td>
								<td><input name="_endDate" type="text" class="inputbox" size="20" id="_endDate" align="center" <%if(prescriptionInfo != null){%> value="<%=prescriptionInfo.getEndDate()%>" <%} %> readonly="true"  /></td>
								<td width="40" align="center">
								<%if(prescriptionInfo != null){if(!prescriptionInfo.checkChange()){%>
									<img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" />
								<%}else{ %>
									<a href="javascript:alt('end');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a>
								<%}} %>
							</tr>
						</table>
						</td>
						<td width="200">&nbsp;</td>
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
      </td>
      </tr>
      <tr>
        <td height="15">&nbsp;</td>
      </tr>
      <tr>
        <td height="2" align="right">
	        <a href="javascript:modifyUser();"><img src="/PromesService/images/common/bt_revision.gif"  id="Image44" border="0" onmouseover="MM_swapImage('Image44','','/PromesService/images/common/bt_revision_.gif',1)" onmouseout="MM_swapImgRestore()" /></a>
	        <img src="/PromesService/images/common/bt_colse.gif" id="Image8" border="0" onclick="self.close()" onmouseover="MM_swapImage('Image8','','/PromesService/images/common/bt_colse_.gif',1)" onmouseout="MM_swapImgRestore()" />
        </td>
       </tr>
      <tr>
        <td height="50">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<iframe name="modifyResultPage" id="modifyResultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="0" height="0"></iframe>
</form>
</body>
</html>