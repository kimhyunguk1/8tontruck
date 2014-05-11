<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.Define"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%UserInfo userInfo = (UserInfo)request.getAttribute("userInfo"); %>
<%String msg = (String)request.getAttribute("msg"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 User Modify</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script src="/PromesService/js/jquery-2.1.0.min.js"></script>
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
	parent.initsize();
}

function changeTyep(value){
	var tmpHtml = "";
	if(value == 'patient'){
		tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/home/management/modifyUser_patient.jsp\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";

	}else if(value == 'doctor'){
		tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/home/management/addUser_doctor.jsp\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}else if(value == 'pharmacist'){
		tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/PromesServerServlet?cmd=addUserPharmacist\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}
	addUserInfoDiv.innerHTML = tmpHtml;
}

function openIdCheck(){
	var x = 0; 
	var	y = 0;
	var w = 364;
	var h = 250;
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
	var point = "width=364, height=250, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	MM_openBrWindow('/PromesService/home/common/popup_id_check.jsp','idCheckPopup',point);
}

function init(){	
	var tmpHtml = "";
	<%
	if(userInfo != null){
		session.setAttribute("userInfo",userInfo);
  		if(userInfo.getType().equals(Define.USER_PATIENT)){%>
			tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/home/management/modifyUser_patient.jsp\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		<%}else if(userInfo.getType().equals(Define.USER_INCHARGE)){%>
			tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/home/management/addUser_doctor.jsp\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";	
		<%}else {%>
			tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/PromesServerServlet?cmd=addUserPharmacist\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		<%}%>
		addUserInfoDiv.innerHTML = tmpHtml;
		
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
		mainForm.cmd.value = "modifyUser";
		var tmpType = mainForm._type.value;
		if(tmpType == "PATIENT"){
			mainForm._protectors.value = userInfoPage.getProtectors();
			if(!userInfoPage.checkTime()){
				return;
			}
// 			mainForm._timeList.value = userInfoPage.getTimeList();
// 			mainForm._timeList.value = userInfoPage.getTimeList();
			mainForm._pillBoxs.value = userInfoPage.getPillbox();
// 			mainForm._receiptSMS.value = mainForm._sms.checked;
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
		alert("<fmt:message key='enter_your_password' />");
		return false;
	}else if(mainForm._repw.value == null || mainForm._repw.value == ""){
		alert("<fmt:message key='enter_the_confirmation_of_password.' />");
		return false;
	}else if(mainForm._pw.value != mainForm._repw.value){
		alert("<fmt:message key='Your_ID_is_wrong.' />");
		return false;
	}else if(mainForm._pw.value == mainForm._id.value){
		alert("<fmt:message key="Your_password_can't_be_used_because_it_is_same_as_your_ID." />");
		return false;	
	}else if(!pwdCheck()){
		return false;
	}else if(!birthdateCheck()){
		alert("birth date : ex) 20140101");
		return false;
	}
// 	else if(mainForm._email1.value == null || mainForm._email1.value == ""){
// 		alert("<fmt:message key='confirm_your_e-mail.' />");
// 		return false;
// 	}else if(mainForm._email2.value == null || mainForm._email2.value == ""){
// 		alert("<fmt:message key='confirm_your_e-mail.' />");
// 		return false;
// 	}else if(!emailCheck()){
// 		return false;
// 	}
	else if(mainForm._hp2.value == null || mainForm._hp2.value == ""){
		alert("<fmt:message key='confirm_your_telephone.' />");
		return false;
	}
// 	else if(mainForm._hp3.value == null || mainForm._hp3.value == ""){
// 		alert("<fmt:message key='confirm_your_telephone.' />");
// 		return false;
// 	}
	if(!phoneCheck()){
		return false;
	}else{
		return true;
	}
}
function birthdateCheck(){
	if($('#_age').val().length < 8 || $('#_age').val().length > 8 ){
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
		alert("<fmt:message key='passwords_should_be_more_than_3_letters_and_less_than_8_letters.' />");
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
		alert("<fmt:message key='Passwords_should_contain_letters_and_numbers.' />");
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
// 		alert("<fmt:message key='confirm_your_telephone.' />");
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
// 		alert("<fmt:message key='confirm_your_telephone.' />");
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
		alert("<fmt:message key='confirm_your_e-mail.' />");
		return false;
	}
	return true;
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
<input name="_type" type="hidden" value="${userInfo.type}">
<c:set var="male"><fmt:message key='male'/></c:set>
<c:set var="female"><fmt:message key='female'/></c:set>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/PromesService/images/management/main_title_d.gif" width="794" height="35" /></td>
  </tr>
  <tr>
    <td height="15">&nbsp;</td>
  </tr>
  <tr>
    <td><table width="756" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="3" bgcolor="#a7c2bc"></td>
          </tr>
          
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='name' /></td>
                  <td><input name="_name" type="text" id="_name"  value="<% if(userInfo != null){%><%=userInfo.getName() %><%} %>" /></td>
                  
                  
                  <c:if test="${userInfo.type =='PATIENT'}">
                  	<td width="60" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='date_of_birth' /></td>
                  <td><input name="_age" type="text"  id="_age" value="<% if(userInfo != null){%><%=userInfo.getAge() %><%} %>" onkeypress="javascript:numberText();"/></td>
                  <td width="60" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='gender' /></td>
                  <td>
                  
<%--                   	<input name="_gender" type="text"  id="_gender" value="<% if(userInfo != null){%><%=userInfo.getGender() %><%} %>"/> --%>
<!--                   	<select id="_gender" name="_gender" class="select_white" style="width:80px"> -->
<!--                   			<option value="choice" >choice</option> -->
<%-- 							<option value="<fmt:message key='male' var='man'/>" ${userInfo.gender == man ? 'selected = true' : '' }><fmt:message key='male' /></option> --%>
<%--                         	<option value="<fmt:message key='female' var='woman'/>" ${userInfo.gender == woman ? 'selected=true' : ''}><fmt:message key='female' /></option> --%>
<!--                       </select> -->
					<select id="_gender" name="_gender" class="select_white" style="width:80px">
							<option value="<fmt:message key='male'/>"   <c:if test="${userInfo.gender eq male }">selected</c:if> ><fmt:message key='male' /></option>
                        	<option value="<fmt:message key='female'/>" <c:if test="${userInfo.gender eq female  }">selected</c:if>><fmt:message key='female' /></option>
                      </select>
					
					 
                  </td>
                  
                  </c:if>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">ID</td>
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
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='passwords' /></td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="180">&nbsp;
                            <input name="_pw" type="password" class="inputbox" size="25" id="_pw" value="<% if(userInfo != null){%><%=userInfo.getPw() %><%} %>" style=" text-transform:lowercase" /></td>
                        <td class="td_table03">(<fmt:message key='make_passwords_with_combination_with_3~8_letters_and_numbers' />)</td>
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
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='confirm_passwords' /></td>
                  <td>&nbsp;
                      <input name="_repw" type="password" class="inputbox" size="25" id="_repw" value="<% if(userInfo != null){%><%=userInfo.getPw() %><%} %>" style=" text-transform:lowercase" /></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">EMAIL</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="167">&nbsp;
                        <%
                        	String[] e_mailArr = userInfo.getE_mailArr();
							if(e_mailArr.length != 2){
								e_mailArr = new String[]{"",""};
							}
                        %>
                            <input name="_email1" type="text" class="inputbox" size="25" id="_email1" value="<%=Util.toWebString(e_mailArr[0]) %>" style=" text-transform:lowercase" /></td>
                        <td width="30" align="center" >@</td>
                        <td width="135" align="left" ><input name="_email2" type="text" class="inputbox" size="20" id="_email2" value="<%=Util.toWebString(e_mailArr[1])%>" style=" text-transform:lowercase"/></td>
                        <td ><select name="_email3" class="select_white" style="width:120px" id="_email3" onchange="javascript:changeMail();">
                        	<option selected="true" value="직접입력" ><fmt:message key='direct_input' /></option>
<%--                         	<opaaation <%if(e_mailArr[1].equals("empas.com")){ %> selected="true" <%} %> value="empas.com" >empas</option> --%>
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
                <td width="120" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='cellular_phone_number' /></td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
<!--                       <td width="60">&nbsp; -->
<%--                       <%String[] hpArr = userInfo.getHpArr(); %> --%>
                     
<!--                           <select name="_hp1" class="select_white" style="width:50px" id="_hp1"> -->
<!--                             <option selected="true" value="010">010</option> -->
<%--                             <option <%if(hpArr[0].equals("011")){ %> selected="true"<%} %> >011</option> --%>
<%--                             <option <%if(hpArr[0].equals("016")){ %> selected="true"<%} %> >016</option> --%>
<%--                             <option <%if(hpArr[0].equals("017")){ %> selected="true"<%} %> >017</option> --%>
<!--                         </select></td> -->
<!--                       <td width="25" align="center" >-</td> -->
                      <td width="175" >&nbsp;&nbsp;<input name="_hp2" type="text" class="inputbox" size="25" id="_hp2" value="<%=userInfo.getHp() %>"  onkeypress="javascript:numberText();" /></td>
<!--                       <td width="25" align="center" >-</td> -->
<%--                       <td width="90" ><input name="_hp3" type="text" class="inputbox" size="12" id="_hp3" value="<%=hpArr[2] %>"  onkeypress="javascript:numberText();"/></td> --%>
<!--                       <td class="inputbox" > -->
<%--                       <% if(userInfo.getType().equals(Define.USER_PATIENT)){%> --%>
<%--                       <input type="checkbox" name="_sms" id="_sms" <%if(userInfo.isSms()){ %>  <%} %> /> --%>
<%--                         <fmt:message key='receive_SMS_message_of_medication' /><%}else{ %>&nbsp;<%} %></td> --%>
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
      <tr>
        <td height="15">&nbsp;</td>
      </tr>
      <tr>
        <td height="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>&nbsp;</td>
            <td width="80" valign="bottom"><a href="javascript:modifyUser();"><img src="/PromesService/images/common/bt_revision.gif" width="74" height="22" id="Image4" border="0" onmouseover="MM_swapImage('Image4','','/PromesService/images/common/bt_revision_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
            <%if(userInfo != null && userInfo.getType().equals(Define.USER_ADMIN)){ %>
            	<td width="74" valign="bottom"><a href="javascript:history.back()"><img src="/PromesService/images/common/bt_list.gif" width="74" height="22" id="Image8" border="0" onmouseover="MM_swapImage('Image8','','/PromesService/images/common/bt_list_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
            <%} %>
          </tr>
        </table></td>
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