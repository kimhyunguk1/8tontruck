<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%-- <%request.setAttribute("test", "lang_fr"); %> --%>
<%-- <c:out value="${test}"></c:out> --%>
<fmt:setBundle basename="lang_fr"/>
<%UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");%>
<%
String[] phArr = {"","",""};
if(userInfo != null){
	phArr = userInfo.getPhArr();
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Doctor Info</title>
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

function openPost(){
	var x = 0; 
	var	y = 0;
	var w = 442;
	var h = 445;
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
	var point = "width=442, height=445, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	MM_openBrWindow('/PromesService/PromesServerServlet?cmd=loadPostPage','postPopup',point);
}

function init(){
	var mainForm = document.form;
	mainForm._ph2.value = "${userInfo.ph}";
	<%
		if(userInfo != null){
			String[] companyAddrArr = userInfo.getCompanyAddr();
 		%> 
			mainForm._company.value = '<%=Util.toWebString(userInfo.getCompany())%>';
<%-- 			mainForm._ph2.value = '<%=Util.toWebString(phArr[1])%>'; --%>
<%-- 			mainForm._ph3.value = '<%=Util.toWebString(phArr[2])%>'; --%>
<%-- 			mainForm._post1.value = '<%=companyAddrArr[0]%>'; --%>
<%-- 			mainForm._post2.value = '<%=companyAddrArr[1]%>'; --%>
			mainForm._addr.value = '<%=companyAddrArr[2]%>';
	<%		
		}
 	%> 
 	
}

function setPost(post1, post2){
	var mainForm = document.form;
// 	var postArr = post1.split("-");
// 	mainForm._post1.value = postArr[0];
// 	mainForm._post2.value = postArr[1];
	mainForm._addr.value = post2;
}

function getCompany(){
	var mainForm = document.form;
	return mainForm._company.value;
}

function getPh(){
	var mainForm = document.form;
	var tel = mainForm._ph2.value;
// 	var tel = mainForm._ph1.value + "-";
// 	tel += mainForm._ph2.value + "-";
// 	tel += mainForm._ph3.value;
	return tel;
}

function getAddr(){
	var mainForm = document.form;
// 	var addr = "[" + mainForm._post1.value + "-" + mainForm._post2.value + "]";
	var addr = mainForm._addr.value;
	return addr;
}

function phoneCheck(){
// 	var mainForm = document.form;
// 	var tmpHp1 = mainForm._ph2.value;
// 	var tmpHp2 = mainForm._ph3.value;
// 	var chkNum = 0;
// 	var chkEng = 0;
	
// 	if((tmpHp1 != null && tmpHp1 != "") || (tmpHp2 != null && tmpHp2 != "")){
// 		for(var i=0;i<tmpHp1.length;i++){
// 			if(tmpHp1.charAt(i)>='0' && tmpHp1.charAt(i)<='9'){
// 				chkNum++;	
// 			}
// 			else if(tmpHp1.charAt(i)>='a' && tmpHp1.charAt(i)<='z'){
// 				chkEng++;
// 			}
// 		}
// 		if(tmpHp1.length!=(chkNum+chkEng) || chkEng != 0 || tmpHp1.length < 3 || tmpHp1.length > 4){
// 			alert("Check Phone Number");
// 			return false;
// 		}
// 		chkNum = 0;
// 		chkEng = 0;
// 		for(i=0;i<tmpHp2.length;i++){
// 			if(tmpHp2.charAt(i)>='0' && tmpHp2.charAt(i)<='9'){
// 				chkNum++;	
// 			}
// 			else if(tmpHp2.charAt(i)>='a' && tmpHp2.charAt(i)<='z'){
// 				chkEng++;
// 			}
// 		}
// 		if(tmpHp2.length!=(chkNum+chkEng) || chkEng != 0 || tmpHp2.length != 4){
// 			alert("Check Phone Number");
// 			return false;
// 		}
// 	}
	return true;
}

function numberText(){
	if((event.keyCode < 48) || (event.keyCode > 57))
  	event.returnValue = false;
}

function hospitalCheck(){
	var mainForm = document.form;
	var tmpHospital = mainForm._company.value;
	var len = 0;
    for (var i=0; i<tmpHospital.length; i++) {
		len += (tmpHospital.charCodeAt(i) > 128) ? 2 : 1;
        if (len > 20){
        	alert("<fmt:message key='the_name_of_health_facilities_can_be_less_than_20_letters._Please_enter_again.' />");
       	  	mainForm._company.value = "";
        }
	}
}

//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/common/bt_initialize_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/common/bt_id_.gif','/PromesService/images/common/bt_X_.gif','/PromesService/images/common/bt_add2_.gif','/PromesService/images/common/bt_registration_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<table width="756" border="0" cellspacing="0" cellpadding="0">
	
	
   <tr>
     <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
       
       <tr>
         <td><table width="756" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td width="120" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='name_of_hospital' /></td>
               <td>&nbsp;
                   <input name="_company" type="text" class="inputbox" size="25" id="_company"  onkeydown="javascript:hospitalCheck();" /></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td height="1" bgcolor="#ececec"></td>
       </tr>
       <tr>
         <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td width="120" height="25" bgcolor="#e1eeef" class="td_table02"><fmt:message key='telephone' /></td>
               <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                   <tr>
<!--                      <td width="60">&nbsp; -->
<!--                          <select name="_ph1" class="select_white" style="width:50px"> -->
<%-- 	                        <option  value="02" <%if(phArr[0].equals("02")){ %> selected="true" <%} %> >02</option> --%>
<%-- 							<option  value="031" <%if(phArr[0].equals("031")){ %> selected="true" <%} %> >031</option> --%>
<%-- 							<option  value="032" <%if(phArr[0].equals("032")){ %> selected="true" <%} %> >032</option> --%>
<%-- 							<option  value="033" <%if(phArr[0].equals("033")){ %> selected="true" <%} %> >033</option> --%>
<%-- 							<option  value="041" <%if(phArr[0].equals("041")){ %> selected="true" <%} %> >041</option> --%>
<%-- 							<option  value="042" <%if(phArr[0].equals("042")){ %> selected="true" <%} %> >042</option> --%>
<%-- 							<option  value="043" <%if(phArr[0].equals("043")){ %> selected="true" <%} %> >043</option> --%>
<%-- 							<option  value="051" <%if(phArr[0].equals("051")){ %> selected="true" <%} %> >051</option> --%>
<%-- 							<option  value="052" <%if(phArr[0].equals("052")){ %> selected="true" <%} %> >052</option> --%>
<%-- 							<option  value="053" <%if(phArr[0].equals("053")){ %> selected="true" <%} %> >053</option> --%>
<%-- 							<option  value="054" <%if(phArr[0].equals("054")){ %> selected="true" <%} %> >054</option> --%>
<%-- 							<option  value="055" <%if(phArr[0].equals("055")){ %> selected="true" <%} %> >055</option> --%>
<%-- 							<option  value="061" <%if(phArr[0].equals("061")){ %> selected="true" <%} %> >061</option> --%>
<%-- 							<option  value="062" <%if(phArr[0].equals("062")){ %> selected="true" <%} %> >062</option> --%>
<%-- 							<option  value="063" <%if(phArr[0].equals("063")){ %> selected="true" <%} %> >063</option> --%>
<%-- 							<option  value="064" <%if(phArr[0].equals("064")){ %> selected="true" <%} %> >064</option> --%>
<%-- 							<option  value="010" <%if(phArr[0].equals("010")){ %> selected="true" <%} %> >010</option> --%>
<%-- 							<option  value="011" <%if(phArr[0].equals("011")){ %> selected="true" <%} %> >011</option> --%>
<%-- 							<option  value="016" <%if(phArr[0].equals("016")){ %> selected="true" <%} %> >016</option> --%>
<%-- 							<option  value="017" <%if(phArr[0].equals("017")){ %> selected="true" <%} %> >017</option> --%>
<!--                        </select></td> -->
<!--                      <td width="25" align="center" >-</td> -->
                     <td width="175" >&nbsp;&nbsp;<input name="_ph2" type="text" class="inputbox" size="25" id="_ph2"  onkeypress="javascript:numberText();"/></td>
<!--                      <td width="25" align="center" >-</td> -->
<!--                      <td width="90" ><input name="_ph3" type="text" class="inputbox" size="12" id="_ph3" style="ime-mode:disabled;" onkeypress="javascript:numberText();" /></td> -->
<!--                      <td class="inputbox" >&nbsp;</td> -->
                     <td >&nbsp;</td>
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
               <td width="120" height="55" bgcolor="#e1eeef" class="td_table02"><fmt:message key='address' /></td>
               <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
<!--                    <tr> -->
<!--                      <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0"> -->
<!--                        <tr> -->
<!--                          <td width="90">&nbsp; -->
<!--                            <input name="_post1" type="text" class="inputbox" size="12" id="_post1" style="ime-mode:disabled;" onkeypress="javascript:numberText();" /></td> -->
<!--                          <td width="25" align="center" >-</td> -->
<!--                          <td width="90" align="left" ><input name="_post2" type="text" class="inputbox" size="12" id="_post2" style="ime-mode:disabled;" onkeypress="javascript:numberText();" /></td> -->
<!--                          <td ><span class="inputbox"><a href="javascript:openPost();"><img src="/PromesService/images/common/bt_address.gif" width="80" height="18" border="0" id="Image6" onmouseover="MM_swapImage('Image6','','/PromesService/images/common/bt_address_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></span></td> -->
<!--                        </tr> -->
<!--                      </table></td> -->
<!--                    </tr> -->
                   <tr>
                     <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                           <td >&nbsp;
                               <input name="_addr" type="text" class="inputbox" size="70" id="_addr"  /></td>
                           <td class="inputbox" >&nbsp;</td>
                           <td >&nbsp;</td>
                         </tr>
                     </table></td>
                   </tr>
               </table></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td height="3" bgcolor="#a7c2bc"></td>
       </tr>
     </table></td>
   </tr>
   <tr>
     <td height="15">&nbsp;</td>
   </tr>
</table>
</form>
</body>
</html>