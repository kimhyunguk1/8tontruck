<%@page import="kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo"%>
<%@page contentType="text/html; charset=utf-8" isELIgnored = "false"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo"%>
<%@page import="java.util.Hashtable"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%ArrayList scheduleInfoList = (ArrayList) request.getAttribute("scheduleInfoList");%>
<%String userId = (String)request.getAttribute("userId");%>
<%String boxtypeIndex = (String)request.getAttribute("boxtype_index");%>
<%String selectIndex = (String)request.getAttribute("select_index");%>
<%String searchDate = (String)request.getAttribute("searchDate");%>
<%String userType = (String)request.getAttribute("type");%>
<%String pageIdx = (String)request.getAttribute("pageIdx");%>
<%String maxPageIdx = (String)request.getAttribute("maxPageIdx");%>
<%String sortType = (String)request.getAttribute("sortType");%>
<%String sortCourse = (String)request.getAttribute("sortCourse");%>
<% UserInfo LoginuserInfo = (UserInfo)request.getSession().getAttribute("LoginuserInfo");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="java.util.Collections"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Prescription Info List</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
<!--
	
$(document).ready(function(){	
	 $("td.Username").hover(
	  function () {
	    //alert($("td.Username").text());  
	  }, 
	  function () {
	    
	  }
	);
});
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
	sortTableDiv();
	parent.initsize();
}

function changePage(idx, value){
	var mainForm = document.form;
	mainForm.cmd.value = 'searchPrescriptionPage';
	mainForm._type.value = parent.getType();
	mainForm._loginId.value = parent.getLoginId();
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
	mainForm.target = "prescriptionListPage";
	mainForm.submit();
}

function sortTable(type){
	var mainForm = document.form;
	mainForm.cmd.value = 'searchPrescriptionPage';
	mainForm._type.value = parent.getType();
	mainForm._sortType.value = type;
	mainForm._loginId.value = parent.getLoginId();
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
	mainForm.target = "prescriptionListPage";
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
		if(sortType.equals("STARTDATE")){%>
			tableDiv[2].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[2].innerHTML = "";
		<%}
		if(sortType.equals("DISEASE")){%>
			tableDiv[3].innerHTML = tmpHtml;
		<%}else {%>
			tableDiv[3].innerHTML = "";
		<%}
		if(sortType.equals("STATUS")){%>
			tableDiv[4].innerHTML = tmpHtml;
		<%}else{%>
			tableDiv[4].innerHTML = "";
		<%}%>
	<%}else{%>
		tableDiv[0].innerHTML = "";
		tableDiv[1].innerHTML = "";
		tableDiv[2].innerHTML = "";
		tableDiv[3].innerHTML = "";
		tableDiv[4].innerHTML = "";
	<%}%>
}

var nav = (document.layers);
var _out = "false";

function alt(type,id,_width,_height){
  if(type != null){
    _out = "true";
  }else{
    _out = "false";
  }
  var content ="<TABLE HEIGHT='205' WIDTH='220' BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR=#FFFF00>";
  content += "<TR><TD>";
  content += "<iframe name=\"calendarPopup\" id=\"calendarPopup\" src=\"/PromesService/PromesServerServlet?cmd=loadCalendarPage&_parentType=PARENT&type=";
  content += type +"\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" height=\"100%\" width=\"100%\" ></iframe>";
  content += "</TD></TR><TABLE>";
  get_xy(type);
  var _style = alt_div.style;
  if( type != null ){
    alt_div.innerHTML = content;
    _style.visibility = "visible";
    if( _width != null ){
      if( alt_div.offsetWidth > _width ){
        _style.width = _width;
      }
    }
    if( _height != null ){
      if( alt_div.offsetHeight > _height ){
        _style.height = _height;
      }
    }
  }else{
    _style.visibility = "hidden";
  }
}

