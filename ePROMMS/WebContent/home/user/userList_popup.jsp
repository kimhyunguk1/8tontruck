<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="lang_fr"/>
<%ArrayList userList = (ArrayList)request.getAttribute("userList");%>
<%String target = (String)request.getAttribute("target");%>
<%String pageIdx = (String)request.getAttribute("pageIdx");%>
<%String maxPageIdx = (String)request.getAttribute("maxPageIdx");%>
<%String userName = (String)request.getAttribute("userName");%>
<%String sortType = (String)request.getAttribute("sortType");%>
<%String sortCourse = (String)request.getAttribute("sortCourse");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 User Info List</title>
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

function choiceUser(value, value1, value2,value3)
{		
	if(value1 == ''){
		alert("<fmt:message key='there_is_no_the_registered_pillbox' />");
		this.close;
	}
	opener.choiceUser(value, value1, value2, '<%=target%>');
	this.close();	
}

function initsize() {	
	sortTableDiv();
	<%
	if(userList != null && userList.size() != 0){
		if(userList.size()== 1 && pageIdx.equals("1")){
			UserInfo userInfo = (UserInfo) userList.get(0);
			
			if (userInfo.getPillBoxs().size() > 0)
			{%>
				choiceUser('<%=userInfo.getId()%>', '<%=userInfo.getPillBoxs().get(0).getId()%>', '<%=userInfo.getPillBoxs().get(0).getType()%>', '<%=target%>');
		  <%}
			else
			{%>
				choiceUser('<%=userInfo.getId()%>', "", "", '<%=target%>');
		  <%}
			
		}
	}
	else
	{%>
		alert("<fmt:message key='check_up_the_name_of_patients' />");
		opener.returnUserName();
		this.close();
	<%}%>
}

function changePage(idx, value){
	var mainForm = document.form;
	mainForm.cmd.value = 'loadUserListPopupPage';
	mainForm._userName.value = '<%=userName%>';
	mainForm._target.value = '<%=target%>';

	var pageIdx = '<%=pageIdx%>';
	if(value == null){
		pageIdx = idx;
	}else{
		if(value == 'sub'){
			pageIdx = Number(pageIdx) - 1;
		}else{
			pageIdx = Number(pageIdx) + 1;
		}
	}
	<%if(sortType != null && !sortType.equals("")){%>
		mainForm._sortType.value = '<%=sortType%>';
	<%}%>
	<%if(sortType != null && !sortType.equals("")){%>
		mainForm._sortCourse.value = '<%=sortCourse%>';
	<%}%>
	mainForm._pageIdx.value = pageIdx;
	mainForm.submit();
}

function sortTable(type){
	var mainForm = document.form;
	mainForm.cmd.value = 'loadUserListPopupPage';
	mainForm._sortType.value = type;
	mainForm._sortCourse.value = "UP";
	<%if(sortType != null && !sortType.equals("")){%>
		if(type == '<%=sortType%>'){
			<%if(sortCourse != null && !sortCourse.equals("")){
				if(sortCourse.equals("UP")){%>
					mainForm._sortCourse.value = "DOWN";
				<%}%>
			<%}%>
		}
	<%}%>
	mainForm._pageIdx.value = '<%=pageIdx%>';
	mainForm._userName.value = '<%=userName%>';
	mainForm._target.value = '<%=target%>';
	mainForm.submit();
}

function sortTableDiv(){
	<%
	if(sortType != null && !sortType.equals("")){
	%>
		var tmpHtml = "";
		<%if(sortCourse.equals("UP")){%>
			tmpHtml = "<img src=\"/PromesService/images/common/icon_07_b.gif\" width=\"7\" height=\"12\" />";
		<%}else{%>
			tmpHtml = "<img src=\"/PromesService/images/common/icon_07_a.gif\" width=\"7\" height=\"12\" />";
		<%}
		if(sortType.equals("ID")){%>
			tableDiv[0].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[0].innerHTML = "";
		<%}
		if(sortType.equals("NAME")){%>
			tableDiv[1].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[1].innerHTML = "";
		<%}
		if(sortType.equals("PHONE")){%>
			tableDiv[2].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[2].innerHTML = "";
		<%}
		if(sortType.equals("EMAIL")){%>
			tableDiv[3].innerHTML = tmpHtml;
		<%}else {%>
			tableDiv[3].innerHTML = "";
		<%}%>
	<%}else{%>
		tableDiv[0].innerHTML = "";
		tableDiv[1].innerHTML = "";
		tableDiv[2].innerHTML = "";
		tableDiv[3].innerHTML = "";
	<%}%>
}

