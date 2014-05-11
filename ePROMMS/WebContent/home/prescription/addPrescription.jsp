<%@page contentType="text/html; charset=utf-8" isELIgnored = "false"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<% String prescriptionId  = (String) request.getAttribute("prescriptionId"); %>
<%UserInfo LoginuserInfo = (UserInfo)session.getAttribute("LoginuserInfo");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Prescription Addition</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
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
  window.open(theURL,winName,features);
}

function initsize() {
	
	var mainForm = document.form;	
	mainForm._id.value = parent.getId();	
	changeFrequency();
	parent.initsize();	
}

function clear(){
	parent.changeMenu('input');
}

function clearField()
{
	var mainForm = document.form;
	mainForm._pillBoxId.value = '';
	mainForm._pillBoxType.value = '';
	tmpPillBoxStr = '';
	mainForm._frequency.options[0].selected=true;
	mainForm._startDate.value = '';
	mainForm._endDate.value = '';
	changeFrequency();
}

//***************************** 약상자 관련 ******************************
function openPillBoxList(){
	var mainForm = document.form;
	if(mainForm._userId.value == null || mainForm._userId.value == "")
	{
		alert("<fmt:message key='search_patient_ID_after_entering_it.' />");
		return;
	}
	var x = 0; 
	var	y = 0;
	var w = 750;
	var h = 280;
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
	var point = "width=750, height=280, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	MM_openBrWindow('/PromesService/PromesServerServlet?cmd=loadPillBoxListPage&_userId=' + mainForm._userId.value,'pillBoxListPage',point);
}

//***************************** 달력 팝업 ******************************
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
	var point = "width=220, height=203, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=NO";
	MM_openBrWindow('/PromesService/PromesServerServlet?cmd=loadCalendarPage&type=' + type,'calendarPopup',point);
}

var tmpPillBoxStr = "";
function changePillBox(value1, value2, value3){
	var mainForm = document.form;
	mainForm._pillBoxId.value = value1;
	mainForm._pillBoxType.value = value2;
	var mainForm = document.form;
	var tmpCheck = mainForm._inputCheck
	tmpPillBoxStr = value3;
	changeFrequency();
	var tmpFrequency = mainForm._frequency.value;
	for(var i = 0; i < tmpFrequency; i++){
		changeTime(i);
	}
}

function changePrescriptionId(){
	var mainForm = document.form;
	var tmpPrescriptionId = mainForm._prescriptionId.value;
	var tmpHospital = mainForm._hospital.value;
	if(tmpPrescriptionId != "" && tmpHospital != ""){
		mainForm.cmd.value = "checkPrescriptionId";
		mainForm.target = "checkPrescriptionIdResultPage";
		mainForm.submit();
	}
}