document.write(
    "<div id=alt_div style=\"" +
    "padding:0;" +
    "border:0 solid #FF7200;" + // 말풍선 테두리 컬러
    "background-color:#efefef;color:#000;" + // 말풍선 테이블 백그라운드컬러 / 폰트컬러
    "position:absolute;" +
    "visibility:hidden;" +
    "overflow:hidden;" +
    "z-index:auto;" +
    "width:auto;" +
    "height:auto;" +
    "filter:alpha(opacity=100);" + // 투명도
    "\"></div>"
);

document.onmousemove = out_xy;
var point_x;
var point_y;
function out_xy(){
//  alert(event.y+document.body.scrollTop);
  if(_out == "true"){
    var layer_x = alt_div.style.left;
    var layer_y = alt_div.style.top;
    layer_x = layer_x.substring(0, layer_x.length - 2);
    layer_y = layer_y.substring(0, layer_y.length - 2);
    var out_x = event.x+document.body.scrollLeft;
    var out_y = event.y+document.body.scrollTop;
    if(layer_x - 5 > out_x || out_x > Number(layer_x) + 225){
      alt();
    }
    if(layer_y - 5 > out_y || Number(layer_y) + 208 < out_y){
      alt();
    }
  }else{
  	point_x = event.x+document.body.scrollLeft;
    point_y = event.y+document.body.scrollTop;
  }
}

function get_xy(type){
	var _style = alt_div.style;
	var x = 0;
	var y = 0;
	x = point_x;
	y = point_y;
	if(x < 780 && y < 610){
	  _style.left = x - 5;
	  _style.top = y - 5;
	}
}

function getDate(date){
	var mainForm = document.form;
	var tmp = date;
	tmp = tmp.replace('년 ', '-');
	tmp = tmp.replace('월 ', '-');
	tmp = tmp.replace('일', '');
	tmp = tmp.split('-');
	
	alert(tmp[0] + tmp[1] + tmp[2]);
	
	return tmpDate;
}

function getTimeDistance(date){
	var todayDt = new Date();
	var mainForm = document.form;
	var tmp = date;
	tmp = tmp.replace('년 ', '-');
	tmp = tmp.replace('월 ', '-');
	tmp = tmp.replace('일', '');
	tmp = tmp.split('-');
	dt = new Date(tmp[0], tmp[1]-1, tmp[2], 23, 59, 59);
	var dis = dt.getTime() - todayDt.getTime();
	return dis;
}

function changeDate(type, value)
{	
	var mainForm = document.form;
	var todayDt = new Date();
	var dt = new Date();
	if(type == 'start')
	{
		mainForm._searchDate.value = value;
	}
	
	//getdate(mainForm._searchDate.value);
	
	mainForm.cmd.value = 'loadTodayListPage';
	mainForm._userId.value = '<%=userId%>';
	mainForm._type.value = '<%=userType%>';
	mainForm._date.value = value;
	mainForm.submit();
	alt();
}

function loadDosagePage(value1, value2, hospital)
{	
	parent.changeMenu("none");
	//parent.changeTitle("복용현황");
	var mainForm = document.form;
	mainForm.cmd.value = 'loadDosagePage';
	mainForm._prescriptionId.value = value1;
	mainForm._userId.value = value2;	
	mainForm._hospital.value = hospital;	
	if('${LoginuserInfo.type}' == "ADMIN"){
		mainForm.target = "managementMainPage";
	}else{
		mainForm.target = "prescriptionMainPage";	
	}
	mainForm.submit();
}

function takensubmit(value1,value2, hospital, confirmday,value3,value4){	
	var mainForm = document.form;
	mainForm.cmd.value='loadTakensubmit';
	mainForm._prescriptionId.value = value1;
	mainForm._userId.value = value2;	
	mainForm._hospital.value = hospital;	
	mainForm._confirmday.value = confirmday;
	mainForm._filename.value = value3+'_'+value4;
	mainForm.target = "TakenSubmitResultPage";
	mainForm.submit();	
}


function gifview(takengifsrc){		
	var span = document.getElementById("gifview");	
	if(takengifsrc != ""){	
		span.innerHTML="<iframe id=\"takenimageView\" src=\"" + takengifsrc + "\" width=340 height=270></iframe>";
		span.style.display="inline";		
	}
}


