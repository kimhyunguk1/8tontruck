<%@page import="java.net.URLEncoder"%>
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
<%String content = Util.toString((String) request.getParameter("content"));%>
<%String memocontent = Util.toString((String) request.getParameter("memocontent"));%>
<%String memoId = Util.toString((String) request.getParameter("memoId"));%>
<%String categoryCode = Util.toString((String) request.getParameter("categoryCode"));%>
<%ArrayList categoryHash = (ArrayList) request.getSession().getAttribute("category"); %>
<%String takencheck = Util.toString((String) request.getParameter("takencheck")); %>                  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Detail Schedule</title>
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
	var rdbtn = document.getElementsByName("takencheck");
	var mainForm = document.form;
	mainForm.cmd.value = "updateError";
	mainForm._prescriptionId.value = '<%=prescriptionId%>';
	mainForm._userId.value = '<%=Util.toString(userId)%>';
	var type="";
// 	for (var i = 0 ; i < mainForm.category.length; i++)
// 	{
// 		if (mainForm.category[i].checked == true)
// 		{
// 			mainForm._errorCategory.value = mainForm.category[i].value;
// 			type = mainForm.category[i].value;
// 		}
// 	}
	
	if (type == '5')
	{
		mainForm._errorContent.value = mainForm.content.value;
	}
	else
	{
		mainForm._errorContent.value = "";
	}
	
	mainForm._memoId.value = '<%=memoId%>';
	mainForm._hospital.value = '<%=hospital%>';
	mainForm._day.value = '<%=day%>';
	mainForm._memoContent.value = mainForm.memocontent.value;	
	for(var i=0; i<rdbtn.length; i++){
		if(rdbtn[i].checked){
			mainForm._takencheck.value = rdbtn[i].value;			
		}
	}
	
	mainForm.target = "dosageInfoPage";
	mainForm.submit();
	this.close();
}

function updateDetailSchedule(){
	
	var tt = document.getElementById("buttonLink"); 
	
	var mainForm = document.form;
	mainForm.content.disabled = '';
	mainForm.memocontent.disabled='';
// 	for (var i = 0 ; i < mainForm.category.length; i++)
// 	{
// 		 mainForm.category[i].disabled = '';
// 	}
	tt.setAttribute("href", "javascript:saveDetailSchedule()");	
	document['buttonImg'].src = "/PromesService/images/common/bt_popup_submit.gif";
	document['buttonImg'].onmouseover = "MM_swapImage('Image3','','/PromesService/images/common/bt_popup_submit_.gif',1)"; 
	document['buttonImg'].onmouseout = "MM_swapImgRestore()";
}

function failType(value)
{
	var mainForm = document.form;
	
	if (value != '5')
	{
		mainForm.content.disabled = 'disabled';
	}
	else
	{
		mainForm.content.disabled = '';
	}
}