//복용횟수 변경
function changeFrequency(){
	var mainForm = document.form;
	var tmpFrequency = mainForm._frequency.value;
	var tmpHtml = "";
	var startHtml = "";
	var endHtml = "";
	var timeStr = "";
	tmpHtml = "<table width=\"100%\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\" bgcolor=\"#ececec\">";
	tmpHtml += "<tr><td width=\"40\" height=\"22\" bgcolor=\"#e4eff0\" class=\"td_table02\">No.</td>";
	tmpHtml += "<td style=\"display:none;\" width=\"80\" bgcolor=\"#e4eff0\" class=\"td_table02\">NO</td><td width=\"90\" bgcolor=\"#e4eff0\" class=\"td_table02\"><fmt:message key='period' /></td>";
	tmpHtml += "<td width=\"160\" bgcolor=\"#e4eff0\" class=\"td_table02\"><fmt:message key='the_beginning_time' /></td><td width=\"160\" bgcolor=\"#e4eff0\" class=\"td_table02\"><fmt:message key='the_closed_time' /></td>";
	tmpHtml += "<td bgcolor=\"#e4eff0\" class=\"td_table02\"><fmt:message key='the_applied_time' /></td></tr>";
	var tmpColor = "#FFFFFF";
	
	for(var i = 0; i < tmpFrequency; i++){
		if(i % 2 == 0){
		tmpColor = "#FFFFFF";
		}else{
		   tmpColor = "#edfaf7";
		}
		tmpHtml += "<tr><td height=\"22\" align=\"center\" bgcolor=\""+tmpColor +"\">"+(i+1)+"</td>";
		tmpHtml += "<td style=\"display:none;\" align=\"center\" bgcolor=\""+tmpColor +"\">";
		tmpHtml += "<select name=\"_containerSelect\" id=\"_containerSelect\" class=\"select_white\" style=\"width:50px\">";
		if(tmpPillBoxStr != null && tmpPillBoxStr != ""){
			var result = new Array();
			result = tmpPillBoxStr.split(', ');
			for(var x=0;x < result.length;x++){
				tmpHtml += "<option value=\""+result[x] +"\">"+result[x]+"</option>";
			}
		} 
		tmpHtml += "</select></td><td align=\"center\" bgcolor=\""+tmpColor +"\">";
		tmpHtml += "<select name=\"_eatTime\" id=\"_eatTime\" class=\"select_white\" style=\"width:70px\" onchange=\"javascript:changeEatTime('"+i+"');\" >";
		//tmpHtml += "<option value=\"0\">아침</option><option value=\"1\">점심</option><option value=\"2\">저녁</option>";
		//tmpHtml += "<option value=\"3\">취침전</option><option value=\"4\" selected>직접입력</option></select></td>";
		tmpHtml += "<option value=\"4\" selected><fmt:message key='direct_input' /></option></select></td>";
		tmpHtml += "<td align=\"center\" bgcolor=\""+tmpColor +"\">";
		//tmpHtml += "<div id=\"startAlarmDiv\"><select name=\"_startAlarm" + i +"\" id=\"_startAlarm" + i +"\" class=\"select_white\" style=\"width:95px\" onchange=\"javascript:changeTime('"+i+"');\">";
		//tmpHtml += "<option value=\"0\">식전</option><option value=\"1\">식중</option>";
		//tmpHtml += "<option value=\"3\">식후</option><option value=\"4\">식후 30분</option></select></div></td>";
			//khj
			startHtml = "<table width=\"80\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
			startHtml += "<tr><td height=\"22\" align=\"center\">"; 
			startHtml += "<select name=\"_startAlarm1" + i +"\" id=\"_startAlarm1" + i +"\" class=\"select_white\" style=\"width:40px\" onchange=\"javascript:changeTime('"+i+"');\" >";
			for(var j=0;j <24;j++){
				if(j < 10){
					timeStr = "0"+j;                        			
	            }else{
	            	timeStr = ""+j;
	            }
				startHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
			}
			startHtml += "</select>&nbsp;:&nbsp;";
			startHtml += "<select name=\"_startAlarm2" + i +"\" id=\"_startAlarm2" + i +"\" class=\"select_white\" style=\"width:40px\" onchange=\"javascript:changeTime('"+i+"');\" >";
			for(var j=0;j <=59;j+=10){
				if(j < 10){
					timeStr = "0"+j;                        			
	            }else{
	            	timeStr = ""+j;
	            }
				startHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
			}
			startHtml += "</td></tr></table>";
		tmpHtml += startHtml+"</td>";
		tmpHtml += "<td align=\"center\" bgcolor=\""+tmpColor +"\">";
		//tmpHtml += "<div id=\"stopAlarmDiv\"><select name=\"_stopAlarm" + i +"\" id=\"_stopAlarm" + i +"\" class=\"select_white\" style=\"width:95px\" onchange=\"javascript:changeTime('"+i+"');\" >";
		//tmpHtml += "<option value=\"30\">30분</option><option value=\"60\">1시간</option><option value=\"90\">1시간 30분</option>";
		//tmpHtml += "<option value=\"120\">2시간</option></select></div></td>";
			endHtml = "<table width=\"80\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
			endHtml += "<tr><td height=\"22\" align=\"center\">"; 
			endHtml += "<select name=\"_endAlarm1" + i +"\" id=\"_endAlarm1" + i +"\" class=\"select_white\" style=\"width:40px\" onchange=\"javascript:changeTime('"+i+"');\" >";
			for(var j=0;j <24;j++){
				if(j < 10){
					timeStr = "0"+j;                        			
	            }else{
	            	timeStr = ""+j;
	            }
				endHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
			}
			endHtml += "</select>&nbsp;:&nbsp;";
			endHtml += "<select name=\"_endAlarm2" + i +"\" id=\"_endAlarm2" + i +"\" class=\"select_white\" style=\"width:40px\" onchange=\"javascript:changeTime('"+i+"');\" >";
			for(var j=0;j <=59;j+=10){
				if(j < 10){
					timeStr = "0"+j;                        			
	            }else{
	            	timeStr = ""+j;
	            }
				endHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
			}
			endHtml += "</td></tr></table>";
		tmpHtml += endHtml+"</td>";
		tmpHtml += "<td align=\"center\" bgcolor=\""+tmpColor +"\">";
		tmpHtml += "<input name=\"_inputTime\" align=\"center\" type=\"text\" class=\"inputbox2\" size=\"40\" id=\"_inputTime\" readonly=\"true\" /></td>";
		tmpHtml += "</tr>";
	}
	tmpHtml += "</table>";
	prescriptionTimeTableDiv.innerHTML = "" + tmpHtml;

	if(mainForm._startTakenOrder.length > 0){
		for(var i=mainForm._startTakenOrder.length -1;i >=0;i--){
  			mainForm._startTakenOrder.removeChild(mainForm._startTakenOrder.options[i]);
  			mainForm._endTakenOrder.removeChild(mainForm._endTakenOrder.options[i]);
		}
	}
	for(var y=1;y <= tmpFrequency;y++){
		mainForm._startTakenOrder[mainForm._startTakenOrder.length] = new Option(y,y);
		mainForm._endTakenOrder[mainForm._endTakenOrder.length] = new Option(y,y);
	}
	mainForm._endTakenOrder.value = mainForm._startTakenOrder.options[(mainForm._startTakenOrder.length - 1)].value;
	
	for(var z = 0; z < tmpFrequency; z++){
		changeTime(z);
	}
	
	parent.initsize();
}