function hidebox() {
	var span = document.getElementById("gifview");
	span.style.display="none";
}

function movebox() {
	var span = document.getElementById("gifview");
	span.style.pixelTop=event.y+document.body.scrollTop;
	span.style.pixelLeft=event.x+document.body.scrollLeft+5;	
}

document.onmousemove=movebox;

function goTo(){
	
	var mainForm = document.form;
	var index = mainForm._gubun.selectedIndex;
	mainForm._boxtype_index.value = index;	
	mainForm._boxtype.value = mainForm._gubun.options[index].value;
	
	var index1 = mainForm._select.selectedIndex;
	mainForm._select_index.value = index1;	
	mainForm._selecttype.value = mainForm._select.options[index1].value;	
	
	mainForm.cmd.value = 'loadTodayListPage';	
	mainForm._userId.value='<%=userId%>';	
	mainForm._type.value='PHARMACIST';	
	mainForm._date.value=mainForm.searchDate.value;	
	mainForm.target = "prescriptionMainPage";
	mainForm.submit();
}
function refresh(){		
	var mainForm = document.form;
	parent.refresh(mainForm._searchDate.value);

}

//-->
</script>
</head>
<body onload="javascript:initsize();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/prescription/left_menu_a_.gif','/PromesService/images/prescription/left_menu_c_.gif','/PromesService/images/common/bt_inquiry_.gif','/PromesService/images/common/bt_revision2_.gif','/PromesService/images/common/bt_internal_.gif','/PromesService/images/common/bt_delete2_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_type" type="hidden" value=""/>
<input name="_date" type="hidden" value=""/>
<input name="_boxtype" type="hidden" value=""/>
<input name="_boxtype_index" type="hidden" value=""/>
<input name="_select_index" type="hidden" value=""/>
<input name="_selecttype" type="hidden" value=""/>
<input name="_confirmday" type="hidden" value=""/>
<input name="_filename" type="hidden" value=""/>
<table width="756" border="0" cellpadding="1" cellspacing="1" bgcolor="#ececec" class="TodayPrescriptionList">
	<tr>
		<td height="41" colspan="7" background="/PromesService/images/common/bar_01.gif"><table width="220" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="50">  &nbsp;&nbsp;</td>
				<td><input name="_searchDate" type="text" class="inputbox" size="15" id="_searchDate" align="center" readonly="true" value="<%= searchDate%>"/></td>
				<td width="40" align=center><a href="javascript:alt('start');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
				<td width="60">&nbsp;</td>
				<td width="50">
				</td>
			</tr>
		</table></td>
	</tr>
	<tr>
		<td height="5"></td>
	</tr>
	<tr>
		<td width="32" height="22" bgcolor="#e4eff0" class="td_table02"  align="center">No.</td>
		<td width="100" bgcolor="#e4eff0">
			<table width="80" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td class="td_table02" valign="middle" onclick="javascript:sortTable('NAME');"><fmt:message key='name' /></td>
				<td width="7" align="right"><div id="tableDiv"></div></td>
			</tr>
			</table>
		</td>
		<td width="120" bgcolor="#e4eff0" class="td_table02" >
			<table width="76" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td class="td_table02" valign="middle"  onclick="javascript:sortTable('START');"><fmt:message key='the_beginning_time_of_alarm' /></td>
				<td width="7" align="right"><div id="tableDiv"></div></td>
			</tr>
			</table>
		</td>	
		<td width="120" bgcolor="#e4eff0" class="td_table02"><table width="120" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('END');"><fmt:message key='the_closed_time_of_alarm' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="100" bgcolor="#e4eff0" class="td_table02"><table width="175" border="0" cellspacing="0" cellpadding="0"  align="center">
	  	<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('STATUS');"><fmt:message key='medication_status' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="120" bgcolor="#e4eff0" class="td_table02"><table width="80" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('STATUS');"><fmt:message key='medication_time' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
		<td width="120" bgcolor="#e4eff0" class="td_table02"><table width="80" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td class="td_table02" valign="middle" onclick="javascript:sortTable('STATUS');"><fmt:message key='confirm_medication_status' /></td>
			<td width="7" align="right"><div id="tableDiv"></div></td>
		</tr>
		</table></td>
	</tr>
	<tr>
		<td height="3" colspan="8" bgcolor="#a7c2bc"></td>
	</tr>
