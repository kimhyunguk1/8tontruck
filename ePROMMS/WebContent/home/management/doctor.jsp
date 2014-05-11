<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page import="java.util.Hashtable"%>
<%ArrayList userList = (ArrayList) request.getAttribute("userList");%>
<%Hashtable userCountHash = (Hashtable) request.getAttribute("userCountHash");%>
<%String searchKey = (String)request.getAttribute("searchKey");%>
<%String searchType = (String)request.getAttribute("searchType");%>
<%String msg = (String)request.getAttribute("msg");%>
<%String pageIdx = (String)request.getAttribute("pageIdx");%>
<%String maxPageIdx = (String)request.getAttribute("maxPageIdx");%>
<%String sortType = (String)request.getAttribute("sortType");%>
<%String sortCourse = (String)request.getAttribute("sortCourse");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Doctor</title>
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

function init(){
	<%if(userCountHash != null){%>
		parent.setUserCount('<%=userCountHash.get("PATIENT")%>', '<%=userCountHash.get("INCHARGE")%>');
	<%}%>
	sortTableDiv();
}

function loadModifyUser(value){
	var mainForm = document.form;
	mainForm.cmd.value = "loadModifyUserInfoPage";
	mainForm.userId.value = value;
	mainForm.target = "managementMainPage";
	mainForm.submit();
}

function searchUser(){
	var mainForm = document.form;
	mainForm.cmd.value = "searchUserInfoList";
	mainForm.type.value = "DOCTOR";
	mainForm.keyType.value = '<%=searchType%>';
	mainForm.key.value = '<%=searchKey%>';
	mainForm.target = "userListPage";
	mainForm.submit();
}

function deleteUser(){
	var mainForm = document.form;
	var tmpCheckbox = mainForm._checkbox;
	var list = "";
	if(tmpCheckbox != null && tmpCheckbox.length != undefined){
		for(var i = 0; i < tmpCheckbox.length; i++){
	     		if(tmpCheckbox[i].checked){
	        list += tmpCheckbox[i].value + ",";
	      }
	    }
	}else if(tmpCheckbox != null && tmpCheckbox.length == undefined){
		if(tmpCheckbox.checked){
			list = tmpCheckbox.value;
		}
	}
	var result = false;
	if(list != ""){
		result = confirm("정말 삭제 하시겠습니까?");
	    if(result){
		    mainForm.cmd.value = "deleteUser";
	        mainForm.userIdList.value = list;
			mainForm.type.value = "DOCTOR";
			mainForm.keyType.value = '<%=searchType%>';
			mainForm.key.value = '<%=searchKey%>';
			mainForm.target = "deleteUserResultPage";
			mainForm.submit();
	    }
     }else{
		alert("사용자가 하나 이상 선택되어야 합니다.");
     }
}

function deleteAllUser(){
	var mainForm = document.form;
	var tmpCheckbox = mainForm._checkbox;
	if(tmpCheckbox != null && tmpCheckbox.length != undefined){
		for(var i = 0; i < tmpCheckbox.length; i++){
	     	if(!tmpCheckbox[i].checked){
	     		tmpCheckbox[i].click();
	     	}
	     }
	}else if(tmpCheckbox != null && tmpCheckbox.length == undefined){
		if(!tmpCheckbox.checked){
	    	tmpCheckbox.click();
	    }
	}
	deleteUser();
}

function changePage(idx, value){
	var mainForm = document.form;
  	mainForm.cmd.value = "searchUserInfoList";
	mainForm.type.value = "INCHARGE";
	mainForm.keyType.value = '<%=searchType%>';
	mainForm.key.value = '<%=searchKey%>';
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
	mainForm._pageIdx.value = pageIdx;
	<%if(sortType != null && !sortType.equals("")){%>
		mainForm._sortType.value = '<%=sortType%>';
	<%}%>
	<%if(sortType != null && !sortType.equals("")){%>
		mainForm._sortCourse.value = '<%=sortCourse%>';
	<%}%>
	mainForm.target = "userListPage";
	mainForm.submit();
}