//-->
</script>
</head>
<body onload="initsize();MM_preloadImages('/PromesService/images/pharmacist/bt_input_.gif','/PromesService/images/pharmacist/bt_cancel_.gif')">
<form name="form" method="post"	action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value="" />
<input name="_userId" type="hidden" value="" />
<input name="_userName" type="hidden" value="" />
<input name="_target" type="hidden" value="" />
<input name="_pageIdx" type="hidden" value=""/>
<input name="_sortType" type="hidden" value=""/>
<input name="_sortCourse" type="hidden" value=""/>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="80" valign="top"><img src="/PromesService/images/common/popup_im05.gif" width="700" height="67" /></td>
  </tr>
  <tr>
    <td align="center"><table width="650" border="0" cellpadding="1" cellspacing="1" bgcolor="#d0d0d0">
	<tr>
		<td height="22" width="100" bgcolor="#e4eff0" class="td_table02"><table width="100" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('ID');">ID</td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="100" bgcolor="#e4eff0" class="td_table02"><table width="100" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('NAME');"><fmt:message key='patient_name' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="180" bgcolor="#e4eff0" class="td_table02"><table width="180" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('PHONE');"><fmt:message key='telephone' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td bgcolor="#e4eff0" class="td_table02"><table width="180" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('EMAIL');">EMAIL</td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
	</tr>
	<tr>
        <td height="2" colspan="7" bgcolor="#8fafa8"></td>
    </tr>
    	<%
    	String tmpColot = "#FFFFFF";
    	if(userList != null && userList.size() > 0){
    		for(int i = 0; i < userList.size();i++){
				UserInfo userInfo = (UserInfo)userList.get(i);
				if(i % 2 != 0){
	  				tmpColot = "#edfaf7";
	  			}else{
	  				tmpColot = "#FFFFFF";
	  			}
				%>
				<tr>
		   			<td height="22" align="center" bgcolor="<%=tmpColot %>">
		   			<!-- <a href="javascript:choiceUser('<%=userInfo.getId() %>')"><%=userInfo.getId() %></a></td> -->
		   			<%if(userInfo.getPillBoxs().size() >0){ %>
		   				<a href="javascript:choiceUser('<%=userInfo.getId()%>', '<%=userInfo.getPillBoxs().get(0).getId()%>', '<%=userInfo.getPillBoxs().get(0).getType()%>', '<%=target%>')"><%=userInfo.getId() %></a></td>		   				
		   			<%}else{ %>
		   				<a href="javascript:choiceUser('<%=userInfo.getId()%>', '', '', '<%=target%>')"><%=userInfo.getId() %></a></td>
		   			<%} %>
		   			<td align="center" bgcolor="<%=tmpColot %>"><%=userInfo.getName() %></td>
		   			<td align="center" bgcolor="<%=tmpColot %>"><%=Util.toWebString(userInfo.getPh()) %></td>
		   			<td align="center" bgcolor="<%=tmpColot %>"><%=userInfo.getE_mail() %></td>
		   		</tr>
				<%
    		}
    		for(int x=userList.size();x < 5;x++){
        		if(x % 2 != 0){
    					tmpColot = "#edfaf7";
    				}else{
    					tmpColot = "#FFFFFF";
    				}
    			%>
    			 <tr>
    		        <td height="22" bgcolor="<%=tmpColot %>">&nbsp;</td>
    		        <td bgcolor="<%=tmpColot %>">&nbsp;</td>
    		        <td bgcolor="<%=tmpColot %>">&nbsp;</td>
    		        <td bgcolor="<%=tmpColot %>">&nbsp;</td>
      			</tr>
    			<%
        	}
    	}else{
    		for(int i = 0;i < 5;i++){
   				if(i % 2 != 0){
   					tmpColot = "#edfaf7";
   				}else{
   					tmpColot = "#FFFFFF";
   				}
    			%>
    			 <tr>
			        <td height="22" bgcolor="<%=tmpColot %>">&nbsp;</td>
			        <td bgcolor="<%=tmpColot %>">&nbsp;</td>
			        <td bgcolor="<%=tmpColot %>">&nbsp;</td>
			        <td bgcolor="<%=tmpColot %>">&nbsp;</td>
      			</tr>
    			<%
    		}
    	}    	
    	%>
    </table></td>
  </tr>
  <tr>
    <td height="5">&nbsp;</td>
  </tr>
  <tr>
    <td height="2" bgcolor="#aac7cb"></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
</table>
<table width="700" border="0">
	<tr>
		<td height="23" align="center" bgcolor="#FFFFFF"><table width="700" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center"><table border="0" cellspacing="0" cellpadding="0">
					<%
					if(pageIdx == null){
						pageIdx = "0";
						maxPageIdx = "0";
					}
					if(Integer.parseInt(pageIdx) == 1){ %>
						<td align="center"><img src="/PromesService/images/common/icon_04.gif" width="10" height="9" /></td>
					<%}else{ %>
						<td align="center"><a href="javascript:changePage('','sub');"><img src="/PromesService/images/common/icon_04.gif" border="0" width="10" height="9" /></a></td>
					<%} %>
					<td width="5">
					</td>
				<%for(int i = 0;i < Integer.parseInt(maxPageIdx);i++){
					if(pageIdx.equals(""+(i+1))){%>
						<td align="center" valign="bottom" width="15" class="td_table11">
						<font class="#3c5f84"><%=(i+1)%></font>
					<%}else{%>
						<td align="center" valign="bottom"  width="10" class="td_table11_">
						<a href="javascript:changePage('<%=(i+1)%>');"><font color="#3c5f84"><%=(i+1)%></font></a>
					<%}%>
					</td>
					<td width="5">
					</td>
				<%}%>
					<%if(Integer.parseInt(maxPageIdx) == Integer.parseInt(pageIdx)){ %>
						<td align="center"><img src="/PromesService/images/common/icon_05.gif" width="10" height="9" /></td>
					<%}else{ %>
						<td align="center"><a href="javascript:changePage('','add');"><img src="/PromesService/images/common/icon_05.gif" border="0" width="10" height="9" /></a></td>
					<%} %>
					
				</table>
				</td>
			</tr>
		</table></td>
	</tr>
</table>
</form>
</body>
</html>
