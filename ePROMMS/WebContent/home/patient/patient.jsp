<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page import="java.util.Hashtable"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%UserInfo userInfo = (UserInfo)request.getAttribute("userInfo"); %>
<%String type = (String)request.getAttribute("type"); %>
<%Hashtable countHash = (Hashtable)request.getAttribute("countHash"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Patient</title>
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

function initsize() {
	//patientMainPage.resizeTo(patientMainPage.document.body.scrollWidth, patientMainPage.document.body.scrollHeight);
	var _height = document.getElementById('patientMainPage').contentWindow.document.body.scrollHeight;
    document.getElementById('patientMainPage').height=_height;
}

function getId(){
	<%
		if(userInfo != null){
		%>
			var mainForm = document.form;
			mainForm.userId.value = '<%=userInfo.getId()%>';
			return '<%=userInfo.getId()%>';
		<%}
	%>
	return '';
}

function getType(){
	<%
		if(userInfo != null){
		%>
			return '<%=userInfo.getType()%>';
		<%}
	%>
	return '';
}

function changeMenu(value){
// 	var tmpHtml = "";
// 	tmpHtml += "<table width=\"156\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
// 	tmpHtml += "<tr><td align=\"right\">";
// 	if(value == 'list'){
// 		changeTitle('처방목록');
// 		tmpHtml += "<img src=\"/PromesService/images/patient/left_menu_b_.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" /></td>";
// 	    tmpHtml += "</tr><tr>";
// 	    tmpHtml += "<td align=\"right\"><a href=\"javascript:changeMenu('view');\"><img src=\"/PromesService/images/patient/left_menu_c.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image51\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/patient/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	}else if(value == 'view'){
// 		changeTitle('복용현황');
// 		tmpHtml +="<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/pharmacist/left_menu_b.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image41','','/PromesService/images/pharmacist/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<img src=\"/PromesService/images/pharmacist/left_menu_c_.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image51\" /></td>";
// 	}else if(value == 'none'){
// 		tmpHtml +="<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/pharmacist/left_menu_b.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image41','','/PromesService/images/pharmacist/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('view');\"><img src=\"/PromesService/images/patient/left_menu_c.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image51\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/patient/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	}
// 	else if(value == 'modify'){
// 		changeTitle('시작일 등록');
// 		tmpHtml +="<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/pharmacist/left_menu_b.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image41','','/PromesService/images/pharmacist/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('view');\"><img src=\"/PromesService/images/patient/left_menu_c.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image51\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/patient/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	}else if(value == 'dosage'){
// 		changeTitle('복용현황');
// 		tmpHtml +="<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/pharmacist/left_menu_b.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image41','','/PromesService/images/pharmacist/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<img src=\"/PromesService/images/pharmacist/left_menu_c_.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image51\" /></td>";
// 	}
// 	tmpHtml += "</tr><tr><td align=\"right\">&nbsp;</td></tr></table>"
// 	patientMenu.innerHTML = tmpHtml;
// 	if(value != 'modify' && value != 'dosage' && value != 'none'){
// 		changeMain(value);
// 	}
}

function changeMain(value){
// 	var tmpHtml = "";
// 	if(value == 'list'){
<%-- 		tmpHtml ="<iframe name=\"patientMainPage\" id=\"patientMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadSearchPrescriptionPage&_userId=<%=userInfo.getId()%>&_type=PATIENT&_userName=<%=userInfo.getName()%>\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>"; --%>
// 	}else if(value == 'view'){
<%-- 		tmpHtml ="<iframe name=\"patientMainPage\" id=\"patientMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadPatientDosagePage&_userId=<%=userInfo.getId()%>\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>"; --%>
// 	}
// 	patientMain.innerHTML = tmpHtml;
}

function loadModify(){
	changeMenu("modify");
	var tmpHtml = "";
	tmpHtml ="<iframe name=\"patientMainPage\" id=\"patientMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadModifyUserInfoPage&userId=<%=userInfo.getId()%>&type=<%=type%>\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	patientMain.innerHTML = tmpHtml;
}

function changeTitle(title){
	titleDiv.innerHTML = title;
}
//-->
</script>
</head>
<body onload="MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/doctor/left_menu_c_.gif','/PromesService/images/common/bt_inquiry_.gif','/PromesService/images/common/bt_internal_.gif','/PromesService/images/common/bt_start_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="userId" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="/PromesService/images/common/top_im_bg.gif"><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="1024"><img src="/PromesService/images/common/top_im_title.jpg" width="1024" height="130" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="197" valign="top"><table width="197" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="530" valign="top" background="/PromesService/images/common/left_im_bg.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>&nbsp;</td>
                <td width="190" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="center"><table width="144" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="55" align="left" class="td_login">[<%=userInfo.getName() %>]</td>
                        <td align="left" class="td_login2"><fmt:message key='Hello'/></td>
                      </tr>
                    </table></td>
                  </tr>
                  <%if(userInfo.getName().getBytes().length < 8){ %>
                  <tr>
                    <td height="29">&nbsp;</td>
                  </tr>
                  <%}else{ %>
                  <tr>
                    <td height="15"></td>
                  </tr>
                  <%} %>
                  <tr>
                    <td align="center"><table width="115" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="10"><img src="/PromesService/images/common/icon_login.gif" width="3" height="5" /></td>
                        <%if(countHash != null){ %>
                        	<td align="left"><fmt:message key='total_schedule'/> : <%=countHash.get("total")%></td>
                        <%}else{ %>
                        	<td align="left"><fmt:message key='total_schedule'/> : 0</td>
                        <%} %>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="5"></td>
                  </tr>
                  <tr>
                    <td align="center"><table width="115" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="10"><img src="/PromesService/images/common/icon_login.gif" width="3" height="5" /></td>
                        <%if(countHash != null && countHash.containsKey("0")){ %>
                        	<td align="left"><fmt:message key='non--registered_schedule'/> : <%=countHash.get("0")%></td>
                        <%}else{ %>
                        	<td align="left"><fmt:message key='non--registered_schedule'/> : 0</td>
                        <%} %>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="49" align="center" valign="bottom"><table width="145" border="0" cellspacing="0" cellpadding="0">
                      <tr>
<!--                         <td><a href="javascript:loadModify();"><img src="/PromesService/images/common/bt_individual.gif" width="82" height="27" border="0" id="Image1" onmouseover="MM_swapImage('Image1','','/PromesService/images/common/bt_individual_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td> -->
                        <td align="left"><a href="/PromesService/index.jsp"><img src="/PromesService/images/common/bt_logout.gif" width="59" height="27" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_logout_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="20" align="center" valign="bottom">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="13" align="center" valign="bottom"><div id="patientMenu"><table width="156" border="0" cellspacing="0" cellpadding="0">
<!--                       <tr> -->
<!--                         <td align="right"><img src="/PromesService/images/patient/left_menu_b_.gif" name="Image41" width="154" height="26" border="0" id="Image41" /></td> -->
<!--                       </tr> -->
                      <tr>
                        <td align="right"><img src="/PromesService/images/patient/left_menu_c_.gif" name="Image51" width="154" height="26" border="0" id="Image51" onmouseover="MM_swapImage('Image51','','/PromesService/images/patient/left_menu_c_.gif',1)" onmouseout="MM_swapImgRestore()" /></td>
                      </tr>
                      <tr>
                        <td align="right">&nbsp;</td>
                      </tr>
                    </table></div></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
        <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="30">&nbsp;</td>
            <td align="right"><table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><img src="/PromesService/images/common/icon_history.gif" width="12" height="5" /></td>
                <td >Home</td>
                <td >ㅣ</td>
                <td ><div id="titleDiv"><fmt:message key='medication_status'/></div>
                <td width="40" ></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td width="30">&nbsp;</td>
            <td>
           		<div id="patientMain">
           			<iframe name="patientMainPage" id="patientMainPage" src="/PromesService/PromesServerServlet?cmd=loadPatientDosagePage&_userId=<%=userInfo.getId()%>" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
<%-- 	            	<iframe name="patientMainPage" id="patientMainPage" src="/PromesService/PromesServerServlet?cmd=loadSearchPrescriptionPage&_userId=<%=userInfo.getId()%>&_type=PATIENT&_userName=<%=userInfo.getName()%>" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe> --%>
	            </div>
            </td>
          </tr>
        </table>
          </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td background="/PromesService/images/common/bottom_im_bg.gif"><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="38" align="left"><img src="/PromesService/images/common/bottom_im_left.gif" width="38" height="48" /></td>
        <td align="right" class="td_copy">COPYRIGHT BY Jeyun Inst. LTD. All RIGHTS RESEVED.</td>
        <td width="30" class="td_copy">&nbsp;</td>
        <td width="122" align="right"><!--<img src="/PromesService/images/common/bottom_im_logo.gif" width="122" height="48" />--></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