function changeEatTime(value){
	var mainForm = document.form;
	var tmpFrequency = mainForm._frequency.value;
	var tmpEatTime = 0;
	if(tmpFrequency == 1){
		tmpEatTime = mainForm._eatTime.value;
	}else{
		tmpEatTime = mainForm._eatTime[value].value;
	}
	if(tmpEatTime == 4){
		var startHtml = "";
		var endHtml = "";
		var timeStr = "";
		startHtml = "<table width=\"80\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
		startHtml += "<tr><td height=\"22\" align=\"center\">"; 
		startHtml += "<select name=\"_startAlarm1" + value +"\" id=\"_startAlarm1" + value +"\" class=\"select_white\" style=\"width:40px\" onchange=\"javascript:changeTime('"+value+"');\" >";
		for(var i=0;i <24;i++){
			if(i < 10){
				timeStr = "0"+i;                        			
            }else{
            	timeStr = ""+i;
            }
			startHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
		}
		startHtml += "</select>&nbsp;:&nbsp;";
		startHtml += "<select name=\"_startAlarm2" + value +"\" id=\"_startAlarm2" + value +"\" class=\"select_white\" style=\"width:40px\" onchange=\"javascript:changeTime('"+value+"');\" >";
		for(var i=0;i <=59;i+=10){
			if(i < 10){
				timeStr = "0"+i;                        			
            }else{
            	timeStr = ""+i;
            }
			startHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
		}
		startHtml += "</td></tr></table>";
		if(mainForm._frequency.value == 1){
			startAlarmDiv.innerHTML = "" + startHtml;
		}else{
			startAlarmDiv[value].innerHTML = "" + startHtml;
		}

		endHtml = "<table width=\"80\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
		endHtml += "<tr><td height=\"22\" align=\"center\">"; 
		endHtml += "<select name=\"_endAlarm1" + value +"\" id=\"_endAlarm1" + value +"\" class=\"select_white\" style=\"width:40px\" onchange=\"javascript:changeTime('"+value+"');\" >";
		for(var i=0;i <24;i++){
			if(i < 10){
				timeStr = "0"+i;                        			
            }else{
            	timeStr = ""+i;
            }
			endHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
		}
		endHtml += "</select>&nbsp;:&nbsp;";
		endHtml += "<select name=\"_endAlarm2" + value +"\" id=\"_endAlarm2" + value +"\" class=\"select_white\" style=\"width:40px\" onchange=\"javascript:changeTime('"+value+"');\" >";
		for(var i=0;i <=59;i+=10){
			if(i < 10){
				timeStr = "0"+i;                        			
            }else{
            	timeStr = ""+i;
            }
			endHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
		}
		endHtml += "</td></tr></table>";
		if(mainForm._frequency.value == 1){
			stopAlarmDiv.innerHTML = "" + endHtml;
		}else{
			stopAlarmDiv[value].innerHTML = "" + endHtml;
		}
	}else if(tmpEatTime == 3){
		var tmpHtml = "";
		var tmp = '_startAlarm1' + value;
		var tmpObj = document.getElementById(tmp);
		tmpHtml += "<select name=\"_startAlarm" + value +"\" id=\"_startAlarm" + value +"\" class=\"select_white\" style=\"width:95px\" onchange=\"javascript:changeTime('"+value+"');\" >";
		tmpHtml += "<option value=\"0\"><fmt:message key='before_sleep' /> 30</option><option value=\"1\"><fmt:message key='before_sleep' /></option></select>";	
		if(mainForm._frequency.value == 1){
			startAlarmDiv.innerHTML = "" + tmpHtml;
		}else{
			startAlarmDiv[value].innerHTML = "" + tmpHtml;
		}
		tmpHtml = "<select name=\"_stopAlarm" + value +"\" id=\"_stopAlarm" + value +"\" class=\"select_white\" style=\"width:95px\" onchange=\"javascript:changeTime('"+value+"');\" >";
		tmpHtml += "<option value=\"30\"><fmt:message key='after_30_min' /></option><option value=\"60\"><fmt:message key='1_hour' /></option><option value=\"90\"><fmt:message key='1_hour_30_min' /></option>";
		tmpHtml += "<option value=\"120\"><fmt:message key='2_hour' /></option></select>";
		if(mainForm._frequency.value == 1){
			stopAlarmDiv.innerHTML = "" + tmpHtml;
		}else{
			stopAlarmDiv[value].innerHTML = "" + tmpHtml;
		}
	}else{
		var tmpHtml = "";
		var tmp = '_startAlarm1' + value;
		var tmpObj = document.getElementById(tmp);
		tmpHtml += "<select name=\"_startAlarm" + value +"\" id=\"_startAlarm" + value +"\" class=\"select_white\" style=\"width:95px\" onchange=\"javascript:changeTime('"+value+"');\" >";
		tmpHtml += "<option value=\"0\"><fmt:message key='before_the_meal' /></option><option value=\"1\"><fmt:message key='during_the_meal' /></option>";
		tmpHtml += "<option value=\"3\"><fmt:message key='after_the_meal' /></option><option value=\"4\"><fmt:message key='30min_after_the_meal' /></option></select>";	
		if(mainForm._frequency.value == 1){
			startAlarmDiv.innerHTML = "" + tmpHtml;
		}else{
			startAlarmDiv[value].innerHTML = "" + tmpHtml;
		}
		tmpHtml = "<select name=\"_stopAlarm" + value +"\" id=\"_stopAlarm" + value +"\" class=\"select_white\" style=\"width:95px\" onchange=\"javascript:changeTime('"+value+"');\" >";
		tmpHtml += "<option value=\"30\"><fmt:message key='after_30_min' /></option><option value=\"60\"><fmt:message key='1_hour' /></option><option value=\"90\"><fmt:message key='1_hour_30_min' /></option>";
		tmpHtml += "<option value=\"120\"><fmt:message key='2_hour' /></option></select>";
		if(mainForm._frequency.value == 1){
			stopAlarmDiv.innerHTML = "" + tmpHtml;
		}else{
			stopAlarmDiv[value].innerHTML = "" + tmpHtml;
		}
	}
	changeTime(value);
}