<%
	String tmpColot = "#FFFFFF";
	if(scheduleInfoList != null){
	for(int i=0;i < scheduleInfoList.size();i++)
	{
		if(i % 2 == 0){
			tmpColot = "#edfaf7";
		}else{
			tmpColot = "#FFFFFF";
		}
		ScheduleInfo scheduleInfo = (ScheduleInfo) scheduleInfoList.get(i);
		%>
		<tr>
			<td height="22" align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=(i + 1) %></td>
			
			<td bgcolor='<%=tmpColot%>' class="td_table02_ Username" id = "Username"><a onmouseout="javascript:hidebox()" onmouseover="javascript:gifview('<%=scheduleInfo.getGifImage()%>');" href="javascript:loadDosagePage('<%=scheduleInfo.getPrescription_id()%>', '<%=scheduleInfo.getId()%>', '<%=scheduleInfo.getHospital() %>');"><font color="#3c5f84">&nbsp;&nbsp;<%=scheduleInfo.getUserName() %></font></a></td>						
			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=scheduleInfo.getFormatTime(1) %></td>
			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=scheduleInfo.getFormatTime(2) %></td>
			<%if(scheduleInfo.getImage().equals("")) {%>
				<td bgcolor='<%=tmpColot%>' class="td_table02">&nbsp;</td>
			<%}else{ %>	
				<td bgcolor='<%=tmpColot%>' class="td_table02"><img src="<%=scheduleInfo.getImage() %>" width="9" height="9" /></td>
			<%} %>
			<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=scheduleInfo.getFormatTime(3) %></td>
			<%if(!scheduleInfo.getTakenStatus().equals("NONE")) {
				if(scheduleInfo.getTakenStatus().equals("PRETAKEN")){
					%>
						<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><a href="javascript:takensubmit('<%=scheduleInfo.getPrescription_id()%>', '<%=scheduleInfo.getId()%>', '<%=scheduleInfo.getHospital() %>','<%=scheduleInfo.getAlarmStart() %>','<%=scheduleInfo.getPillboxId()%>','<%=scheduleInfo.getAlarmStart().substring(0, 8)%>');"><img id="view" src="/PromesService/images/common/button2.jpg" border="0"></a></td>
					<%
				}else if(scheduleInfo.getTakenStatus().equals("FINISHTAKEN")){
					%>
						<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"><fmt:message key='the_complete_of_medication' /></td>  
					<%
				}else{
					%>
						<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"></td>
					<%
				}
			}else{
				%>
					<td align="center" bgcolor='<%=tmpColot%>' class="td_table02"></td>
				<%
			}
			
			%>			
			
		</tr>
	<%}
		for(int i = scheduleInfoList.size(); i < 10;i++){
			if(i % 2 == 0){
				tmpColot = "#edfaf7";
			}else{
				tmpColot = "#FFFFFF";
			}%>
			<tr>
				<td height="22" align="center" bgcolor='<%=tmpColot%>' class="td_table02"></td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
			</tr>
		<%}
	}else{
		for(int i=0;i < 10;i++){
			if(i % 2 == 0){
				tmpColot = "#edfaf7";
			}else{
				tmpColot = "#FFFFFF";
			}
			%>
			<tr>
				<td height="22" align="center" bgcolor='<%=tmpColot%>' class="td_table02"><%=(i+1)%></td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
				<td align="center" bgcolor='<%=tmpColot%>'>&nbsp;</td>
			</tr>
	<%}}%>

</table>
<span id="gifview" class="view"></span>
<iframe name="TakenSubmitResultPage" id="TakenSubmitResultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0"></iframe>
</form>
</body>
</html>