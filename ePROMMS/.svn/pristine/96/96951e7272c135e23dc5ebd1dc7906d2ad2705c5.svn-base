<%@page contentType="text/html; charset=euc-kr"%>
<%String id = (String) request.getParameter("id");%>
<%String name = (String) request.getParameter("name");%>
<%String prescriptionId = (String) request.getParameter("prescriptionId");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
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


function MM_openBrWindow(theURL,winName,features) {
  var mainForm = document.form;
  window.open(theURL,winName,features);
}

function popupClose(){
	this.close();
}

function openCalendar(type){
	var x = 0; 
	var	y = 0;
	var w = 220;
	var h = 203;
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
	var point = "width=220, height=203, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	MM_openBrWindow('/PromesService/PromesServerServlet?cmd=loadCalendarPage&_parentType=OPENER&type=' + type,'calendarPopup',point);
}

function changeDate(type, date){
	var tmpHtml = "";
	if(type == 'start'){
		tmpHtml = "&nbsp; <input name=\"_startDate\" type=\"text\" class=\"inputbox\" size=\"14\" id=\"_startDate\" value=\"" + date + "\" />"
		_startDateDiv.innerHTML = "" + tmpHtml;
	}else if(type == 'end'){
		tmpHtml = "<input name=\"_endDate\" type=\"text\" class=\"inputbox\" size=\"14\" id=\"_endDate\" value=\"" + date + "\" />"
		_endDateDiv.innerHTML = "" + tmpHtml;
	}
}

function searchPrescription(){
	var mainForm = document.form;
	mainForm.cmd.value = 'searchPrescriptionPage';
	mainForm._type.value = opener.getType();
	mainForm.target = "patientPrescriptionListPage";
	mainForm.submit();
	this.close();
}
//-->
</script>
</head>
<body onload="MM_preloadImages('/PromesService/images/common/bt_popup_id_.gif','/PromesService/images/common/bt_popup_search2_.gif','/PromesService/images/pharmacist/left_menu_a_.gif','/PromesService/images/pharmacist/left_menu_c_.gif','/PromesService/images/common/bt_inquiry_.gif','/PromesService/images/common/bt_revision2_.gif','/PromesService/images/common/bt_internal_.gif','/PromesService/images/common/bt_delete2_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_type" type="hidden" value=""/>
<table width="400" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="400" height="260" align="center" valign="top" class="box01"><table width=378 border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="11"></td>
      </tr>
      <tr>
        <td height="65" valign="top"><img src="/PromesService/images/common/popup_im08.gif" width="378" height="54" border="0" /></td>
      </tr>
      <tr>
        <td height="150" valign="top">
       		<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="1" bgcolor="#ececec"></td>
				</tr>
				<tr>
					<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="96" height="25" bgcolor="#ddebec" class="td_table02">환자이름</td>
						<td>&nbsp; <input name="_name" type="text" class="inputbox" size=42 id="_name" <%if(name != null && !name.equals("")){%> value="<%=Util.toString(name) %>"<%} %> readonly="true" /></td>
					</tr>
					<tr>
						<td height="1" bgcolor="#ececec" colspan="2"></td>
					</tr>
					<tr>
						<td width="96" height="25" bgcolor="#ddebec" class="td_table02">환자 ID</td>
						<td>&nbsp; <input name="_id" type="text" class="inputbox" size="42" id="_id" <%if(id != null && !id.equals("")){ %> value="<%=Util.toString(id) %>" <%} %> readonly="true" /></td>
					</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td height="1" bgcolor="#ececec"></td>
				</tr>
				<tr>
					<td height="5"></td>
				</tr>
				<tr>
					<td height="1" bgcolor="#ececec"></td>
				</tr>
				<tr>
					<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="96" height="25" bgcolor="#ddebec" class="td_table02">교부번호</td>
							<td>&nbsp; <input name="_prescriptionId" type="text" class="inputbox" size="42" id="_prescriptionId" <%if(prescriptionId != null){ %> value="<%=prescriptionId %>" <%} %>  /></td>
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
							<td width="96" height="25" bgcolor="#ddebec" class="td_table02">복용시작일</td>
							<td>
							<table width="280" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><div id="_startDateDiv">&nbsp; <input name="_startDate" type="text" class="inputbox" size="14" id="_startDate" /></div></td>
									<td width="20"><a href="javascript:openCalendar('start');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
									<td width="25" align="center">~</td>
									<td align="left"><div id="_endDateDiv"><input name="_endDate" type="text" class="inputbox" size="14" id="_endDate" readonly="true" /></div></td>
									<td width="31"><a href="javascript:openCalendar('end');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="1" bgcolor="#ececec" colspan="2"></td>
						</tr>
						<tr>
							<td width="96" height="25" bgcolor="#ddebec" class="td_table02">복용상태</td>
							<td>&nbsp; <select name="_takenSatus" class="select_white" style="width: 260px">
								<option value="ALL">전체</option>
								<option value="NOSCHEDULE">시작일미설정</option>
								<option value="READY">알림전</option>
								<option value="ON">복용중</option>
								<option value="FINISH">복용완료</option>
							</select></td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td height="1" bgcolor="#ececec"></td>
				</tr>
				<tr>
					<td height="1" bgcolor="#ececec"></td>
				</tr>
			</table>
        </td>
      </tr>
      <tr>
        <td align="right"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="54" align="left" ><a href="javascript:searchPrescription();"><img src="/PromesService/images/common/bt_popup_search2.gif" width="47" height="19" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_popup_search2_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
	        <td><a href="javascript:popupClose();"><img src="/PromesService/images/common/bt_popup_colse.gif" width="47" height="19" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_popup_colse_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<iframe name="detailResultPage" id="detailResultPage" src="/PromesService/home/user/userInfoResult.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0"></iframe></form>
</form>
</body>
</html>