<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="lang_fr"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 User addition</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<link href="/PromesService/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="/PromesService/css/redmond/jquery-ui-1.10.4.custom.css" rel="stylesheet" type="text/css" />
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

//***************************** 회원 등록 구분 변경 ******************************
function changeTyep(value){
	var mainForm = document.form;
	
	if(value == 'patient'){
		$('#pillBoxDiv').css("display","block");
		$('#hospitalDiv').css("display","none");
		$('#telephoneDiv').css("display","none");
		$('#addressDiv').css("display","none");
		$('#hospitalDiv').val('');
		$('#telephoneDiv').val('');
		$('#addressDiv').val('');
		document.getElementById('pwDiv').style.display='none';
		document.getElementById('confirmPwDiv').style.display='none';
		document.getElementById('_age').value='';
		document.getElementById('_pw').value='qw12';
		document.getElementById('_repw').value='qw12';
		
	}else if(value == 'incharge'){
		$('#pillBoxDiv').css("display","none");
		$('#hospitalDiv').css("display","block");
		$('#telephoneDiv').css("display","block");
		$('#addressDiv').css("display","block");
		$('#_pillBoxId').val('');
		$('#_pillBoxDate').val('');
		document.getElementById('pwDiv').style.display='block';
		document.getElementById('confirmPwDiv').style.display='block';
		document.getElementById('_age').value='20140101';
		document.getElementById('_pw').value='';
		document.getElementById('_repw').value='';
	}
}