function changeTime(idx){
	var mainForm = document.form;
	var tmpFrequency = mainForm._frequency.value;
	var tmpEatTime = 0;
	if(tmpFrequency == 1){
		tmpEatTime = mainForm._eatTime.value;
	}else{
		tmpEatTime = mainForm._eatTime[idx].value;
	}	
	if(tmpEatTime == 4){
		var tmp = '_startAlarm1' + idx;
		var tmpObj = document.getElementById(tmp);
		var tmpStartTime1 = tmpObj.value
		tmp = '_startAlarm2' + idx;
		tmpObj = document.getElementById(tmp);
		var tmpStartTime2 = tmpObj.value
		tmp = '_endAlarm1' + idx;
		tmpObj = document.getElementById(tmp);
		var tmpEndTime1 = tmpObj.value
		tmp = '_endAlarm2' + idx;
		tmpObj = document.getElementById(tmp);
		var tmpEndTime2 = tmpObj.value
		if(mainForm._inputTime != null && mainForm._inputTime.length != undefined){
			mainForm._inputTime[idx].value = tmpStartTime1 + ":"+ tmpStartTime2 + " ~ " + tmpEndTime1 + ":"+ tmpEndTime2;
		}else{
			mainForm._inputTime.value = tmpStartTime1 + ":"+ tmpStartTime2 + " ~ " + tmpEndTime1 + ":"+ tmpEndTime2;
		}
	}else{
		var tmp2 = '_startAlarm' + idx;
		var tmpObj2 = document.getElementById(tmp2);
		var tmpStart = tmpObj2.value;
		tmp2 = '_stopAlarm' + idx;
		tmpObj2 = document.getElementById(tmp2);
		var tmpEnd= tmpObj2.value;
		var tmpTime = addPrescriptionResultPage.getTime(tmpEatTime, tmpStart);
		if(tmpTime != null && tmpTime != ""){
			var timeArr = tmpTime.split(":");
			var dt=new Date();
			dt.setUTCHours(timeArr[0]);
			dt.setUTCMinutes(timeArr[1]);
			dt.setUTCMinutes(dt.getUTCMinutes() + parseInt(tmpEnd));
			
			var tmpSumTime = "";
			if(dt.getUTCHours() < 10){
				tmpSumTime += "0"+dt.getUTCHours() + ":";
			}else{
				tmpSumTime += dt.getUTCHours() + ":";
			}
			if(dt.getUTCMinutes() < 10){
				tmpSumTime += "0"+dt.getUTCMinutes();
			}else{
				tmpSumTime += dt.getUTCMinutes();
			}
			if(mainForm._inputTime != null && mainForm._inputTime.length != undefined){
			
				mainForm._inputTime[idx].value = tmpTime + " ~ " + tmpSumTime;
			}else{
				mainForm._inputTime.value = tmpTime + " ~ " + tmpSumTime;
			}
		}else{
			if(mainForm._inputTime != null && mainForm._inputTime.length != undefined){
				mainForm._inputTime[idx].value = "";
			}else{
				mainForm._inputTime.value = "";
			}
		}
	}
}

function changeTotalDays(){
	var mainForm = document.form;
	if(mainForm._startDate.value != null && mainForm._startDate.value != ""){
		changeDate('start', mainForm._startDate.value);
	}
}