//-->
</script>
</head>
<body onload="initsize();MM_preloadImages('/PromesService/images/common/bt_popup_id_.gif','/PromesService/images/common/bt_popup_colse_.gif','/PromesService/images/common/bt_popup_revision_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_errorContent" type="hidden" value=""/>
<input name="_memoContent" type="hidden" value=""/>
<input name="_errorCategory" type="hidden" value=""/>
<input name="_memoId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<input name="_day" type="hidden" value=""/>
<input name="_takencheck" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="100%" align="center" valign="top" class="box01"><table width="418" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="11"></td>
      </tr>
      <tr style="display: none;">
        <td height="65" valign="top"><table width="418" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="54" align="left" valign="top" background="/PromesService/images/common/popup_im11.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120" height="22">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="td_table01">- <%=day %></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr style="display: none;">
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
            if (memocontent == null)
            {
            	memocontent = "";
            }
            if ( content  == null)
        	{
            	content = "";
        	}
            String contentscript = "";
           
            %>
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            		<%
            		String categorydisabledscript = "";
            		if (categoryCode != null)
            		{
            			categorydisabledscript = "disabled=\"disabled\"";
            		}
            		
            		for (int i = 0 ; i < categoryHash.size() ; i++)
            		{
            			CategoryInfo item = (CategoryInfo)categoryHash.get(i);
            			
            			String categoryscript = "";
            			
            			if (categoryCode == null)
            			{
            				categoryscript = "";
            			}
            			else if (categoryCode.trim().equals("null"))
            			{
            				categoryscript = "";
            			}
            			else if (categoryCode.trim().equals(item.getCategory_code().trim()))
            			{
            				categoryscript = "checked=\"checked\"";
            				//contentscript = "disabled=\"disabled\"";
            			}
            		%>
            			<tr width="100%">
            			<td>
            				<input type="radio" id="category" name="category" value="<%= item.getCategory_code()%>" onclick="javascript:failType('<%= item.getCategory_code()%>')" <%=categoryscript %> <%=categorydisabledscript %> /><%= item.getCategory_name()%><br>
            			</td>
            			</tr>
            		<%
            		}
            		if (categoryCode != null || memocontent !="")
            		{
            			contentscript = "disabled=\"disabled\"";
            		}
            
            		%>
              		<tr width="100%">
              			<td width="100%">
              				<input name="content" type="text"   value="<%=content.replace("<br>", "\r\n") %>" size="56" maxlength="50" />
              				
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
            <td>&nbsp;</td>
      </tr>
      <tr>
            <td height="54" align="left" valign="top" background="/PromesService/images/common/popup_im12.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120" height="22">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="td_table01">
                <%
                	if(takencheck == null)
                	{
                		takencheck="";
                	}
                		
                	if(takencheck.equals("1"))
                	{                		
                %>
                		<input type="radio" id ="takencheck" name="takencheck" value="1" checked><fmt:message key='medication' />
                   		<input type="radio" id ="takencheck" name="takencheck" value="0"><fmt:message key='non-medication' /><br>
                <%
                	}else if(takencheck.equals("0")){
				%>
						<input type="radio" id ="takencheck" name="takencheck" value="1"><fmt:message key='medication' />
                   		<input type="radio" name="takencheck" value="0" checked><fmt:message key='non-medication' /><br>
				<%               
                	}else{
                %>
               			<input type="radio" id ="takencheck" name="takencheck" value="1"><fmt:message key='medication' />
                   		<input type="radio" id ="takencheck" name="takencheck" value="0" ><fmt:message key='non-medication' /><br>
				<%}%>           
                   
                </td>
              </tr>            
            </table></td>
      </tr>
      <tr>
      	<td>&nbsp;</td>
      </tr>
      <tr>
            <td height="54" align="left" valign="top" background="/PromesService/images/common/popup_im09.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120" height="22">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="td_table01">
                </td>
              </tr>            
            </table></td>
      </tr>
      <tr width="100%">
          <td width="100%">
              	<textarea id="memocontent" name="memocontent" rows="10" cols="56"  ><%=memocontent.replace("<br>", "\r\n")%></textarea>              	
           </td>
      </tr>
      <tr>
        <td align="center"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="10" colspan="2"></td>
          </tr>
          <tr>
        	<td><a href="javascript:popupClose();"><img src="/PromesService/images/common/bt_popup_colse.gif" width="47" height="19" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_popup_colse_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
            <%
            if (categoryCode == null && (memocontent == null || memocontent == ""))
            {
            %>
            <td><a href="javascript:saveDetailSchedule();"><img src="/PromesService/images/common/bt_popup_submit.gif" width="47" height="19" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_popup_submit_.gif',1)" onmouseout="MM_swapImgRestore()"/></a></td>
            <%
            }
            else
            {
            %>
<!--            	<td><a id="buttonLink" name="buttonLink" href="javascript:updateDetailSchedule();"><img name="buttonImg" src="/PromesService/images/common/bt_popup_revision.gif" width="47" height="19" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_popup_revision_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td> -->
			<td><a id="buttonLink" name="buttonLink" href="javascript:saveDetailSchedule();"><img name="buttonImg" src="/PromesService/images/common/bt_popup_revision.gif" width="47" height="19" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_popup_revision_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
           	<%
           	}
           	%>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="11"></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