//***************************** 아이디 중복 체크  ******************************
var isIDCheck = false;
function checkId(){
	var mainForm = document.form;
	var id = mainForm._id.value;
	if(id == null || id == ""){
		alert("<fmt:message key='enter_your_ID' />");
		return false;
	}
	
	var count = 0;
	if(id.length<3 || id.length>12){
		alert("<fmt:message key='the_characters_of_ID_should_be_3~12.' />");
		return false;
	}
	for(i=0;i<id.length;i++){
		if(id.charAt(i)!='"'){
			count++;
		}
	}
	
	if(id.length != count){
		alert("<fmt:message key="your_ID_can't_be_used." />");
		return false;
	}
	
	if(id=="admin"){
		alert("<fmt:message key="your_ID_can't_be_used." />");
		return false;
	}
	return true;
}

function openIdCheck(){
	if(!checkId()){
		return;
	}

	var mainForm = document.form;
	mainForm._pw.focus();
	var x = 0; 
	var	y = 0;
	var w = 364;
	var h = 230;
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
	var point = "width=364, height=230, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	MM_openBrWindow('/PromesService/PromesServerServlet?cmd=checkId&_id=' + mainForm._id.value,'idCheckPopup',point);
}

//***************************** 사용자 추가  ******************************
function addUser(){	
	if(fieldCheck()){
		
		var mainForm = document.form;
		mainForm.cmd.value = "addUser";
		var tmpType = "";
		for(var i=0;i < mainForm._type.length;i++){
			if(mainForm._type[i].checked){
				tmpType = mainForm._type[i].value;
			}
		}
		if(tmpType == "patient"){
			mainForm._protectors.value = userInfoPage.getProtectors();
			if(!userInfoPage.checkTime()){
				return;
			}
// 			mainForm._timeList.value = userInfoPage.getTimeList();
			mainForm._pillBoxs.value = "[" + $('#_pillBoxId').val() + "/" + $('#_pillBoxType option:selected').val() + "/" + $('#_pillBoxDate').val() + "]";
		}else{
			mainForm._companyPh.value = $('#_ph2').val();
			mainForm._addr.value = $('#_addr').val();
		}
		
		mainForm.target = "addUserResultPage";
		mainForm.submit();
	}		

}

function fieldCheck(){
	
	var mainForm = document.form;
	if(mainForm._name.value == null || mainForm._name.value == ""){		
		alert("<fmt:message key='enter_your_name.' />");
		return false;
	}else if(mainForm._id.value == null || mainForm._id.value == ""){
		alert("<fmt:message key='enter_your_ID' />");
		return false;
	}else if(mainForm._age.value == null || mainForm._age.value == ""){
		alert("<fmt:message key='enter_the_birth_date.' />");
		return false;
	}else if(!isIDCheck){
		alert("<fmt:message key='confirm_the_repeat_ID' />");
		return false;
	}else if(mainForm._pw.value == null || mainForm._pw.value == ""){
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
	}
// 	else if(mainForm._email1.value == null || mainForm._email1.value == ""){
// 		alert("<fmt:message key='confirm_your_e-mail.' />");
// 		return false;
// 	}else if(mainForm._email2.value == null || mainForm._email2.value == ""){
// 		alert("<fmt:message key='confirm_your_e-mail.' />");
// 		return false;
// 	}
// 	else if(!emailCheck()){
// 		return false;
// 	}
	else if(mainForm._hp2.value == null || mainForm._hp2.value == ""){
		alert("<fmt:message key='This_phone_number_is_not_valid.' />");
		return false;
	}
// 	else if(mainForm._hp3.value == null || mainForm._hp3.value == ""){
// 		alert("<fmt:message key='This_phone_number_is_not_valid.' />");
// 		return false;
// 	}
	else if(mainForm._age.value == null || mainForm._age.value == ""){
		alert("<fmt:message key='enter_the_birth_date.' />");
		return false;
	}
// 	else if($('input:radio[name=_type]:checked').val() == "incharge")	{
		
// 	}
	if(!phoneCheck()){
		return false;
	}
	else{
		return true;
	}
}
function birthdateCheck(){
	if($('#_age').val().length < 8 || $('#_age').val().length > 8){
		return false;
	}else{
		
		return true;
	}
}
function pwdCheck(){
	var mainForm = document.form;
	var chkNum = 0;
	var chkEng = 0;
	var pwd1=mainForm._pw.value.toLowerCase();
	if(pwd1.length<3 || pwd1.length>8){
		alert("<fmt:message key='Your_password_should_be_more_than_3_characters_and_less_than_8_characters.' />");
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
// 		alert("Check Phone number");
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
// 		alert("Check Phone number");
// 		return false;
// 	}
	return true;
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

function nameCheck(){
	var mainForm = document.form;
	var tmpName = mainForm._name.value;
	var len = 0;
    for (var i=0; i<tmpName.length; i++) {
		len += (tmpName.charCodeAt(i) > 128) ? 2 : 1;
        if (len > 20){
        	alert("<fmt:message key='Name_should_be_less_than_20_letters.' />");
       	  	mainForm._name.value = "";
        }
	}
}

function numberText(){
	if((event.keyCode < 48) || (event.keyCode > 57))
  	event.returnValue = false;
}

function setId(value1, value2){
	var mainForm = document.form;
	mainForm._id.value = value1;
	if(value2 == 'true'){
		isIDCheck = false;
	}else if(value2 == 'false'){
		isIDCheck = true;
	}
}

function changeMail(){
  var mainForm = document.form;
  if(mainForm._email3.value != "<fmt:message key='direct_input' />"){
  	mainForm._email2.value = mainForm._email3.value;
  }else{
  	mainForm._email2.value = "";
  }
}

function changeId(){
	isIDCheck = false;	
}

function changePage(value){
	
	parent.changeMenu('Memberlist', value);
}

function clearField(){
	var mainForm = document.form;
	mainForm._name.value = "";
	mainForm._id.value = "";
	isIDCheck = false;
	mainForm._pw.value = "";
	mainForm._repw.value = "";
	mainForm._email1.value = "";
	mainForm._email2.value = "";
	mainForm._email3.value = "<fmt:message key='direct_input' />";
// 	mainForm._hp1.value = "010";
	mainForm._hp2.value = "";
// 	mainForm._hp3.value = "";
	if(mainForm._sms != null){
		mainForm._sms.checked = true;
	}
	var tmpType = "";
	for(var i=0;i < mainForm._type.length;i++){
		if(mainForm._type[i].checked){
			tmpType = mainForm._type[i].value;
		};
	}
	addPrescriptionDiv.style.display="none";
	changeTyep(tmpType);
}
function pillboxChk(){
	var mainForm = document.form;
	if(mainForm._pillboxId.value=="" || mainForm._pillboxDate.value==""){	
		alert("<fmt:message key='enter_the_registered_number_of_the_pillbox' />");
		return false;
	}else{
		return true;
	}
}

function addPrescriptionData(){
	
	var tmpHtml = "";
	if(addPrescriptionDiv.style.display == "none"){
		if( fieldCheck() && pillboxChk()){		
			tmpHtml ="<iframe name=\"addPrescriptionPage\" id=\"addPrescriptionPage\" src=\"/PromesService/PromesServerServlet?cmd=loadAddPrescriptionInAddUserPage\" frameborder=\"0\" scrolling=\"no\" framespacing=\"0\" width=\"750\" height=\"450\"></iframe>";
			addPrescriptionDiv.innerHTML = tmpHtml;
			addPrescriptionDiv.style.display="block";
			addPrescriptionDataBtn.style.display="none";
			
		}
	}else{
		addPrescriptionDiv.style.display="none";
	}
}
	
function setPillboxData(id,type,date){
	var mainForm = document.form;
	mainForm._pillboxId.value = id;
	mainForm._pillboxType.value = type;
	mainForm._pillboxDate.value = date;
	
}

</script>

</head>
<body onload="MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/common/bt_initialize_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/common/bt_id_.gif','/PromesService/images/common/bt_X_.gif','/PromesService/images/common/bt_add2_.gif','/PromesService/images/common/bt_registration_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_protectors" type="hidden" value=""/>
<input name="_timeList" type="hidden" value=""/>
<input name="_pillBoxs" type="hidden" value=""/>
<input name="_companyPh" type="hidden" value=""/>
<input name="_addr" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/PromesService/images/management/main_title_h.gif" width="794" height="35" /></td>
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
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="35" bgcolor="#e1eeef" class="td_table02">*<fmt:message key='division(??)' /></td>
                  <td><table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><input name="_type" type="radio" id="_type" value="patient" checked="true" onclick="javascript:changeTyep('patient');" /></td>
                        <td><fmt:message key='patients' /></td>
                        <td><input name="_type" type="radio" id="_type" value="incharge" onclick="javascript:changeTyep('incharge');" /></td>
                        <td><fmt:message key='staff' /></td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table  border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="35" bgcolor="#e1eeef" class="td_table02">*<fmt:message key='name' /></td>
                  <td><input name="_name" type="text"  size="25" id="_name"  onkeydown="javascript:nameCheck();" /></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          
          <tr>
          	 <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
            			<td width="120" height="35" bgcolor="#e1eeef" class="td_table02">*<fmt:message key='date_of_birth' /></td>
            			<td><input name="_age" type="text"  size="12" id="_age" placeholder="ex) 20140101" onkeypress="javascript:numberText();"/></td>
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
            			<td width="120" height="35" bgcolor="#e1eeef" class="td_table02">*<fmt:message key='gender' /></td>
            			<td>
            				<select name="_gender" style="width:80px">
							<option selected="true" value="<fmt:message key='male' />" ><fmt:message key='male' /></option>
                        		<option value="<fmt:message key='female' />" ><fmt:message key='female' /></option>
                      	</select>
                  	</td>
          		</table>
          	</td>
          </tr>
          
          
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="45" bgcolor="#e1eeef" class="td_table02">*ID</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><input name="_id" type="text" size="25" id="_id" onchange="javascript:changeId();" /></td>
                        <td style="padding-right:5px;"><a href="javascript:openIdCheck();"><img src="/PromesService/images/common/bt_id.gif" border="0" id="Image5" onmouseover="MM_swapImage('Image5','','/PromesService/images/common/bt_id_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
                        <td class="td_table03">(<fmt:message key='10-20_letters_combination_with_numbers_and_letters_except_symbols' />)</td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          
          <tr>
            <td>
            <div id="pwDiv" style="display: none;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="45" bgcolor="#e1eeef" class="td_table02">*<fmt:message key='passwords' /></td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td style="padding-right:5px;">
                            <input name="_pw" type="password"  size="25" id="_pw" style=" text-transform:lowercase;" value="qw12"/></td>
                        <td class="td_table03">(<fmt:message key='make_passwords_with_combination_with_3~8_letters_and_numbers' />)</td>
                      </tr>
                  </table></td>
                </tr>
            </table>
            </div>
            </td>
          </tr>
          <tr class="divLine">
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td>
            <div id="confirmPwDiv" style="display: none;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="35" bgcolor="#e1eeef" class="td_table02">*<fmt:message key='confirm_passwords' /></td>
                  <td><input name="_repw" type="password"  size="25" id="_repw" style="  text-transform:lowercase" value="qw12"/></td>
                </tr>
            </table>
            </div>
            </td>
          </tr>
          <tr class="divLine">
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          
          
          <tr>
            <td><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="45" bgcolor="#e1eeef" class="td_table02">E-mail</td>
                  <td><input name="_email1" type="text" size="25" id="_email1" style="  text-transform:lowercase" /></td>
                  <td>
	                  <table border="0" cellspacing="0" cellpadding="0">
		                  <tr>
		                  	<td>@</td>
                  			<td><input name="_email2" type="text"  size="20" id="_email2" style="  text-transform:lowercase" /></td>
			                <td >
			               		<select name="_email3" onchange="javascript:changeMail();">
									<option selected="true" value="직접입력" ><fmt:message key='direct_input' /></option>
			                     </select>
			                </td>
		                  </tr>
	                  </table>
                  </td>
                </tr>
            </table>
            </td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120" height="45" bgcolor="#e1eeef" class="td_table02">*<fmt:message key='cellular_phone_number' /></td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="175" ><input name="_hp2" type="text" size="25" id="_hp2"   onkeypress="javascript:numberText();"/></td>
                      <td >&nbsp;</td>
                    </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          
          <tr>
            <td height="1" colspan="8" bgcolor="#ececec"></td>
          </tr>
          <tr>
		   <td>
		   <div id="pillBoxDiv" style="display: block;">
		       <table width="100%" border="0" cellspacing="0" cellpadding="0">
		         <tr>
		           <td width="120" height="30" bgcolor="#e1eeef" class="td_table02"><fmt:message key='the_registered_number_of_the_box' /></td>
		           <td>
			         <table width="100%" border="0" cellspacing="0" cellpadding="0">
			             
			             <tr>
			               <td>&nbsp;</td>
			               <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			                   <tr>
			                     <td height="20">&nbsp;</td>
			                   </tr>
			                   <tr>
			                     <td>
			                     	<table border="0" cellspacing="0" cellpadding="0">
			                         
			                         <tr>
			                           <td style="padding-right : 5px">ID</td>
			                           <td style="padding-right : 20px"><input name="_pillBoxId" type="text" size="13" id="_pillBoxId" /></td>
			                           <td style="padding-right : 5px;"><fmt:message key='configurator' /></td>
			                           <td>
				                           <select name="_pillBoxType"  style="width:120px" id="_pillBoxType">
				                             <option value="<fmt:message key='type_of_the_loadcell' />"><fmt:message key='type_of_the_loadcell' /></option> 
				                             <option value="manual">manual</option>
				                           </select>
				                       </td>
				                      </tr>
				                      </table>
				                      <table>
				                      <tr>
			                           <td><fmt:message key='the_date_of_registration' /></td>
			                           <td>
			                               <input name="_pillBoxDate" type="text" size="17" id="_pillBoxDate" readonly="readonly"/></td>
			                           <td><i class="fa fa-calendar fa-lg" id="_pillBoxDateIcon" style="cursor: pointer;"></i></td>
									   
			                         </tr>
			                     	</table>
			                     </td>
			                   </tr>
			               </table></td>
			             </tr>
			             <tr>
			               <td height="5"></td>
			               <td></td>
			             </tr>
			           </table>
		           </td>
		         </tr>
		          <tr>
                    <td height="1" colspan="8" bgcolor="#ececec"></td>
                  </tr>
		       </table>
		       </div>
		       </td>
		    </tr>
		    
		    <tr>
	         <td>
	         	<div id="hospitalDiv" style="display: none;">
		         <table width="756" border="0" cellspacing="0" cellpadding="0">
		             <tr>
		               <td width="120" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='name_of_hospital' /></td>
		               <td><input name="_company" type="text"  size="25" id="_company"  onkeydown="javascript:hospitalCheck();" /></td>
		             </tr>
		         </table>
		         </div>
	         </td>
       		</tr>
	       <tr>
	         <td height="1" bgcolor="#ececec"></td>
	       </tr>
	       <tr>
	         <td>
	         	<div id="telephoneDiv" style="display: none;">
	         	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	             <tr>
	               <td width="120" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='telephone' /></td>
	               <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                   <tr>
	                     <td width="175" ><input name="_ph2" type="text"  size="25" id="_ph2"  onkeypress="javascript:numberText();"/></td>
	                     <td >&nbsp;</td>
	                   </tr>
	               </table>
	               </div>
	               </td>
	             </tr>
	         </table></td>
	       </tr>
	       <tr>
	         <td height="1" bgcolor="#ececec"></td>
	       </tr>
	       <tr>
	         <td>
	         	<div id="addressDiv" style="display: none;">
	         	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	             <tr>
	               <td width="120" height="55" bgcolor="#e1eeef" class="td_table02"><fmt:message key='address' /></td>
	               <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                   <tr>
	                     <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                         <tr>
	                           <td><input name="_addr" type="text" size="70" id="_addr"  /></td>
	                           <td class="inputbox" >&nbsp;</td>
	                           <td >&nbsp;</td>
	                         </tr>
	                     </table></td>
	                   </tr>
	               </table>
	               </div>
	               </td>
	             </tr>
	         </table></td>
	       </tr>
          <tr style="display: none">
          	<td>
				<div id="addUserInfoDiv">
	            	<iframe name="userInfoPage" id="userInfoPage" src="/PromesService/home/management/addUser_patient.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
	            </div>
          	</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td>&nbsp;</td>
<!--             <td width="80" valign="bottom" id="addPrescriptionDataBtn"><a href="javascript:addPrescriptionData()"><img src="/PromesService/images/common/bt_input_prescription.gif" width="74" height="22" id="Image7" border="0" onmouseover="MM_swapImage('Image7','','/PromesService/images/common/bt_input_prescription_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td> -->
            <td width="80" valign="bottom"><a href="javascript:addUser()"><img src="/PromesService/images/common/bt_registration.gif" width="74" height="22" id="Image4" border="0" onmouseover="MM_swapImage('Image4','','/PromesService/images/common/bt_registration_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
            <td width="74" valign="bottom"><a href="javascript:clearField()"><img src="/PromesService/images/common/bt_initialize.gif" width="74" height="22" id="Image8" onmouseover="MM_swapImage('Image8','','/PromesService/images/common/bt_initialize_.gif',1)" border="0" onmouseout="MM_swapImgRestore()" /></a></td>
          </tr>
        </table></td>
       </tr>
      <tr>
        <td height="50">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<iframe name="addUserResultPage" id="addUserResultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="0" height="0"></iframe>
</form>
<script src="/PromesService/js/jquery-2.1.0.min.js"></script>
<script src="/PromesService/js/jquery-ui-1.10.4.custom.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var tmpPillBoxId = $('#_pillBoxId').val();
	var tmpPillBoxDate = $('#_pillBoxDate').val();
	var tmpPillBoxType = $('#_pillBoxType').val();
	$('#_pillBoxDate').datepicker({
		dateFormat: "yy-mm-dd",
		showMonthAfterYear: true,
		monthNames:["1","2","3","4","5","6","7","8","9","10","11","12"],
		dayNamesMin:["<fmt:message key='sunday' />","<fmt:message key='monday' />","<fmt:message key='tuesday' />",
		          "<fmt:message key='wednesday' />","<fmt:message key='thursday' />","<fmt:message key='friday' />","<fmt:message key='saturday' />"]
	});
	$('#_pillBoxDateIcon').click(function(){
		$('#_pillBoxDate').datepicker("show");
	});
	$('#_pillBoxId').blur(function(){
		if(tmpPillBoxId != $('#_pillBoxId').val()){
			$.ajax({
				  type: "POST",
				  url: '/PromesService/PromesServerServlet',
				  dataType: "json",
				  data: { cmd: "AjaxcheckPillBox", _takenBoxId: $('#_pillBoxId').val(), _userId: "${userInfo.id}" }
				})
				  .done(function( data ) {
				      if(data.result == "false"){
				    	var date = new Date();
						var day = "";
						if( date.getDate() < 10 ){
							day = "0" + date.getDate(); 
						}else{
							day = date.getDate(); 
						}
						if((date.getMonth()+1) < 10){
							
							$('#_pillBoxDate').val(date.getFullYear()+'-0'+(date.getMonth()+1)+'-'+day);
						}else{
							$('#_pillBoxDate').val(date.getFullYear()+'-'+(date.getMonth()+1)+'-'+day);
						}
				    }else{
				    	alert(data.result);
				    	$('#_pillBoxId').val(tmpPillBoxId);
						$('#_pillBoxDate').val(tmpPillBoxDate);
						$('#_pillBoxType').val(tmpPillBoxType).attr("selected", "selected");
				    }
				  })
				  .fail(function( data ) {
					  alert("search fail..");
					  $('#_pillBoxId').val(tmpPillBoxId);
					  $('#_pillBoxDate').val(tmpPillBoxDate);
				      $('#_pillBoxType').val(tmpPillBoxType).attr("selected", "selected");
				  });
		}	
	});
});
</script>
</body>
</html>