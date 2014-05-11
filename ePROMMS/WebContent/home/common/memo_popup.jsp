<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.Define"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.CategoryInfo"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%String prescriptionId = (String) request.getParameter("prescriptionId");%>
<%String type = (String) request.getParameter("type");%>
<%String userId = (String) request.getParameter("userId");%>
<%String day = Util.toString((String) request.getParameter("day"));%>
<%String hospital = Util.toString((String) request.getParameter("hospital"));%>
<%String memoContent = Util.toString((String) request.getParameter("memo"));%>
<%String memoId = Util.toString((String) request.getParameter("memoId"));%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Detail Schedule [${param.day }]</title>
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

function initsize()
{
	var mainForm = document.form;
}

function popupClose(){	
	this.close();
}

function saveDetailSchedule()
{
	var mainForm = document.form;
	mainForm.cmd.value = "updateMemo";
	mainForm._prescriptionId.value = '<%=prescriptionId%>';	
	mainForm._userId.value = '<%=Util.toString(userId)%>';
	mainForm._memoContent.value = mainForm.content.value;
	mainForm._memoId.value = '<%=memoId%>';
	mainForm._hospital.value = '<%=hospital%>';
	mainForm._day.value = '<%=day%>';
	mainForm.target = "dosageInfoPage";
	mainForm.submit();
	this.close();
}

function updateDetailSchedule()
{
	var mainForm = document.form;
	mainForm.content.disabled = '';
	
	mainForm._prescriptionId.value = '<%=prescriptionId%>';
	
	 
	buttonLink.href="javascript:saveDetailSchedule()";
	document['buttonImg'].src = "/PromesService/images/common/bt_popup_submit.gif";
	document['buttonImg'].onmouseover = "MM_swapImage('Image3','','/PromesService/images/common/bt_popup_submit_.gif',1)"; 
	document['buttonImg'].onmouseout = "MM_swapImgRestore()";
}

//-->
</script>
</head>
<body onload="initsize();MM_preloadImages('/PromesService/images/common/bt_popup_id_.gif','/PromesService/images/common/bt_popup_colse_.gif','/PromesService/images/common/bt_popup_revision_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_memoContent" type="hidden" value=""/>
<input name="_memoId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<input name="_day" type="hidden" value=""/>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top" ><table width="418" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="5">${userId }</td>
      </tr>
      <tr>
        <td valign="top"><table width="418" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="54" align="left" valign="top" background="/PromesService/images/common/popup_im09.gif">
            			<select id="_takenStatus" name="_takenStatus" class="select_white" style="width:120px; margin-left: 220px; margin-top: 20px">
                			<option value="NONE"   <c:if test="${param.takenStatus eq 'NONE' }">selected</c:if> ><fmt:message key='none' /></option>
							<option value="FINISHTAKEN" <c:if test="${param.takenStatus eq 'FINISHTAKEN' }">selected</c:if>  ><fmt:message key='finishtaken' /></option>
                        	<option value="DELAYTAKEN" <c:if test="${param.takenStatus eq 'DELAYTAKEN' }">selected</c:if> ><fmt:message key='delaytaken' /></option>
                        	<option value="UNTAKEN"  <c:if test="${param.takenStatus eq 'UNTAKEN' }">selected</c:if> ><fmt:message key='untaken' /></option>
                        	<option value="FINISHOUTTAKEN" <c:if test="${param.takenStatus eq 'FINISHOUTTAKEN' }">selected</c:if> ><fmt:message key='outtaken' /></option>
                    </select>
            </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="11"></td>
      </tr>
      
      <tr>
        <td valign="top"><table width="418" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="5" height="5" background="/PromesService/images/common/box_a_1_1.gif"></td>
            <td background="/PromesService/images/common/box_a_1_2.gif"></td>
            <td width="5" height="5" background="/PromesService/images/common/box_a_1_3.gif"></td>
          </tr>
          <tr>
            <td background="/PromesService/images/common/box_a_2_1.gif">&nbsp;</td>
            <td align="center" valign="top">
            <%
            String contentscript = "";
            
            if (memoContent == null)
        	{
            	contentscript = "";
        		memoContent = "";
        	}
            else
            {
            	//contentscript = "disabled=\"disabled\"";
            	memoContent = memoContent.replace("<br>", "\r\n");
            }
            %>
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              		<tr width="100%">
              			<td width="100%" height="150">
              				<textarea name="content" rows="10" cols="56" placeholder="<fmt:message key='memo' />"<%=contentscript %>><%=memoContent%></textarea>
              			</td>
              		</tr>
            	</table>
            </td>
            <td background="/PromesService/images/common/box_a_2_2.gif">&nbsp;</td>
          </tr>
          <tr>
            <td height="5" background="/PromesService/images/common/box_a_3_1.gif"></td>
            <td background="/PromesService/images/common/box_a_3_2.gif"></td>
            <td background="/PromesService/images/common/box_a_3_3.gif"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td height="11"></td>
      	  </tr>
          <tr>
            <td><a href="javascript:popupClose();"><img src="/PromesService/images/common/bt_popup_colse.gif" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_popup_colse_.gif',1)" onmouseout="MM_swapImgRestore()" style="padding-right: 5px;"/></a></td>
            <%
            if(memoContent == "")
            {
            %>
			<td><a href="javascript:saveDetailSchedule();"><img src="/PromesService/images/common/bt_popup_submit.gif" width="47" height="19" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_popup_submit_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>            	
            <%
            }
            else
            {
            %>
         		<td><a name="buttonLink" href="javascript:saveDetailSchedule();"><img name="buttonImg" src="/PromesService/images/common/bt_popup_revision.gif" width="47" height="19" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_popup_revision_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
            <%
            } 
            %>
          </tr>
        </table></td>
      </tr>    
      </table></td>
  </tr>
</table>
</form>
</body>
</html>