function sortTable(type){
	var mainForm = document.form;
  	mainForm.cmd.value = "searchUserInfoList";
	mainForm.type.value = "DOCTOR";
	mainForm.keyType.value = '<%=searchType%>';
	mainForm.key.value = '<%=searchKey%>';
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
	mainForm.target = "userListPage";
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
		if(sortType.equals("EMAIL")){%>
			tableDiv[2].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[2].innerHTML = "";
		<%}
		if(sortType.equals("PHONE")){%>
			tableDiv[3].innerHTML = tmpHtml;
		<%}else {%>
			tableDiv[3].innerHTML = "";
		<%}if(sortType.equals("COMPANY")){%>
			tableDiv[4].innerHTML = tmpHtml;
		<%}else {%>
			tableDiv[4].innerHTML = "";
		<%}
	}else{%>
		tableDiv[0].innerHTML = "";
		tableDiv[1].innerHTML = "";
		tableDiv[2].innerHTML = "";
		tableDiv[3].innerHTML = "";
		tableDiv[4].innerHTML = "";
	<%}%>
}
//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/pharmacist/left_menu_b_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/management/left_menu_b_.gif','/PromesService/images/common/bt_delete_.gif','/PromesService/images/common/bt_all delete_.gif','/PromesService/images/common/bt_inquiry2_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="userId" type="hidden" value=""/>
<input name="userIdList" type="hidden" value=""/>
<input name="type" type="hidden" value=""/>
<input name="keyType" type="hidden" value=""/>
<input name="key" type="hidden" value=""/>
<input name="_pageIdx" type="hidden" value=""/>
<input name="_sortType" type="hidden" value=""/>
<input name="_sortCourse" type="hidden" value=""/>
<table width="756" border="0" cellpadding="1" cellspacing="1" bgcolor="#ececec">
	<tr>
		<td width="25" height="22" bgcolor="#e4eff0" class="td_table02">&nbsp;</td>
		<td width="40" height="22" bgcolor="#e4eff0" class="td_table02">No.</td>
		<td width="110" bgcolor="#e4eff0"><table width="110" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('ID');">아이디</td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="90" bgcolor="#e4eff0" class="td_table02"><table width="90" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('NAME');">이름</td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>	
		<td width="220" bgcolor="#e4eff0" class="td_table02"><table width="220" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('EMAIL');">이메일</td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="150" bgcolor="#e4eff0" class="td_table02"><table width="150" border="0" cellspacing="0" cellpadding="0">
	  	<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('PHONE');">전화번호</td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="120" bgcolor="#e4eff0" class="td_table02"><table width="120" border="0" cellspacing="0" cellpadding="0">
	  	<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('COMPANY');">병원명</td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
	</tr>
	<tr>
		<td height="3" colspan="7" bgcolor="#a7c2bc"></td>
	</tr>
	<%
	String tmpColot = "#FFFFFF";
	if(userList != null){
		for(int i=0;i < userList.size();i++){
			UserInfo userInfo = (UserInfo) userList.get(i);
			if(i % 2 == 0){
				tmpColot = "#edfaf7";
			}else{
				tmpColot = "#FFFFFF";
			}
			%>
			<tr>
				<td height="22" align="center" bgcolor="<%=tmpColot %>" class="td_table02"><input type="checkbox" name="_checkbox" id="_checkbox" value="<%=userInfo.getName()%>:<%=userInfo.getId()%>" /></td>
				<td width="40" align="center" bgcolor="<%=tmpColot %>" class="td_table02"><%=(i+1) %></td>
				<td align="center" bgcolor="<%=tmpColot %>" class="td_table02"><a href="javascript:loadModifyUser('<%=userInfo.getId()%>');"><font color="#3c5f84"><%=userInfo.getId()%></font></a></td>
				<td align="center" bgcolor="<%=tmpColot %>" class="td_table02"><%=userInfo.getName() %></td>
				<td align="center" bgcolor="<%=tmpColot %>" class="td_table02"><%=userInfo.getE_mail() %></td>
				<td align="center" bgcolor="<%=tmpColot %>" class="td_table02"><%=userInfo.getPh() %></td>
				<td align="center" bgcolor="<%=tmpColot %>" class="td_table02"><%=userInfo.getCompany() %></td>
			</tr>
			<%
		}
		for(int i=userList.size();i < 8;i++){
			if(i % 2 == 0){
				tmpColot = "#edfaf7";
			}else{
				tmpColot = "#FFFFFF";
			}
			%>
			<tr>
				<td height="22" align="center" bgcolor="<%=tmpColot %>">
				<td height="22" align="center" bgcolor="<%=tmpColot %>"></td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
			</tr>
			<%
		}
	}else{
		for(int i=0;i < 8;i++){
			if(i % 2 == 0){
				tmpColot = "#edfaf7";
			}else{
				tmpColot = "#FFFFFF";
			}
			%>
			<tr>
				<td height="22" align="center" bgcolor="<%=tmpColot %>">
				<td height="22" align="center" bgcolor="<%=tmpColot %>"></td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
				<td align="center" bgcolor="<%=tmpColot %>">&nbsp;</td>
			</tr>
			<%
		}
	}%>
</table>
<table width="756" border="0">
	<tr>
		<td height="23" align="center" bgcolor="#FFFFFF"><table width="735" border="0" cellspacing="0" cellpadding="0">
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
<iframe name="deleteUserResultPage" id="deleteUserResultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="0" height="0"></iframe>
</form>
</body>
</html>