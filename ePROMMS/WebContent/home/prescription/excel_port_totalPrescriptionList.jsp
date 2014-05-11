<%@page contentType = "application/vnd.ms-excel;charset=euc-kr" %>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.Define"%>
<%@page import="java.util.Calendar"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo"%>

<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo"%>
<%@page import="java.util.Hashtable"%>

<%     
    response.setHeader("Content-Disposition", "attachment; filename=diary.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data"); 
    response.setContentType("application/vnd.ms-excel");
%>


<%ArrayList scheduleInfoList = (ArrayList) request.getAttribute("scheduleInfoList");%>
<%ArrayList totalschedule = (ArrayList) request.getAttribute("totalschedule");%>
<%String userId = (String)request.getAttribute("userId");%>
<%String searchDate = (String)request.getAttribute("searchDate");%>
<%String userType = (String)request.getAttribute("type");%>
<%String pageIdx = (String)request.getAttribute("pageIdx");%>
<%String maxPageIdx = (String)request.getAttribute("maxPageIdx");%>
<%String sortType = (String)request.getAttribute("sortType");%>
<%String sortCourse = (String)request.getAttribute("sortCourse");%>
<%String maxalarm = (String)request.getAttribute("maxalarm");%>
<%String minalarm = (String)request.getAttribute("minalarm");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="java.util.Collections"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<STYLE>
.ttip {border:1px solid black;font-size:12px;layer-background-color:lightyellow;background-color:lightgreen}
</STYLE>

<title>e-PROMMS 2.0 Prescription Info List</title>
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
    "border:0 solid #FF7200;" + // ��ǳ�� �׵θ� �÷�
    "background-color:#efefef;color:#000;" + // ��ǳ�� ���̺� ��׶����÷� / ��Ʈ�÷�
    "position:absolute;" +
    "visibility:hidden;" +
    "overflow:hidden;" +
    "z-index:auto;" +
    "width:auto;" +
    "height:auto;" +
    "filter:alpha(opacity=100);" + // ���?
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
	tmp = tmp.replace('�� ', '-');
	tmp = tmp.replace('�� ', '-');
	tmp = tmp.replace('��', '');
	tmp = tmp.split('-');
	
	alert(tmp[0] + tmp[1] + tmp[2]);
	
	return tmpDate;
}

function getTimeDistance(date){
	var todayDt = new Date();
	var mainForm = document.form;
	var tmp = date;
	tmp = tmp.replace('�� ', '-');
	tmp = tmp.replace('�� ', '-');
	tmp = tmp.replace('��', '');
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
	//parent.changeTitle("������Ȳ");
	var mainForm = document.form;
	mainForm.cmd.value = 'loadDosagePage';
	mainForm._prescriptionId.value = value1;
	mainForm._userId.value = value2;	
	mainForm._hospital.value = hospital;	
	mainForm.target = "prescriptionMainPage";
	mainForm.submit();
}


function showtip(nextTo, e, str1,str2,str3,str4,str5) {
	
	var name = str1.substr(0,1)+"**";
	var alarmstart = str2.substr(0,4)+ "/"+ str2.substr(4,2)+"/"+str2.substr(6,2)+" "+str2.substr(9,2)+ ":"+str2.substr(11,2);
	var alarmend = str3.substr(0,4)+ "/"+ str3.substr(4,2)+"/"+str3.substr(6,2)+" "+str3.substr(9,2)+ ":"+str3.substr(11,2);
	var takentime = str4.substr(0,4)+ "/"+ str4.substr(4,2)+"/"+str4.substr(6,2)+" "+str4.substr(9,2)+ ":"+str4.substr(11,2);
	
	if(str5 == "FINISHUNTAKEN")
		takentime = "�̺���"

	var tt = document.getElementById("tooltip");
	tt.innerHTML = "�̸� : " + name + "<br>";
	tt.innerHTML += "�˶����۽ð� : <b>" + alarmstart + "</b><br>";
	tt.innerHTML += "�˶����ð� : " + alarmend + "<br>";
	tt.innerHTML += "����ð� : " + takentime + "<br>";
	tt.style.left = (getpageLeft(nextTo) + nextTo.offsetWidth) + 'px';
	tt.style.top = getpageTop(nextTo)  + 'px';
	tt.style.visibility = 'visible';
	
}

function hidetip() {	
	var tt = document.getElementById("tooltip");	
	tt.style.visibility = 'hidden';
}

function getpageLeft(el){
	var left=0;
	
	do
		left += el.offsetLeft;
	while((el = el.offsetParent));
	return left;	
}

function getpageTop(el){
	var top=0;
	do
		top += el.offsetTop;
	while((el = el.offsetParent));
	return top;	
}

function setDate(str){
	if(str == null)
		str="";
	
	var date = str.substr(0,4)+ "/"+ str.substr(4,2)+"/"+str.substr(6,2)+" "+str.substr(9,2)+ ":"+str.substr(11,2);
	return date;
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

<table width="100%"  border="1" bordercolor="#ececec" cellspacing="0" >
	<%!
	public String DateEncode(String date){
		String setDate="";		
		if(date.length()>11)	
			setDate = date.substring(0,4)+ "/"+ date.substring(4,6)+"/"+date.substring(6,8)+" "+date.substring(9,11)+ ":"+date.substring(11,date.length());
		
		return setDate;		
	}
	%>

<%
	for(int i=0; i<totalschedule.size(); i++)
	{

%>
	<tr height="20px" align="center">	
<%
		ArrayList<ScheduleInfo> individualschedule = (ArrayList<ScheduleInfo>)totalschedule.get(i);
		

		if(i==0){
			for(int j=0; j<individualschedule.size(); j++){
				ScheduleInfo scheduleInfo = (ScheduleInfo) individualschedule.get(j);
				if(j==0){
					%>
					<td width="20px" nowrap >&nbsp;</td>
					<%
				}
				%>
				<td width="20px" nowrap ><%=scheduleInfo.getAlarmStart().substring(6,8) %></td>
				<%
			}
			%>
			</tr><tr height="20px" align="center">
			<%
		}
		for(int j=0; j<individualschedule.size(); j++)
		{
			ScheduleInfo scheduleInfo = (ScheduleInfo) individualschedule.get(j);	
			
			String stat = scheduleInfo.getImage();
			String backcolor ="";
			
			if(stat.equals(Define.TAKEN_SATUS_TAKEN_IMAGE))
			{				
				backcolor="bgcolor=\"blue\"";
			}
			else if(stat.equals(Define.TAKEN_SATUS_NOTTAKEN_IMAGE))
			{
				backcolor="bgcolor=\"red\"";
			}
			else if(stat.equals(Define.TAKEN_SATUS_DELAYTAKEN_IMAGE))
			{
				backcolor="bgcolor=\"339900\"";
			}
			else if(stat.equals(Define.TAKEN_SATUS_OUTTAKEN_IMAGE))
			{
				backcolor="bgcolor=\"6666FF\"";
			}
	
				
			if(j == 0)
			{
				String username =scheduleInfo.getUserName(); 
%>
				<td width="40px" nowrap><%=username%></td>	
<%
			}
			if(scheduleInfo.getAlarmEnd().equals("blank")){
%>		
					<td width="20px" nowrap >&nbsp;</td>
<%				
			}
			else{			
%>		
			<td width="20px" nowrap <%=backcolor%>></td>
<%			
			}
		}		
%>
	</tr>
<%
	
	}
%>
</table>
<div id="tooltip" style="position:absolute;visibility:hidden;border:1px solid black;font-size:20px;layer-background-color:lightyellow;background-color:lightyellow;padding:1px"></div>
</form>
</body>
</html>