//***************************** 복용 시작, 종료 날짜 변경 ******************************
function getDate(date, num, operator){
	var mainForm = document.form;
	var tmp = date;
	tmp = tmp.replace('년 ', '-');
	tmp = tmp.replace('월 ', '-');
	tmp = tmp.replace('일', '');
	tmp = trim(tmp.split('-'));	
	dt = new Date(tmp[0], tmp[1] - 1, eval(tmp[2] + operator + num));
	var tmpDate = dt.getFullYear() + "년 " + ((dt.getMonth() + 1)<10? "0" + (dt.getMonth() + 1) : (dt.getMonth() + 1)) + "월 ";
	tmpDate += (dt.getDate()<10 ? "0" + dt.getDate() : dt.getDate()) + "일";
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

function changeDate(type, value){
	
	var mainForm = document.form;
	var todayDt = new Date();
	var dt = new Date();
	var tmpDate = mainForm._totalDays.value;
	if(type == 'start'){
		if(Number(getTimeDistance(value)) < 0){
			alert("<fmt:message key='the_beginning_date_is_already_passed.' />");
			return;
		}		
		mainForm._startDate.value = value;
		
		if(mainForm._totalDays.value != ''){
			if(mainForm._frequency.value != 1){
				if(mainForm._startTakenOrder.value == 1){
				
					tmpDate = tmpDate - 1;
				}
			}else{
				tmpDate = tmpDate - 1;
			}
			mainForm._endDate.value = getDate(mainForm._startDate.value, tmpDate, '+');
		}
	}else if(type == 'end'){
		mainForm._endDate.value = value;
		if(mainForm._totalDays.value != ''){
			if(mainForm._frequency.value != 1){
				if(mainForm._startTakenOrder.value == 1){
					tmpDate = tmpDate - 1;
				}			
			}else{
				tmpDate = tmpDate - 1;
			}
			mainForm._startDate.value = getDate(mainForm._endDate.value, tmpDate, '-');
			if(Number(getTimeDistance(mainForm._startDate.value)) < 0){
				alert("<fmt:message key='the_beginning_date_is_already_passed._Please_enter_again_the_closed_date.' />");
				mainForm._startDate.value = "";
				mainForm._endDate.value = "";
				return;
			}
		}
	}
	alt();
}

function changeTakenOrder(value){	
	var mainForm = document.form;
	var endOrder = mainForm._startTakenOrder.options[(mainForm._startTakenOrder.length - 1)].value;
	
	if(value == "start"){
		if(mainForm._startTakenOrder.value == 1){
			mainForm._endTakenOrder.value = endOrder;
		}else{
			mainForm._endTakenOrder.value = (Number(mainForm._startTakenOrder.value) - 1);
		}
	}else{
		if(mainForm._endTakenOrder.value == endOrder){
			mainForm._startTakenOrder.value = 1;
		}else{
			mainForm._startTakenOrder.value = (Number(mainForm._endTakenOrder.value) + 1);
		}
	}
	if(mainForm._startDate.value != null && !mainForm._startDate.value == ""){
		changeDate("start", mainForm._startDate.value);
	}
}

function findUser(){	
	var mainForm = document.form;
	if(mainForm._userName.value != null && mainForm._userName.value != '')
	{
		var tmpName = encodeURIComponent(mainForm._userName.value); 
		var x = 0; 
		var	y = 0;
		var w = 700;
		var h = 280;
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
		var point = "width=700, height=280, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";	
		var tmpUrl = '/PromesService/PromesServerServlet?cmd=loadUserListPopupPage&_userName=' + tmpName + '&_target=addPrescriptionResultPage';
		MM_openBrWindow(tmpUrl,'findUserPopup',point);
	}
}

function setUserId(value){
	var mainForm = document.form;
	mainForm._userId.value = value;
}

function setUserName(value){
	var mainForm = document.form;
	mainForm._userName.value = value;
}

function getUserId(){
	var mainForm = document.form;
	return mainForm._userId.value;
}

function returnUserName(){
	var mainForm = document.form;
	mainForm._userName.value = addPrescriptionResultPage.getUserName();
}

function loadSearch(){
	parent.changeMenu('list');
}

function addPrescription(){
	var mainForm = document.form;	
	var tmpStr = "";
	if(!fieldCheck()){
		return;
	}
		
	tmpStr += timeCheck();
	
	if(tmpStr == ""){
		return;
	}
	
	if(!orderCheck()){
		return;
	}
	mainForm.cmd.value = 'addPrescription';
	if('${LoginuserInfo.type}' == "ADMIN"){
		mainForm.target = "managementMainPage";
	}else{
		mainForm.target = "prescriptionMainPage";	
	}
	
	mainForm._takenOrderProperties.value = tmpStr;
	mainForm.submit();
}

function fieldCheck(){
	var mainForm = document.form;
	if(mainForm._prescriptionId.value == null || mainForm._prescriptionId.value == ""){
		alert("<fmt:message key='enter_the_registered_ID' />");
		return false;
	}else if(mainForm._hospital.value == null || mainForm._hospital.value == ""){
		alert("<fmt:message key='enter_the_health_centers' />");
		return false;
	}else if(mainForm._userId.value == null || mainForm._userId.value == ""){
		alert("<fmt:message key='enter_patient_ID' />");
		return false;
	}else if(mainForm._pillBoxId.value == null || mainForm._pillBoxId.value == ""){
		alert("<fmt:message key='choose_the_pillbox' />");
		return false;
	}else if(mainForm._totalDays.value == null || mainForm._totalDays.value == ""){
		alert("<fmt:message key='enter_the_duration_of_medication' />");
		return false;
	}
	return true;
}

function timeCheck(){
	var mainForm = document.form;
	var tmpStr = "";
	var tmpFrequency = mainForm._frequency.value; 
	for(var i = 0;i < tmpFrequency;i++)
	{
		if(tmpFrequency == 1)
		{
			/*
			if(mainForm._containerSelect.value == null || mainForm._containerSelect.value == "")
			{
				alert((i+1)+"칸 번호를 확인 하세요.");
				return "";
			}*/
		}
		else
		{
			/*
			if(mainForm._containerSelect[i].value == null || mainForm._containerSelect[i].value == "")
			{
				alert((i+1)+"칸 번호를 확인 하세요.");
				return "";
			}*/
		}
		var tmpTime = ""; 
		if(mainForm._inputTime != null && mainForm._inputTime.length != undefined){
			tmpTime = mainForm._inputTime[i].value;
		}else{
			tmpTime = mainForm._inputTime.value;
		}

		if(tmpTime == ""){
			alert("confirm" +(i+1)+ "begnining times per day of medication");
			return "";
		}
		var tmpTimeArr = tmpTime.split(' ~ ');
		
		if(tmpTimeArr[0] == tmpTimeArr[1]){
			alert((i+1)+" beginning and closing time per day of medication are same.");
			return "";
		}
		
		var dis = timeDistance(tmpTimeArr[0], tmpTimeArr[1]);
		
		if(dis < 0){
			alert("the 1st beginning time of medication per day is same as the "+ (i+1) + "time of medication.");
			return "";
		}
	}

	for(var x = 0;x < tmpFrequency;x++){
		for(var z = 0;z < tmpFrequency;z++){
			if(x < z){
				var basisTime = mainForm._inputTime[x].value;
				var nextTime = mainForm._inputTime[z].value;
				if(mainForm._containerSelect[x].value == mainForm._containerSelect[z].value){
					if( basisTime ==  nextTime){
						alert("<fmt:message key="A_block_in_the_pillbox_can't_be_used_more_than_twice_at_the_same_time._" />");
						return "";
					}
				}
				
				if( basisTime != nextTime){
					var basisTimeArr = basisTime.split(' ~ ');
					var nextTimeArr = nextTime.split(' ~ ');
					var disTime = timeDistance(basisTimeArr[0], nextTimeArr[0]);
					if(disTime < 0){
						alert("the "+(z+1)+" beginning time of medication per day is in advance to the "+(x+1)+" beginning time of medication.");
						return "";
					}else{
						if(mainForm._containerSelect[x].value == mainForm._containerSelect[z].value){
							disTime = timeDistance(basisTimeArr[1], nextTimeArr[1]);
							if(disTime < 0){
								alert("the " +(z+1)+ " closing time of medication per day is in advance to the "+(x+1)+" closing time of medication.");
								return "";
							}
						}
					}
				}
			}
		}
	}

	for(var y = 0;y < tmpFrequency;y++){
		var tmpTime = ""; 
		if(mainForm._inputTime != null && mainForm._inputTime.length != undefined){
			tmpTime = mainForm._inputTime[y].value;
		}else{
			tmpTime = mainForm._inputTime.value;
		}

		var tmpTimeArr = tmpTime.split(' ~ ');
		
		if(tmpFrequency == 1){
			//tmpStr += "["+(y+1)+ "/" + mainForm._containerSelect.value + "/" + tmpTimeArr[0].replace(':', '') + "/" + tmpTimeArr[1].replace(':', '') + "]";
			tmpStr += "["+(y+1)+ "/1/" + tmpTimeArr[0].replace(':', '') + "/" + tmpTimeArr[1].replace(':', '') + "]";
		}else{
			//tmpStr += "["+(y+1)+ "/" + mainForm._containerSelect[y].value + "/" + tmpTimeArr[0].replace(':', '') + "/" + tmpTimeArr[1].replace(':', '') + "]";
			tmpStr += "["+(y+1)+ "/1/" + tmpTimeArr[0].replace(':', '') + "/" + tmpTimeArr[1].replace(':', '') + "]";
		}
	}
	return tmpStr;
}

function timeDistance(startTime, endTime){
	var tmpStartArr = startTime.split(':');
	var tmpEndArr = endTime.split(':');
	
	var startDt=new Date();
	var endDt=new Date();
	
	startDt.setUTCHours(tmpStartArr[0]);
	startDt.setUTCMinutes(tmpStartArr[1]);
	endDt.setUTCHours(tmpEndArr[0]);
	endDt.setUTCMinutes(tmpEndArr[1]);
	
	var dis = endDt.getTime() - startDt.getTime();
	return dis
}

function orderCheck(){
	var mainForm = document.form;
	var todayDt = new Date();
	var dt = new Date();
	var today = todayDt.getFullYear() + "- " + ((todayDt.getMonth() + 1)<10? "0" + (todayDt.getMonth() + 1) : (todayDt.getMonth() + 1)) + "- ";
	today += (todayDt.getDate()<10 ? "0" + todayDt.getDate() : todayDt.getDate()) + "";
	if(today == mainForm._startDate.value){
		var tmpOrder = mainForm._startTakenOrder.value;
		var tmpTime = "";
		if(mainForm._inputTime.length == undefined){
			tmpTime = mainForm._inputTime.value;
		}else{
			tmpTime = mainForm._inputTime[tmpOrder - 1].value;
		}
		
		var tmpTimeArr = tmpTime.split(' ~ ');
		var tmpEndTime = tmpTimeArr[1].split(':');
		dt.setHours(tmpEndTime[0]);
		dt.setMinutes(tmpEndTime[1]);
		dt.setSeconds(59);
		var dis = dt.getTime() - todayDt.getTime();
		
		if(dis < 0){
			alert("<fmt:message key='there_is_the_schedule_passed_already._Please_edit_the_beginning_times_for_medication.' />");
			return false;
		}		
	}
	return true;
}

function numberText(){
	if((event.keyCode < 48) || (event.keyCode > 57))
  	event.returnValue = false;
}

function resetId(){
	var mainForm = document.form;
	mainForm._prescriptionId.value = "";
	mainForm._hospital.value = "";
}

function hospitalCheck(){
	var mainForm = document.form;
	var tmpHospital = mainForm._hospital.value;
	var len = 0;
    for (var i=0; i<tmpHospital.length; i++) {
		len += (tmpHospital.charCodeAt(i) > 128) ? 2 : 1;
        if (len > 20){
        	alert("<fmt:message key='the_name_of_health_facilities_can_be_less_than_20_letters._Please_enter_again.' />");
       	  	mainForm._hospital.value = "";
       	  	event.returnValue = false;
       	  	return;
        }
	}
}

function checkDisease(){	
	var mainForm = document.form;
	var tmpDisease = mainForm._disease.value;
	var len = 0;
    for (var i=0; i<tmpDisease.length; i++) {
		len += (tmpDisease.charCodeAt(i) > 128) ? 2 : 1;
        if (len > 50){
        	alert("<fmt:message key='the_name_of_health_facilities_can_be_less_than_50_letters._Please_enter_again.' />");
       	  	mainForm._disease.value = "";
       	  	event.returnValue = false;
       	  	return;
        }
	}
}

function checkDirection(){
	var mainForm = document.form;
	var tmpDirection = mainForm._direction.value;
	var len = 0;
    for (var i=0; i<tmpDirection.length; i++) {
		len += (tmpDirection.charCodeAt(i) > 128) ? 2 : 1;
        if (len > 200){
        	alert("<fmt:message key='notice_can_be_less_than_200_letters._Please_enter_again.' />");
       	  	mainForm._direction.value = "";
       	  	event.returnValue = false;
       	  	return;
        }
	}
}

function choiceUser(value, pillBoxId, pillBoxType, target)
{
	var mainForm = document.form;
	var tmpId = mainForm._userId.value;
	
	if(tmpId != null && tmpId != "")
	{
		if(tmpId != value)
		{
			if(confirm("<fmt:message key='The_partial_data_would_be_default_when_you_change_users._Do_you_continue_it?' />"))
			{
				clearField();
				mainForm.cmd.value = 'userInfoResult';
				mainForm._userId.value = value;
				mainForm._pillBoxId.value = pillBoxId;
				mainForm._pillBoxType.value = pillBoxType;
				mainForm.target = target;
				mainForm.submit();	
			}
		}
	}
	else
	{
		mainForm.cmd.value = 'userInfoResult';
		mainForm._userId.value = value;
		mainForm._pillBoxId.value = pillBoxId;
		mainForm._pillBoxType.value = pillBoxType;
		mainForm.target = target;
		mainForm.submit();
	}
}

//***************************** 달력 관련(말풍선) ******************************
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
  content += type +"\" frameborder=\"0\" scrolling=\"auto\" framespacing=\"0\" height=\"100%\" width=\"100%\" ></iframe>";
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
	x = point_x - 220;
	y = point_y - 203;
	if(x < 780 && y < 610){
	  _style.left = x - 5;
	  _style.top = y - 5;
	}
}
//******************************처방병원 및 담당자 선택 팝업***********************
function openSelectIncharge(){	
	var x = 0; 
	var	y = 0;
	var w = 250;
	var h = 260;
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
	var point = "width=250, height=260, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	var tmpUrl = '/PromesService/home/prescription/searchIncharge_popup.jsp';
	MM_openBrWindow(tmpUrl,'selectInchargepopup',point);
}

//searchIncharge.jsp 에서 사용
function inputId(value){
	var mainForm = document.form;
	mainForm._id.value = value;
}
//-->
</script>
</head>
<body onload="initsize();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/prescription/left_menu_b_.gif','/PromesService/images/prescription/left_menu_c_.gif','/PromesService/images/common/bt_input_.gif','/PromesService/images/common/bt_initialize_.gif','/PromesService/images/common/bt_list_.gif')">
<form name="form" method="post"	action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value="" />
<input name="_takenOrderProperties"	type="hidden" value="" />
<input name="_id" type="hidden" value="" />
<table width="794" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="/PromesService/images/prescription/main_title_a.gif" width="794" height="35" /></td>
	</tr>
	<tr>
		<td height="15">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="794" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="794" border="0" cellspacing="0" cellpadding="0">
			 		<tr>
						<td height="1" bgcolor="#ececec"></td>
					</tr>
					
						
				 		<c:if test="${LoginuserInfo.type == 'INCHARGE'}" var="result">
				 			<tr style="display: none;" >
   						</c:if>
   						<c:if test="${LoginuserInfo.type != 'INCHARGE'}" var="result">
				 			<tr >
   						</c:if>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">*<fmt:message key='the_registered_number_of_patient' /></td>
								<td width="281">&nbsp; <input name="_prescriptionId" type="text" class="inputbox" size="32" id="_prescriptionId"   readonly="readonly" value="<%=prescriptionId %>" /></td>
								<!-- <td width="281">&nbsp; <input name="_prescriptionId" type="text" class="inputbox" size="42" id="_prescriptionId"   onchange="javascript:changePrescriptionId();" readonly="readonly"/></td> -->
								<td width="96" bgcolor="#ddebec" class="td_table02">*<fmt:message key='the_healthcare_center_of_prescription' /></td>
								<td>&nbsp; <input name="_hospital" type="text" class="inputbox" size="32" id="_hospital"   value="${LoginuserInfo.company}" onclick="javascript:openSelectIncharge();"/></td>
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
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">*<fmt:message key='patient_name' /></td>
								<td width="281">&nbsp; <input name="_userName" type="text" class="inputbox" size="32" id="_userName" onchange="javascript:findUser();" onkeydown="javascript:if(event.keyCode==13 || window.event.keyCode ==9){findUser();}"    /></td>
								<td width="96" bgcolor="#ddebec" class="td_table02">*<fmt:message key='patient_Identification' /></td>
								<td>&nbsp; <input name="_userId" type="text" class="inputbox" size="32" id="_userId" readonly="true" /></td>
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
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">*<fmt:message key='the_pillbox' /></td>
								<td width="281">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="245">&nbsp; <input name="_pillBoxId" type="text" class="inputbox" size="32" id="_pillBoxId" readonly="true" /></td>
										<!--<td><a href="javascript:openPillBoxList();"><img src="/PromesService/images/common/icon_search.gif" width="25" height="25" border="0" /></a></td>  -->
									</tr>
								</table>
								</td>
								<td width="96" bgcolor="#ddebec" class="td_table02">*<fmt:message key='configurator' /></td>
								<td>&nbsp; <input name="_pillBoxType" type="text" class="inputbox" size="32" id="_pillBoxType" readonly="true" /></td>
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
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">*<fmt:message key='the_duration_of_medication' /></td>
								<td width="281">
								<table width="281" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="245">&nbsp; <input name="_totalDays" type="text" class="inputbox" size="32" id="_totalDays" onchange="javascript:changeTotalDays();" onkeydown="javascript:if(event.keyCode==13 || window.event.keyCode ==9){changeTotalDays();}"   onkeypress="javascript:numberText();"  /></td>
										<td>jours</td>
									</tr>
								</table>
								</td>
								<td width="96" bgcolor="#ddebec" class="td_table02">*<fmt:message key='the_frequency_of_medication' /></td>
								<td>&nbsp; 
									<select name="_frequency" id="_frequency" class="select_white" style="width: 260px" onchange="javascript:changeFrequency();">
										<option value="1" selected="true">1 les temps</option>
									</select>
								</td>
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
								<td width="96" height="38" bgcolor="#ddebec" class="td_table02"><fmt:message key='disease_name' /></td>
								<td>&nbsp; <textarea name="_disease" cols="103" class="select_white" id="_disease" onkeydown="javascript:checkDisease();"></textarea></td>
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
								<td width="96" height="38" bgcolor="#ddebec" class="td_table02"><fmt:message key='notice' /></td>
								<td>&nbsp; <textarea name="_direction" cols="103" class="select_white" id="_direction" onkeydown="javascript:checkDirection();"></textarea></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="1" bgcolor="#ececec"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="15">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<div id="prescriptionTimeTableDiv">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#ececec">
					<tr>
						<td width="40" height="22" bgcolor="#e4eff0" class="td_table02">No.</td>
						<td style="display:none;" width="80" bgcolor="#e4eff0" class="td_table02">nombre de bloc</td>
						<td width="90" bgcolor="#e4eff0" class="td_table02"><fmt:message key='period' /></td>
						<td width="160" bgcolor="#e4eff0" class="td_table02"><fmt:message key='the_beginning_time' /></td>
						<td width="160" bgcolor="#e4eff0" class="td_table02"><fmt:message key='the_end_time' /></td>
						<td bgcolor="#e4eff0" class="td_table02"><fmt:message key='the_applied_time' /></td>
					</tr>
					<%
						String tmpColor = "#FFFFFF";
						for (int i = 0; i < 4; i++) {
							if (i % 2 == 0) {
								tmpColor = "#FFFFFF";
							} else {
								tmpColor = "#edfaf7";
							}
					%>
					<tr>
						<td height="22" align="center" bgcolor="<%=tmpColor %>"><%=(i + 1)%></td>
					 	<td style="display:none;" align="center" bgcolor="<%=tmpColor %>"><select name="_containerSelect" id="containerSelect" class="select_white" style="width: 50px">
							<option selected="selected"></option>
						</select></td>
						<td align="center" bgcolor="<%=tmpColor %>"><select name="_eatTime" id="_eatTime" class="select_white" style="width: 70px" onchange="javascript:changeEatTime('<%=i %>');">
							<option value="0"><fmt:message key='breakfast' /></option>
							<option value="1"><fmt:message key='lunch' /></option>
							<option value="2"><fmt:message key='dinner' /></option>
							<option value="3"><fmt:message key='before_sleep' /></option>
							<option value="4" selected><fmt:message key='direct_input' /></option>
						</select></td>
						<td align="center" bgcolor="<%=tmpColor %>">
						<div id="startAlarmDiv"><select name="_startAlarm" id="_startAlarm" class="select_white" style="width: 95px" onchange="javascript:changeTime('<%=i %>');">
							
							<option value="1"><fmt:message key='before_the_meal' /></option>
							<option value="2"><fmt:message key='during_the_meal' /></option>
							<option value="3"><fmt:message key='after_the_meal' /></option>
							<option value="4"><fmt:message key='30min_after_the_meal' /></option>
						</select></div>
						</td>
						<td align="center" bgcolor="<%=tmpColor %>">
						<div id="stopAlarmDiv"><select name="_stopAlarm" id="_stopAlarm" class="select_white" style="width: 95px" onchange="javascript:changeTime('<%=i %>');">
							<option value="30"><fmt:message key='after_30_min' /></option>
							<option value="60"><fmt:message key='1_hour' /></option>
							<option value="90"><fmt:message key='1_hour_30_min' /></option>
							<option value="120"><fmt:message key='2_hour' /></option>
						</select></div>
						</td>
						<td align="center" bgcolor="<%=tmpColor %>"><input name="_inputTime" type="text" class="inputbox2" size="32" id="_inputTime" align="center" readonly="true" /></td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="15">&nbsp;</td>
			</tr>
			<tr>
				<td height="39" align="center" background="/PromesService/images/common/box_01.gif" style="background-repeat: no-repeat; background-size: cover;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="20"><img src="/PromesService/images/common/dot_01.gif" width="11" height="11" /></td>
								<td width="70" class="td_table01"><fmt:message key='the_beginning_date' /></td>
								<td><input name="_startDate" type="text" class="inputbox" size="20" id="_startDate" align="center" readonly="true"/></td>
								<td width="40" align="center"><a href="javascript:alt('start');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
								<td style="display:none;"><select name="_startTakenOrder" class="select_white" style="width: 100px" onchange="javascript:changeTakenOrder('start');">
									<option selected="selected"></option>
								</select></td>
							</tr>
						</table>
						</td>
						<td width="20">&nbsp;</td>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="20"><img src="/PromesService/images/common/dot_01.gif" width="11" height="11" /></td>
								<td width="70" class="td_table01"><fmt:message key='the_end_date' /></td>
								<td><input name="_endDate" type="text" class="inputbox" size="20" id="_endDate" align="center" readonly="true"/></td>
								<td width="40" align="center"><a href="javascript:alt('end');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
								<td style="display:none;"><select name="_endTakenOrder" class="select_white" style="width: 100px" onchange="javascript:changeTakenOrder('end');">
									<option selected="selected"></option>
								</select></td>
							</tr>
						</table>
						</td>
						<td width="200">&nbsp;</td> 
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="15">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
						<td width="80" valign="bottom"><a href="javascript:addPrescription();"><img src="/PromesService/images/common/bt_input.gif" name="Image7" width="74" height="22" border="0" id="Image7" onmouseover="MM_swapImage('Image7','','/PromesService/images/common/bt_input_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
						<td width="80" valign="bottom"><a href="javascript:clear();"><img src="/PromesService/images/common/bt_initialize.gif" width="74" height="22" id="Image8" border="0" onmouseover="MM_swapImage('Image8','','/PromesService/images/common/bt_initialize_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
						<td width="74" valign="bottom"><a href="javascript:loadSearch();"><img src="/PromesService/images/common/bt_list.gif" width="74" height="22" id="Image4" border="0" onmouseover="MM_swapImage('Image4','','/PromesService/images/common/bt_list_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="50">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<iframe name="addPrescriptionResultPage" id="addPrescriptionResultPage" src="/PromesService/home/user/userInfoResult.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0"></iframe>
<iframe name="checkPrescriptionIdResultPage" id="checkPrescriptionIdResultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0"></iframe></form>
<script src="/PromesService/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#_totalDays').blur(function(){
		if($('#_totalDays').val().length > 0){
			var cnt = $('#_totalDays').val();
			var today = new Date();
			
		    var year = parseInt(today.getFullYear(), 10);
		    var month = parseInt(today.getMonth(), 10);
		    var day = parseInt(today.getDate(), 10);
		    month = (month + 1 < 10) ? '0' + (month + 1) : month + 1;
		    day = (day + 1 < 10) ? '0' + (day + 1) : day + 1;
		    var takenStartDate = year + "-" + month + "-" + day;
		    var tmpDate = new Date(year, month-1, day-1);
		    for(var i = 0; i<cnt; i++){
		    	
				tmpDate.setDate(tmpDate.getDate()+1);
				if(tmpDate.getDay()==0){ // 0=일요일 
					tmpDate.setDate(tmpDate.getDate()+1);
				}
		    }
		    
		    var endMonth = (tmpDate.getMonth()+1) < 10 ?  '0' + (tmpDate.getMonth()+1) : (tmpDate.getMonth()+1);
		    var endDate = tmpDate.getDate() < 10 ? '0'+tmpDate.getDate() : tmpDate.getDate();
		    var takenEndDate = tmpDate.getFullYear() + "-" + endMonth + "-" + endDate;
	
			$('#_startDate').val(takenStartDate);
			$('#_endDate').val(takenEndDate);
		}
	});
});
</script>
</body>
</html>
