<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%String id = (String) request.getAttribute("id");%>
<%String result = (String) request.getAttribute("result");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='confirm_the_repeat_ID' /></title>
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

function popupClose(){
	this.close();
}

function checkId(){
	var mainForm = document.form;
	var id = mainForm._id.value;
	if(id == null || id == ""){
		alert("<fmt:message key='enter_your_ID' />");
		return;
	}
	
	var count = 0;
	if(id.length<3 || id.length>12){
		alert("<fmt:message key='the_characters_of_ID_should_be_3~12.' />");
		return;
	}
	for(i=0;i<id.length;i++){
		if(id.charAt(i)!='"'){
			count++;
		}
	}
	if(id.length!=count){
		alert(" <fmt:message key="your_ID_can't_be_used_here." />");
		return;
	}
	if(id=="admin"){
		alert("<fmt:message key="your_ID_can't_be_used_here." />");
		return;
	}
	mainForm.cmd.value = 'checkId';
	mainForm.submit();
}

function setId(){
	opener.setId('<%=id%>', 'false');
	this.close();
}

function init(){
	var mainForm = document.form;
	mainForm._id.focus();
}

//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_popup_id_.gif','/PromesService/images/common/bt_popup_colse_.gif','/PromesService/images/common/bt_popup_use_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet" onsubmit="return false">
<input name="cmd" type="hidden" value=""/>
<table width="364" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="364" height="230" align="center" valign="top" class="box01"><table width="340" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="11"></td>
      </tr>
      <tr>
        <td height="65" valign="top"><img src="/PromesService/images/common/popup_im03.gif" width="340" height="54" /></td>
      </tr>
      <tr>
        <td height="143" valign="top"><table width="340" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="5" height="5" background="/PromesService/images/common/box_a_1_1.gif"></td>
            <td background="/PromesService/images/common/box_a_1_2.gif"></td>
            <td width="5" height="5" background="/PromesService/images/common/box_a_1_3.gif"></td>
          </tr>
          <tr>
            <td background="/PromesService/images/common/box_a_2_1.gif">&nbsp;</td>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" align="center" valign="middle"><table width="300" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="middle"><table border="0" cellspacing="0" cellpadding="0">
                    	<%if(!result.equals("true")){ %>
                    	<tr>
                    		<td width="20" height="20"><img src="/PromesService/images/common/popup_icon_01.gif" width="12" height="12" /></td>
                    		<td class="td_table01"><%=id %>&nbsp;</td>
                    		<td class="td_popup_d"><fmt:message key='your_ID_can_be_used.' /></td>
                    	</tr>
                    	<tr>
                    		<td colspan="3" align="center"><a href="javascript:setId();"><img src="/PromesService/images/common/bt_popup_use.gif" width="52" height="19" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_popup_use_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
						</tr>
						<%}else{ %>
						<tr>
                    		<td width="20" height="20"><img src="/PromesService/images/common/popup_icon_01.gif" width="12" height="12" /></td>
                    		<td class="td_table02"><%=id %>&nbsp;</td>
                    		<td class="td_popup_r"><fmt:message key='your_ID_was_already_used._' /></td>
                    	</tr>
						<%} %>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="21" align="center"><img src="/PromesService/images/common/popup_line_01.gif" width="326" height="1" /></td>
              </tr>
              <tr>
                <td align="center"><table table width="300" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                  	<td colspan="2"><table border="0" cellspacing="0" cellpadding="0">
                  		<tr>
	                  		<td width="20" height="20"><img src="/PromesService/images/common/popup_icon_02.gif" width="12" height="12" /></td>
							<td class="td_table02_"><fmt:message key='if_you_want_to_use_different_ID.' /></td>
						</tr>
						<tr>
							<td colspan="2" class="td_popup_d"><fmt:message key='confirm_the_repeat_ID_after_entering_ID' /></td>
						</tr>
                  	</table></td>
                  </tr>
                  <tr>
                    <td><input name="_id" type="text" class="inputbox" size="20" id="_id" onkeydown="javascript:if(event.keyCode==13){checkId();}" /></td>
                    <td><a href="javascript:checkId();"><img src="/PromesService/images/common/bt_popup_id.gif" id="Image1" border="0" onmouseover="MM_swapImage('Image1','','/PromesService/images/common/bt_popup_id_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
              	<td height="10">&nbsp;</td>
              </tr>
            </table></td>
            <td background="/PromesService/images/common/box_a_2_2.gif">&nbsp;</td>
          </tr>
          <tr>
            <td height="5" background="/PromesService/images/common/box_a_3_1.gif"></td>
            <td background="/PromesService/images/common/box_a_3_2.gif"></td>
            <td background="/PromesService/images/common/box_a_3_3.gif"></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
