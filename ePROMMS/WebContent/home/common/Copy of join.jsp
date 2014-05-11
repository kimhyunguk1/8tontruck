<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Join</title>
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

function initsize() {
	//userInfoPage.resizeTo(userInfoPage.document.body.scrollWidth, userInfoPage.document.body.scrollHeight);
	var _height = document.getElementById('userInfoPage').contentWindow.document.body.scrollHeight;
    document.getElementById('userInfoPage').height=_height;
}

function changeTyep(value){
	var tmpHtml = "";
	var tmpHtml2 = "";
	if(value == 'patient'){
		tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/home/management/addUser_patient.jsp\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		tmpHtml2 += "<input type=\"checkbox\" name=\"_sms\" id=\"_sms\" checked=\"true\" />복용알람 SMS 수신";
	}else if(value == 'incharge'){
		tmpHtml ="<iframe name=\"userInfoPage\" id=\"userInfoPage\" src=\"/PromesService/home/management/addUser_doctor.jsp\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
		tmpHtml2 += "&nbsp;";
	}	
	addUserInfoDiv.innerHTML = tmpHtml;
	smsDiv.innerHTML = tmpHtml2;
}

var isIDCheck = false;
function checkId(){
	var mainForm = document.form;
	var id = mainForm._id.value;
	if(id == null || id == ""){
		alert("<fmt:message key='enter_your_ID'/>");
		return false;
	}
	
	var count = 0;
	if(id.length<3 || id.length>12){
		alert("<fmt:message key='the_characters_of_ID_should_be_3~12.'/>");
		return false;
	}
	for(i=0;i<id.length;i++){
		if(id.charAt(i)!='"'){
			count++;
		}
	}
	
	if(id.length != count){
		alert("<fmt:message key="your_ID_can't_be_used_here."/>");
		return false;
	}
	
	if(id=="admin"){
		alert("<fmt:message key="your_ID_can't_be_used."/>");
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

function addUser(){
	if(fieldCheck()){
		var mainForm = document.form;
		mainForm.cmd.value = "join";
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
			mainForm._timeList.value = userInfoPage.getTimeList();
			mainForm._pillBoxs.value = userInfoPage.getPillbox();
		}else{
			mainForm._company.value = userInfoPage.getCompany();
			if(!userInfoPage.phoneCheck()){
				return;
			}
			mainForm._companyPh.value = userInfoPage.getPh();
			mainForm._addr.value = userInfoPage.getAddr();
		}
		if(mainForm._sms != undefined){
			mainForm._receiptSMS.value = mainForm._sms.checked;
		}
		mainForm.target = "joinResultPage";
		mainForm.submit();
	}
}

function fieldCheck(){
	var mainForm = document.form;
	if(mainForm._name.value == null || mainForm._name.value == ""){
		alert("<fmt:message key='enter_your_name.'/>");
		return false;
	}else if(mainForm._id.value == null || mainForm._id.value == ""){
		alert("<fmt:message key='enter_your_ID'/>");
		return false;
	}else if(!isIDCheck){
		alert("<fmt:message key='confirm_the_repeat_ID'/>");
		return false;
	}else if(mainForm._pw.value == null || mainForm._pw.value == ""){
		alert("<fmt:message key='enter_your_password'/>");
		return false;
	}else if(mainForm._repw.value == null || mainForm._repw.value == ""){
		alert("<fmt:message key='enter_the_confirmation_of_password.'/>");
		return false;
	}else if(mainForm._pw.value != mainForm._repw.value){
		alert("<fmt:message key='confirm_the_repeat_ID'/>");
		return false;
	}else if(mainForm._pw.value == mainForm._id.value){
		alert("<fmt:message key="Your_password_can't_be_used_because_it_is_same_as_your_ID."/>");
		return false;	
	}else if(!pwdCheck()){
		return false;
	}
// 	else if(mainForm._email1.value == null || mainForm._email1.value == ""){
// 		alert("<fmt:message key='confirm_your_e-mail.'/>");
// 		return false;
// 	}else if(mainForm._email2.value == null || mainForm._email2.value == ""){
// 		alert("<fmt:message key='confirm_your_e-mail.'/>");
// 		return false;
// 	}else if(!emailCheck()){
// 		return false;
// 	}
	else if(mainForm._hp2.value == null || mainForm._hp2.value == ""){
		alert("<fmt:message key=''/>confirm_your_telephone.");
		return false;
	}else if(mainForm._hp3.value == null || mainForm._hp3.value == ""){
		alert("<fmt:message key='confirm_your_telephone.'/>");
		return false;
	}if(!phoneCheck()){
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
		alert("<fmt:message key='Your_password_should_be_more_than_3_characters_and_less_than_8_characters.'/>");
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
		alert("<fmt:message key='Passwords_should_contain_letters_and_numbers.'/>");
		return false;
	}
	return true;
}

function phoneCheck(){
	var mainForm = document.form;
	var tmpHp1 = mainForm._hp2.value;
	var tmpHp2 = mainForm._hp3.value;
	var chkNum = 0;
	var chkEng = 0;
	
	for(var i=0;i<tmpHp1.length;i++){
		if(tmpHp1.charAt(i)>='0' && tmpHp1.charAt(i)<='9'){
			chkNum++;	
		}
		else if(tmpHp1.charAt(i)>='a' && tmpHp1.charAt(i)<='z'){
			chkEng++;
		}
	}
	if(tmpHp1.length!=(chkNum+chkEng) || chkEng != 0 || tmpHp1.length < 3 || tmpHp1.length > 4){
		alert("휴대폰의 앞자리는 3~4자리 숫자로 이루어져야 합니다.");
		return false;
	}
	chkNum = 0;
	chkEng = 0;
	for(i=0;i<tmpHp2.length;i++){
		if(tmpHp2.charAt(i)>='0' && tmpHp2.charAt(i)<='9'){
			chkNum++;	
		}
		else if(tmpHp2.charAt(i)>='a' && tmpHp2.charAt(i)<='z'){
			chkEng++;
		}
	}
	if(tmpHp2.length!=(chkNum+chkEng) || chkEng != 0 || tmpHp2.length != 4){
		alert("휴대폰의 뒷자리는 4자리 숫자로 이루어져야 합니다.");
		return false;
	}
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
		alert("이메일을 확인 하세요.");
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
        	alert("이름은 한글 10자 영문 20자까지 사용 가능 합니다.\n다시 입력 하세요.");
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
  if(mainForm._email3.value != '직접입력'){
  	mainForm._email2.value = mainForm._email3.value;
  }else{
  	mainForm._email2.value = "";
  }
}

function changeId(){
	isIDCheck = false;	
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
	mainForm._email3.value = "직접입력";
	mainForm._hp1.value = "010";
	mainForm._hp2.value = "";
	mainForm._hp3.value = "";
	if(mainForm._sms != null){
		mainForm._sms.checked = true;
	}
	var tmpType = "";
	for(var i=0;i < mainForm._type.length;i++){
		if(mainForm._type[i].checked){
			tmpType = mainForm._type[i].value;
		}
	}
	changeTyep(tmpType);
}

function onlyNumber(){ 
	if((event.keyCode<48)||(event.keyCode>57))
	      event.returnValue=false;
// var Rtext = /[0-9]/g;
// var key = (window.netscape) ? event.which : event.keyCode;
// var t = Rtext.test(String.fromCharCode(key));
// if(t){
// 	return true;
// }else{
//    return false;
// }
}
function reloadPage(){
	parent.reloadPage();
}
//-->
</script>
</head>
<body onload="MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/common/bt_initialize_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/common/bt_id_.gif','/PromesService/images/common/bt_X_.gif','/PromesService/images/common/bt_add2_.gif','/PromesService/images/common/bt_registration_.gif')" >
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_protectors" type="hidden" value=""/>
<input name="_timeList" type="hidden" value=""/>
<input name="_pillBoxs" type="hidden" value=""/>
<input name="_company" type="hidden" value=""/>
<input name="_companyPh" type="hidden" value=""/>
<input name="_addr" type="hidden" value=""/>
<input name="_receiptSMS" type="hidden" value=""/>
<table width="760" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/PromesService/images/management/main_title_h.gif" width="760" height="35" /></td>
  </tr>
  <tr>
    <td height="15">&nbsp;</td>
  </tr>
  <tr>
    <td><table width="760" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="3" bgcolor="#a7c2bc"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">*구분</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
<!--                         <td width="40" align="right"><input name="_type" type="radio" id="_type" value="patient" checked="true" onclick="javascript:changeTyep('patient');" /></td> -->
<!--                         <td width="35" align="center">환자</td> -->
                        <td width="40" align="right"><input type="radio" name="_type" id="_type" value="incharge" checked="true" onclick="javascript:changeTyep('incharge');" /></td>
                        <td width="50" align="center">담당자</td>
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
            <td><table width="756" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">*이름</td>
                  <td>&nbsp;
                      <input name="_name" type="text" class="inputbox" size="25" id="_name"  onkeydown="javascript:nameCheck();" /></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">*아이디</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="176">&nbsp;
                            <input name="_id" type="text" class="inputbox" size="25" id="_id" onchange="javascript:changeId();"/></td>
                        <td width="70"><a href="javascript:openIdCheck();"><img src="/PromesService/images/common/bt_id.gif" width="57" height="18" border="0" id="Image5" onmouseover="MM_swapImage('Image5','','/PromesService/images/common/bt_id_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
                        <td class="td_table03">('"' 를 제외한 한영숫자 조합으로 한글 10자, 영문 20자)</td>
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
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">*비밀번호</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="180">&nbsp;
                            <input name="_pw" type="password" class="inputbox" size="25" id="_pw" style="text-transform:lowercase" /></td>
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
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">*비밀번호 확인</td>
                  <td>&nbsp;
                      <input name="_repw" type="password" class="inputbox" size="25" id="_repw" style=" text-transform:lowercase" /></td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="1" bgcolor="#ececec"></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">*이메일</td>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="167">&nbsp;
                            <input name="_email1" type="text" class="inputbox" size="25" id="_email1" style=" text-transform:lowercase" /></td>
                        <td width="30" align="center" >@</td>
                        <td width="135" align="left" ><input name="_email2" type="text" class="inputbox" size="20" id="_email2" style=" text-transform:lowercase" /></td>
                        <td ><select name="_email3" class="select_white" style="width:120px" onchange="javascript:changeMail();">
							<option selected="true" value="직접입력" >직접입력</option>
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
                <td width="120" height="25" bgcolor="#e1eeef" class="td_table02">*휴대폰 번호</td>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="60">&nbsp;
                          <select name="_hp1" class="select_white" style="width:50px">
 							<option selected="true" value="010">010</option>
                         	<option  value="011" >011</option>
                            <option  value="016" >016</option>
                            <option  value="017" >017</option>
                      <td width="25" align="center" >-</td>
                      <td width="75" ><input name="_hp2" type="text" class="inputbox" size="12" id="_hp2"  onkeypress="javascript:onlyNumber();" onkeyup="this.value=this.value.replace(/[ㄱ-ㅎ가-힣]/g,'')"/></td>
                      <td width="25" align="center" >-</td>
                      <td width="90" ><input name="_hp3" type="text" class="inputbox" size="12" id="_hp3"  onkeypress="javascript:numberText();" /></td>
                      <td class="inputbox" ><div id="smsDiv"><input type="checkbox" name="_sms" id="_sms" checked="true" />복용알람 SMS 수신</div></td>
                      <td >&nbsp;</td>
                    </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
          	<td>
				<div id="addUserInfoDiv">
	            	<iframe name="userInfoPage" id="userInfoPage" src="/PromesService/home/management/addUser_doctor.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
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
            <td width="80" valign="bottom"><a href="javascript:addUser()"><img src="/PromesService/images/common/bt_registration.gif" width="74" height="22" id="Image4" border="0" onmouseover="MM_swapImage('Image4','','/PromesService/images/common/bt_registration_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
            <td width="74" valign="bottom"><a href="javascript:clearField()"><img src="/PromesService/images/common/bt_initialize.gif" width="74" height="22" id="Image8" border="0" onmouseover="MM_swapImage('Image8','','/PromesService/images/common/bt_initialize_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
          </tr>
        </table></td>
       </tr>
      <tr>
        <td height="15">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<iframe name="joinResultPage" id="joinResultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="0" height="0"></iframe>
</form>
</body>
</html>