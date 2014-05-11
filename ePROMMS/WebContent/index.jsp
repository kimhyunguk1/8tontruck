<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%String message = (String) request.getAttribute("message");%>
<%String userId = (String) request.getAttribute("userId");%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<fmt:setBundle basename="lang_fr"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
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

function init(){
	var mainForm = document.form;
	<%if(message != null && !message.equals("")){%>
			alert("<%=message%>");
	<%}%>
	<%if(userId != null && !userId.equals("")){%>
		mainForm._userId.value = '<%=userId%>';
	<%}%>
}

function initsize() {
	//mainPage.resizeTo(mainPage.document.body.scrollWidth, mainPage.document.body.scrollHeight);
	var _height = document.getElementById('mainPage').contentWindow.document.body.scrollHeight;
    document.getElementById('mainPage').height=_height;
}

function login(){
	var mainForm = document.form;
	var userId = mainForm._userId.value;
	var userPw = mainForm._userPw.value;
	if(userId == null || userId == ''){
		alert("<fmt:message key='enter_your_ID' />");
	}else if(userPw == null || userPw == ''){
		alert("<fmt:message key='enter_your_password' />");
	}else{
		mainForm.cmd.value = 'login';
		mainForm.submit();
	}
}

function loadAddUser(){
	var tmpHtml = "";
	tmpHtml ="<iframe name=\"mainPage\" id=\"mainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadJoinPage\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	mainDiv.innerHTML = tmpHtml;
}

function reloadPage(){
	var tmpHtml = "";
	tmpHtml ="<iframe name=\"mainPage\" id=\"mainPage\" src=\"/PromesService/mainPage.jsp\" frameborder=\"0\" scrolling=\"no\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>"
	mainDiv.innerHTML = tmpHtml;
}



function test()
{
	var mainForm = document.form;
	mainForm.cmd.value = 'LoadPrescriptionList';
	mainForm.submit();
// 	alert('alert');
// 	confirm('confirm');
	
	/* var mainForm = document.form;
	mainForm.cmd.value = 'TBFREE_FileSend';
	mainForm.submit();	 */
}

//-->

</script>
<%-- <c:out value="${pageContext.session.maxInactiveInterval} "></c:out> --%>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_login_.gif','/PromesService/images/common/bt_member_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
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
                <td width="190"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="center"><img src="/PromesService/images/common/left_title_login.gif" width="136" height="17" /></td>
                  </tr>
                  <tr>
                    <td height=19 align="center">&nbsp;<a href="javascript:test();"> ㅁㄴㅇ </a></td>
                  </tr>
				  <tr>
                    <td height="22"></td>
                  </tr>
                  <tr>
                    
                        <td align="center"><input placeholder="ID"  name="_userId" type="text" class="inputbox" size="12" id="_userId" style="margin-bottom: 10px"/></td>
                      
                  </tr>
                  <tr>
                        <td align="center"><input name="_userPw" placeholder="Password" type="password" class="inputbox" size="12" id=""_userPw="" onkeydown="javascript:if(event.keyCode==13){login();}" style="text-transform:lowercase; margin-bottom: 20px" /></td>
                     
                  </tr>
                  
                 
                  <tr>
                    <td height="100%" align="center" ><table width="130" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                        	<a href="javascript:login();">
                        		<img src="/PromesService/images/common/bt_login.gif" width="59" height="27" id="Image1" border="0" onmouseover="MM_swapImage('Image1','','/PromesService/images/common/bt_login_.gif',1)" onmouseout="MM_swapImgRestore()" />
                        	</a>
                        </td>
                        <td align="right">
                        	<a href="javascript:loadAddUser();">
                        	<img src="/PromesService/images/common/bt_member.gif" width="59" height="27" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_member_.gif',1)" onmouseout="MM_swapImgRestore()" />
                        	</a>
                        </td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
        <td align="left" valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="30">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td width="30">&nbsp;</td>
            <td>
	            <div id="mainDiv">
			    	<iframe name="mainPage" id="mainPage" src="/PromesService/mainPage.jsp" frameborder="0" scrolling="no" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
				</div>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td background="/PromesService/images/common/bottom_im_bg.gif"><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="38" align="left"><img src="/PromesService/images/common/bottom_im_left.gif" width="38" height="48" /></td>
        <td align="right" class="td_copy">COPYRIGHT BY Jeyun Inst. LTD. All RIGHTS RESEVED..</td>
        <td width="30" class="td_copy">&nbsp;</td>
        <td width="122" align="right"><!--<img src="/PromesService/images/common/bottom_im_logo.gif" width="122" height="48" />--></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
