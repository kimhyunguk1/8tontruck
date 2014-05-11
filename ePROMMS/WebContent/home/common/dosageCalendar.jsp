<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.Define"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="lang_fr"/>
<%String year = (String) request.getAttribute("year");%>
<%String month = (String) request.getAttribute("month");%>
<%String date = (String) request.getAttribute("date");%>
<%String firstDay = (String) request.getAttribute("firstDay");%>
<%String lastDate = (String) request.getAttribute("lastDate");%>
<%Hashtable scheduleHash = (Hashtable) request.getAttribute("scheduleHash");%>
<%ArrayList categoryHash = (ArrayList) request.getAttribute("category"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Calendar</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css" media="print">
 .noprint { display:none; }
</style>
<script type="text/javascript"src="http://code.jquery.com/jquery-latest.min.js"></script>
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

function initsize() 
{
	<%
	session.setAttribute("category",categoryHash);
	%>
	alt_div.style.visibility = "hidden";

	var mainForm = document.form;
	mainForm._year.value = '<%=year%>';
	<%if(Integer.parseInt(month) < 10){%>
		mainForm._month.value = '0<%=month%>';
	<%}else{%>
		mainForm._month.value = '<%=month%>';
	<%}
	if(scheduleHash != null){
		if(scheduleHash.containsKey(date)){
			ArrayList schedules = (ArrayList) scheduleHash.get(date);
			%>
			var times = "";
			<%
			for(int i = 0; i < schedules.size(); i++){
				ScheduleInfo scheduleInfo = (ScheduleInfo) schedules.get(i);
			%>
				times += "[" + '<%=scheduleInfo.getId()%>' + "/";
				times += '<%=Util.changeIntToTime(scheduleInfo.getAlarmStartTime())%>' + '/';		
				times += '<%=Util.changeIntToTime(scheduleInfo.getAlarmEndTime())%>';
				times += "]";
	<%		}%>
	<%	}
	}
	%>
	parent.initsize();
}

function changeCalendar(type, value){
	var mainForm = document.form;
	if(value != null && value != ''){
		var idxMonth = mainForm._month.selectedIndex;
		var idxyear = mainForm._year.selectedIndex;
		if(value == "sub"){
			idxMonth = Number(idxMonth) - 1;
			if(idxMonth == -1){
				idxyear = Number(idxyear) - 1; 
				idxMonth = 11;
				if(idxyear == -1){
					alert("<fmt:message key='the_last_calender_you_can_review' />");
					idxyear = 0;
					idxMonth = 0;
				}
			}
		}else{
			idxMonth = Number(idxMonth) + 1;
			if(idxMonth == 12){
				idxyear = Number(idxyear) + 1; 
				idxMonth = 0;
				if(idxyear == mainForm._year.length){
					alert("<fmt:message key='the_last_calender_you_can_review' />");
					idxyear = mainForm._year.length - 1;
					idxMonth = 11;
				}
			}
		}
		mainForm._month.selectedIndex =  idxMonth;
		mainForm._year.selectedIndex =  idxyear;
	}
	mainForm.cmd.value = 'loadDetailSchedulePage';
	mainForm._prescriptionId.value = parent.getPrescriptionId();
	mainForm._userId.value = parent.getUserId();
	mainForm._hospital.value = parent.getHospital();
	mainForm.target = "dosageInfoPage";
	mainForm.submit();
}

function changeDate(type, value){
	var mainForm = document.form;
	var dt = new Date();
	if(type == 'start'){
		mainForm._startDate.value = value;
	}else if(type == 'end'){
		mainForm._endDate.value = value;
	}
}

function detailTimePopup(day, value, times)
{
	var mainForm = document.form;
	var tmpDate = "";
	if(day < 10){
		tmpDate = mainForm._year.value + "-" + mainForm._month.value + "-0" + day + "";
	}else{
		tmpDate = mainForm._year.value + "-" + mainForm._month.value + "-" + day + "";
	}
	var x = 0; 
	var	y = 0;
	var w = 442;
	var h = 126;
	h = h + (26 * value);
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
	var point = "width=442, height=" + h + ", top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	var url = '/PromesService/home/common/detailDosage_popup.jsp';
	url += '?prescriptionId=' + parent.getPrescriptionId();
	url += '&userId=' + parent.getUserId();
	url += '&hospital=' + parent.getHospital();
	url += '&type=' + parent.getType();
	url += '&day=' + tmpDate;
	url += '&frequency=' + value;
	url += '&timeStr=' + times;
	MM_openBrWindow(url,'detailDosagePopup',point);
}

function showErrorPopup(day, categoryCode, content, memocontent, memoId,takencheck)
{
	var mainForm = document.form;
	var tmpDate = "";
	if(day < 10){
		tmpDate = mainForm._year.value + "-" + mainForm._month.value + "-0" + day + "";
	}else{
		tmpDate = mainForm._year.value + "-" + mainForm._month.value + "-" + day + "";
	}
	var x = 0; 
	var	y = 0;
	var w = 442;
	var h = <%=categoryHash.size()%> * 100;	
	h = h + 100;
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
	var point = "width=442, height=350, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO, status=no";
	var url = '/PromesService/home/common/error_popup.jsp';
	url += '?prescriptionId=' + parent.getPrescriptionId();
	url += '&userId=' + parent.getUserId();
	url += '&hospital=' + parent.getHospital();
	url += '&type=' + parent.getType();
	url += '&day=' + tmpDate;
	url += '&memoId=' + memoId;
	url += '&content=' + encode(content);
	url += '&memocontent=' + encode(memocontent);	
	url += '&categoryCode=' + categoryCode;
	url += '&takencheck=' + takencheck;
	MM_openBrWindow(url,'memoPopup',point);
}

function showMemoPopup(day, takenStatus,takenTime, memo, memoId)
{
	var status ="";
	if(takenStatus == "PRETAKEN"){
		takenStatus = "FINISHTAKEN";
	}
	var mainForm = document.form;
	var tmpDate = "";
	if(day < 10){
		tmpDate = mainForm._year.value + "-" + mainForm._month.value + "-0" + day + "";
	}else{
		tmpDate = mainForm._year.value + "-" + mainForm._month.value + "-" + day + "";
	}
	var x = 0; 
	var	y = 0;
	var w = 442;
	var h = 340;
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
 	
	var point = "width=442, height=" + h + ", top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	var url = '/PromesService/home/common/memo_popup.jsp';
	url += '?prescriptionId=' + parent.getPrescriptionId();
	url += '&userId=' + parent.getUserId();
	url += '&hospital=' + parent.getHospital();
	url += '&type=' + parent.getType();
	url += '&day=' + tmpDate;
	url += '&memoId=' + memoId;
	//url += '&memo=' + memo.replace("+", "%2B");
	url += '&memo=' + encode(memo);
	url += '&takenStatus=' + takenStatus;
	//url += '&memo=' + escape(memo);
	MM_openBrWindow(url,'memoPopup',point);	
	
}
function encode(str)
{
	var i;	
	for(i=0; i < str.length; i++)
	{	
		if(str.substr(i,1) == '+')
			str = str.replace('+',"%2B");

		if(str.substr(i,1) == '#')	
			str = str.replace('#',"%23");
	}
	return str;
}

//-->
</script>
</head>
<body onload="initsize();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/common/bt_inquiry2_.gif','/PromesService/images/common/bt_graph_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<script language="JavaScript" type="text/JavaScript">
<!--
var nav = (document.layers);
var _out = "false";
function alt(msg,id,_width,_height){
  if(msg != null){
    _out = "true";
  }else{
    _out = "false";
  }
  if( msg != null ){
  
  var content ="<TABLE WIDTH='130' BORDER='0'  CELLSPACING='0' CELLPADDING='0'";
  var msgArr = new Array();
  msgArr = msg.split(']');
  for(var i = 0;i < msgArr.length;i++){
  	if(msgArr[i] != null && msgArr[i] != ""){
  	  var tmp = msgArr[i].replace("[", "");
  	  var tmpArr = new Array();
  	  tmpArr = tmp.split('/TAB/');
  	  content += "<TR>";
	  content += "<TD HEIGHT='20'><TABLE WIDTH='100%' BORDER='0' CELLSPACING='0' CELLPADDING='0'>";
 	  content += "<TR>";
 	  content += "<TD WIDTH='30' ALIGN='CENTER'><IMG SRC='" + tmpArr[0] + "' WIDTH='9' HEIGHT='9' /></TD>";
	  content += "<TD WIDTH='5'></TD>";
	  content += "<TD ALIGN='LEFT'>" + tmpArr[1] + "</TD>";
	  content += "</TR>";
	  content += "</TABLE></TD>";
	  content += "</TR>";
  	}
  }
  content +="</TABLE>";
  }
  get_xy();
  var _style = alt_div.style;
  if( msg != null ){
    alt_div.innerHTML = content;
    _style.visibility = "visible";
    if( _width != null ){
      if(alt_div.offsetWidth > _width ){
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
    "padding:2;" +
    "background-color:#E3F3F3;color:#000000;" + // 말풍선 테이블 백그라운드컬러 / 폰트컬러
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
function out_xy(){
//  alert(event.y+document.body.scrollTop);
  if(_out == "true"){
    var layer_x = alt_div.style.left;
    var layer_y = alt_div.style.top;
    var out_x = event.x+document.body.scrollLeft;
    layer_x = layer_x.substring(0, layer_x.length - 2);
    layer_y = layer_y.substring(0, layer_y.length - 2);
    var out_y = event.y+document.body.scrollTop;
    if(layer_x - 30 > out_x || out_x - 155 > layer_x){
      alt();
    }
    if(layer_y - 40 > out_y || layer_y< out_y -100){
      alt();
    }
  }
}
function get_xy()
{
  var _style = alt_div.style;
  var x = event.x+document.body.scrollLeft;
  var y = event.y+document.body.scrollTop;
  if(x < document.body.scrollWidth && y < document.body.scrollHeight){
    _style.left = x + 5;
    _style.top = y + 5;
    
    var tmpX = Number(_style.left.substring(0, _style.left.length - 2)) + alt_div.offsetWidth;
    var totalX = document.body.scrollWidth;
    
	if(totalX == tmpX){
		_style.left = Number(_style.left.substring(0, _style.left.length - 2)) - alt_div.offsetWidth;
	} 
	var tmpY = Number(_style.top.substring(0, _style.top.length - 2)) + alt_div.offsetHeight;
    var totalY = document.body.scrollHeight;
    
	if(tmpY == totalY){
		_style.top = Number(_style.top.substring(0, _style.top.length - 2)) - alt_div.offsetHeight;
	} 
  }
}

//-->
</script>

<table width="756" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td height="41" background="/PromesService/images/common/bar_01.gif"><table width="400" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="50">&nbsp;</td>
				<td width="18" valign="middle" class="noprint"><a href="javascript:changeCalendar('','sub');"><img src="/PromesService/images/common/icon_06.png" width="15" height="16" border="0" /></a></td>
				<td width="60">
					<select name="_year" class="select_white" style="width:55px" onchange="javascript:changeCalendar('','');">
					<option value="2007">2007</option>
				    <option value="2008">2008</option>
					<option value="2009">2009</option>
					<option value="2010">2010</option>
					<option value="2011">2011</option>
					<option value="2012">2012</option>
					<option value="2013">2013</option>
					<option value="2014" selected="selected">2014</option>
					<option value="2015">2015</option>
					<option value="2016">2016</option>
					<option value="2017">2017</option>
					<option value="2018">2018</option>
					<option value="2019">2019</option>
					</select>
				</td>
	            <td width="45"><select name="_month" class="select_white" style="width:40px" onchange="javascript:changeCalendar('','');">
				<%for(int i = 1; i <=12 ;i++){ 
					if(i < 10){%>
				    	<option value="0<%=i%>">0<%=i%></option>	
				    <%}else{%>
				    	<option value="<%=i%>"><%=i%></option>
					<%}
				} %>
				</select></td>
		        <td width="18" valign="middle" class="noprint"><a href="javascript:changeCalendar('','add');"><img src="/PromesService/images/common/icon_07.png" width="15" height="16" border="0" /></a></td>
		        <td>&nbsp;</td>
			</tr>
		</table></td>
	</tr>
	<tr>
		<td height="5"></td>
	</tr>
<tr>
	<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
    	<tr>
        	<td width="106" height="30" align="center" bgcolor="#e4eff0" class="td_table03">SUN</td>
			<td width="1" align="center" bgcolor="#ececec"></td>
			<td width="106" align="center" bgcolor="#e4eff0" class="td_table02">MON</td>
			<td width="1" align="center" bgcolor="#ececec"></td>
			<td width="106" align="center" bgcolor="#e4eff0" class="td_table02">TUE</td>
			<td width="1" align="center" bgcolor="#ececec"></td>
			<td width="106" align="center" bgcolor="#e4eff0" class="td_table02">WED</td>
			<td width="1" align="center" bgcolor="#ececec"></td>
			<td width="106" align="center" bgcolor="#e4eff0" class="td_table02">THU</td>
			<td width="1" align="center" bgcolor="#ececec"></td>
			<td width="106" align="center" bgcolor="#e4eff0" class="td_table02">FRI</td>
			<td width="1" align="center" bgcolor="#ececec"></td>
			<td align="center" bgcolor="#e4eff0" class="td_table04">SAT</td>
		</tr>
	</table></td>
</tr>
<tr>
	<td height="3" bgcolor="#a7c2bc"></td>
</tr>
<tr>
	<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <%
    int MonthlyTotalTakenDay=0;
    int MonthlyTakenCnt = 0;
    int count = 1;
    boolean isCount = false;
    int tmp = Integer.parseInt(firstDay) - 1 + Integer.parseInt(lastDate);
    int week = (int)(tmp / 7);
    if(tmp % 7 != 0){
    	week += 1;
	}
    for(int i = 0; i < week;i++){%>
    	<tr>
        	<td>
          		<table width="100%" border="0" cellspacing="0" cellpadding="0">
            		<tr>
		            <%for(int y = 0;y < 7;y++){
		            	if(i == 0 && (y + 1 == Integer.parseInt(firstDay))){
							isCount = true;
						}%>
              			<td width="106" height="28" align="center">
                			<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    		<%if(scheduleHash != null){
                    			String key = "" + count;
                        			if(scheduleHash.containsKey(key) && isCount){
                          				ArrayList schedules = (ArrayList)	scheduleHash.get(key);
                          				MonthlyTotalTakenDay++;
                          				String times = "";
                          				for(int x = 0; x < schedules.size(); x++){
              								ScheduleInfo scheduleInfo = (ScheduleInfo) schedules.get(x);
              								times += "[" + scheduleInfo.getId() + "/" + Util.changeIntToTime(scheduleInfo.getAlarmStartTime()) + "/";		
              								times += Util.changeIntToTime(scheduleInfo.getAlarmEndTime()) + "]";
                          				}%>
                          		<tr>
	                    			<td height="20" <%if(isCount){%>bgcolor="#dedeff"<%}%>><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                          	<tr>
	                            	<td onclick="javascript:detailTimePopup('<%=count %>','<%=schedules.size() %>', '<%=times%>');">&nbsp;</td>
	                            	<%if(isCount){
		                                if(y == 0){%>
	                            		<td width="25" class="td_table03" onclick="javascript:detailTimePopup('<%=count %>','<%=schedules.size() %>', '<%=times%>');"><%=count %></td>
	                            	<%  }else if(y == 6){%>
	                                	<td width="25" class="td_table04" onclick="javascript:detailTimePopup('<%=count %>','<%=schedules.size() %>', '<%=times%>');"><%=count %></td>	
	                            		<%}else{%>
		                             	<td width="25" class="td_login2" onclick="javascript:detailTimePopup('<%=count %>','<%=schedules.size() %>', '<%=times%>');"><%=count %></td></a>	
	                            		<%}
	                            	}else{ %>
	                            	<td width="25"></td>
	                            	<%} %>
	                          	</tr>
							</table></td>
						</tr>
                        <%	
                        int idx = schedules.size();
                        if(schedules.size() > 4){
                        	idx = 4;
						}
                        String altStr = "";
                        for(int x = 0;x < schedules.size();x++){
                        	ScheduleInfo scheduleInfo = (ScheduleInfo)schedules.get(x);
                            altStr += "["+ scheduleInfo.getTableString() + "]";
						}
						for(int x = 0;x < idx;x++)
						{
                        	ScheduleInfo scheduleInfo = (ScheduleInfo)schedules.get(x);
                        	String errorcolor = "";
                        	String errorscript = "";
                        	String memocolor = "";
                        	String memoscript = "";
                        	
                        	if(scheduleInfo.getCategory().trim().length() > 0 && (scheduleInfo.getImage() == Define.TAKEN_SATUS_NOTTAKEN_IMAGE || scheduleInfo.getImage() == Define.TAKEN_SATUS_FINISHUNTAKEN_IMAGE))
                        	//if(scheduleInfo.getCategory().trim().length() > 0 && (scheduleInfo.getImage() != Define.TAKEN_SATUS_NONE_IMAGE))
                        	{
                        		errorcolor = "yellow";
                        	}
                        	else
                        	{
                        		errorcolor = "";
                        	}
                        	
                        	if (scheduleInfo.getMemoContent().trim().length() > 0 || scheduleInfo.getTakencheck().length() > 0)
                        	{
                        		memocolor = "#FF6347";
                        	}
                        	else
                        	{
                        		memocolor = "";
                        	}                        	
                        	errorscript = "onclick=\"javascript:showErrorPopup('" + count +"', '" + scheduleInfo.getCategory() + "', '" + scheduleInfo.getErrorContent().replace("\r\n","<br>") + "', '"+scheduleInfo.getMemoContent().replace("\r\n","<br>") +"', '" +scheduleInfo.getId() + "', '" +scheduleInfo.getTakencheck()+"')\" style='cursor:hand;'"; 

                        	if( scheduleInfo.getImage() != Define.TAKEN_SATUS_NONE_IMAGE )
                        	{
                        		memoscript = "onclick=\"javascript:showMemoPopup('" + count +"', '" + scheduleInfo.getTakenStatus() + "', '" + scheduleInfo.getTakenTime() + "', '" + scheduleInfo.getMemoContent().replace("\r\n","<br>") + "', '" + scheduleInfo.getId() + "')\" style='cursor:hand;'";
                        		
                        	}
                        	else
                        	{
                        		memoscript = "";
                        	}
                        	
                          	if(schedules.size() > 4){%>
                          		<tr onmouseover="javascript:alt('<%=altStr%>')">
                          	<%}else{%>
                          		<tr>
                          	<%}%>
                            <td height="20">
                            	<table width="100%" border="0" cellspacing="0" cellpadding="0" <%=memoscript%>>
                            	<tr>
                            		<td width="7"></td>
                            		<%if(scheduleInfo.getImage().equals("")) {%>
                                  		<td width="10" align="center" >&nbsp;</td>
                                  	<%}else {
                                  		if(scheduleInfo.getTakenStatus().equals("PRETAKEN") || scheduleInfo.getTakenStatus().equals("FINISHTAKEN") )
                                  			MonthlyTakenCnt++;
                                  	%>
                                  		<td width="10" align="center"  ><img src="<%=scheduleInfo.getImage() %>" width="9" height="9" /></td>
                                  	<%} %>
                                  	<td width="5"></td>
                                  	<td align="left" bgcolor="<%=memocolor%>"><%=scheduleInfo.getTime() %></td>
                                </tr>
								</table> 
							</td>
							
						</tr>
                        <%}
						for(int x = schedules.size();x < 4 ;x++){%>
                        <tr>
							<td height="20">&nbsp;</td>
	                    </tr>
                        <%} 	
                        }else{%>
                            <tr>
	                    	  <td height="20" <%if(isCount){%>bgcolor="#dedeff"<%}%>><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <tr>
	                              <td>&nbsp;</td>
	                              <%if(isCount){
	                                  if(y == 0){%>
	                              	  <td width="25" class="td_table03" ><%=count %></td>
	                              <%  }else if(y == 6){%>
	                                    <td width="25" class="td_table04"><%=count %></td>	
	                              <%  }else{%>
	                                    <td width="25" class="td_login2"><%=count %></td>	
	                              <%  }
	                              }else{ %>
	                              <td width="25"></td>
	                              <%} %>
	                            </tr>
	                          </table></td>
	                   	    </tr>
	                        <tr>
	                          <td height="20">&nbsp;</td>
	                        </tr>
	                        <tr>
	                          <td height="20">&nbsp;</td>
	                        </tr>
	                        <tr>
	                          <td height="20">&nbsp;</td>
	                        </tr>
	                        <tr>
	                          <td height="20">&nbsp;</td>
	                        </tr>
                        <%}
                    }else{ %>
	                      <tr>
	                    	<td height="20" <%if(isCount){%>bgcolor="#dedeff"<%}%>><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                          <tr>
	                            <td>&nbsp;</td>
	                            <%if(isCount){
	                                if(y == 0){%>
	                            	  <td width="25" class="td_table03"><%=count %></td>
	                            <%  }else if(y == 6){%>
	                                  <td width="25" class="td_table04"><%=count %></td>	
	                            <%  }else{%>
	                                  <td width="25" class="td_login2"><%=count %></td>	
	                            <%  }
	                            }else{ %>
	                            <td width="25"></td>
	                            <%} %>
	                          </tr>
	                      </table></td>
	                    </tr>
                    	<tr>
                          <td height="20">&nbsp;</td>
                        </tr>
                        <tr>
                          <td height="20">&nbsp;</td>
                        </tr>
                        <tr>
                          <td height="20">&nbsp;</td>
                        </tr>
                        <tr>
                          <td height="20">&nbsp;</td>
                        </tr>
                    <%} %>
                </table></td>
                <td width="1" align="center" bgcolor="#ececec"></td>
                <%
                  if(Integer.parseInt(lastDate) == count){
                    isCount = false;

                  }else{
					if(isCount){                
                		count ++;  
					}
                  }
                } %>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td id="load" height="1" bgcolor="#ececec"></td>
        </tr>
        <%}%>
		</table></td>
	</tr>
</table>
</form>
</body>
</html>
<script>
$(window).load(function(){	
	var totalday = <%=MonthlyTotalTakenDay%>;
	var takenday = <%=MonthlyTakenCnt%>;
	var takenPercent = (takenday/totalday) * 100;
	takenPercent = takenPercent.toFixed(1);	
	$('td.MonthlyTakenCnt', parent.document).html('&nbsp;복용횟수 : ('+totalday + '/' + takenday + ') ' + takenPercent + '%');	
});
</script>


