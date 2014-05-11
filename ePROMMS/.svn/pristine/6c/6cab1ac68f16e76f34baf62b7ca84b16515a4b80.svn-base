<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.TakenOrderProperty"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<%PrescriptionInfo prescriptionInfo = (PrescriptionInfo) request.getAttribute("prescriptionInfo");%>
<%UserInfo userInfo = (UserInfo) request.getAttribute("userInfo");%>
<%PillBoxInfo pillBoxInfo = (PillBoxInfo) request.getAttribute("pillBoxInfo");%>
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

function MM_openBrWindow(theURL,winName,features) {
  var mainForm = document.form;
  window.open(theURL,winName,features);
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
	MM_openBrWindow('/PromesService/PromesServerServlet?cmd=loadCalendarPage&type=' + type,'calendarPopup',point);
}

function setUserId(value){
	var mainForm = document.form;
	mainForm._userId.value = value;
}

function setUserName(value){
	var mainForm = document.form;
	mainForm._userName.value = value;
}

function loadSearch(){
	parent.changeMenu('list');
}

function initsize() {
	parent.initsize();
	var mainForm = document.form;
	<%
	if(prescriptionInfo != null){
		if(pillBoxInfo != null){
			%>
				tmpPillBoxStr = '<%=pillBoxInfo.getUseContainerStr()%>';
			<%
		}
		%>
		changeFrequency();
		var index = 0;
		<%
		ArrayList<TakenOrderProperty> takenOrderProperties = prescriptionInfo.getTakenOrderPropertyList();
		for(int i =0;i < takenOrderProperties.size();i++){
			TakenOrderProperty takenOrderProperty = takenOrderProperties.get(i);
			%>
			if(mainForm._frequency.value == 1){
				mainForm._containerSelect.value = '<%=takenOrderProperty.getContainer()%>';
				mainForm._eatTime.value = '<%=takenOrderProperty.getEatTime()%>';
			}else{
				mainForm._containerSelect[index].value = '<%=takenOrderProperty.getContainer()%>';
				mainForm._eatTime[index].value = '<%=takenOrderProperty.getEatTime()%>';
			}
			<%if(takenOrderProperty.getEatTime().equals("4")){%>
				changeEatTime(index);
				var tmp = '_startAlarm1' + index;
				var tmpObj = document.getElementById(tmp);
				tmpObj.value = '<%=takenOrderProperty.getStartTimeArr()[0]%>';
				
				tmp = '_startAlarm2' + index;
				tmpObj = document.getElementById(tmp);
				tmpObj.value = '<%=takenOrderProperty.getStartTimeArr()[1]%>';
				
				tmp = '_endAlarm1' + index;
				tmpObj = document.getElementById(tmp);
				tmpObj.value = '<%=takenOrderProperty.getEndTimeArr()[0]%>';
				
				tmp = '_endAlarm2' + index;
				tmpObj = document.getElementById(tmp);
				tmpObj.value = '<%=takenOrderProperty.getEndTimeArr()[1]%>';
				
				if(mainForm._inputTime.length == undefined){
					mainForm._inputTime.value = '<%=Util.changeIntToTime(takenOrderProperty.getStartTime())%>' + " ~ "+ '<%=Util.changeIntToTime(takenOrderProperty.getEndTime())%>';
				}else{
					mainForm._inputTime[index].value = '<%=Util.changeIntToTime(takenOrderProperty.getStartTime())%>' + " ~ "+ '<%=Util.changeIntToTime(takenOrderProperty.getEndTime())%>';
				}
			<%}else{
				if(takenOrderProperty.getEatTime().equals("3")){%>
					changeEatTime(index);
				<%}
			%>
				var tmp2 = '_startAlarm' + index;
				var tmpObj2 = document.getElementById(tmp2);
				tmpObj2.value = '<%=takenOrderProperty.getStartAlarm()%>';
				tmp2 = '_stopAlarm' + index;
				tmpObj2 = document.getElementById(tmp2);
				tmpObj2.value = '<%=takenOrderProperty.getEndAlarm()%>';
				if(mainForm._inputTime == undefined || mainForm._inputTime.length == undefined){
					mainForm._inputTime.value = '<%=Util.changeIntToTime(takenOrderProperty.getStartTime())%>' + " ~ "+ '<%=Util.changeIntToTime(takenOrderProperty.getEndTime())%>';
				}else{
					mainForm._inputTime[index].value = '<%=Util.changeIntToTime(takenOrderProperty.getStartTime())%>' + " ~ "+ '<%=Util.changeIntToTime(takenOrderProperty.getEndTime())%>';
				}
			<%}%>
			index++; 
			<%
		}
		if(prescriptionInfo.getFrequency() > 0){%>
			if(mainForm._startTakenOrder.length > 0){
				for(var i=mainForm._startTakenOrder.length -1;i >=0;i--){
	   				mainForm._startTakenOrder.removeChild(mainForm._startTakenOrder.options[i]);
	   				mainForm._endTakenOrder.removeChild(mainForm._endTakenOrder.options[i]);
				}
			}
			<%for(int i = 1; i <= prescriptionInfo.getFrequency(); i++){%>
				mainForm._startTakenOrder[mainForm._startTakenOrder.length] = new Option('<%=i%>','<%=i%>');
				mainForm._endTakenOrder[mainForm._endTakenOrder.length] = new Option('<%=i%>','<%=i%>');
			<%}
			if(prescriptionInfo.getStartTakenOrder() != null && !prescriptionInfo.getStartTakenOrder().equals("")){%>
				mainForm._startTakenOrder.value = '<%=prescriptionInfo.getStartTakenOrder()%>';
				mainForm._endTakenOrder.value = '<%=prescriptionInfo.getEndTakenOrder()%>';
			<%}else{%>
				changeTakenOrder('start');
			<%}
		}
	}	%>
}

var tmpPillBoxStr = "";
function changeFrequency(){
	var mainForm = document.form;
	var tmpFrequency = mainForm._frequency.value;
	var tmpHtml = "";
	tmpHtml = "<table width=\"100%\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\" bgcolor=\"#ececec\">";
	tmpHtml += "<tr><td width=\"40\" height=\"22\" bgcolor=\"#e4eff0\" class=\"td_table02\">No.</td>";
	tmpHtml += "<td width=\"80\" bgcolor=\"#e4eff0\" class=\"td_table02\">칸 번호</td><td width=\"90\" bgcolor=\"#e4eff0\" class=\"td_table02\">시간대</td>";
	tmpHtml += "<td width=\"160\" bgcolor=\"#e4eff0\" class=\"td_table02\">시작시간</td><td width=\"160\" bgcolor=\"#e4eff0\" class=\"td_table02\">종료시간</td>";
	tmpHtml += "<td bgcolor=\"#e4eff0\" class=\"td_table02\">적용시간</td></tr>";
	var tmpColor = "#FFFFFF";
	for(var i = 0; i < tmpFrequency; i++){
		if(i % 2 == 0){
		tmpColor = "#FFFFFF";
		}else{
		   tmpColor = "#edfaf7";
		}
		tmpHtml += "<tr><td height=\"22\" align=\"center\" bgcolor=\""+tmpColor +"\">"+(i+1)+"</td>";
		tmpHtml += "<td align=\"center\" bgcolor=\""+tmpColor +"\">";
		tmpHtml += "<select name=\"_containerSelect\" id=\"_containerSelect\" class=\"select_white\" style=\"width:50px\" disabled=\"true\">";
		if(tmpPillBoxStr != null && tmpPillBoxStr != ""){
			var result = new Array();
			result = tmpPillBoxStr.split(', ');
			for(var x=0;x < result.length;x++){
				tmpHtml += "<option value=\""+result[x] +"\">"+result[x]+"</option>";
			}
		} 
		tmpHtml += "</select></td><td align=\"center\" bgcolor=\""+tmpColor +"\">";
		tmpHtml += "<select name=\"_eatTime\" id=\"_eatTime\" class=\"select_white\" style=\"width:70px\" disabled=\"true\">";
		tmpHtml += "<option value=\"0\">아침</option><option value=\"1\">점심</option><option value=\"2\">저녁</option>";
		tmpHtml += "<option value=\"3\">취침전</option><option value=\"4\">직접입력</option></select></td>";
		tmpHtml += "<td align=\"center\" bgcolor=\""+tmpColor +"\">";
		tmpHtml += "<div id=\"startAlarmDiv\"><select name=\"_startAlarm" + i +"\" id=\"_startAlarm" + i +"\" class=\"select_white\" style=\"width:95px\" disabled=\"true\">";
		tmpHtml += "<option value=\"0\">식전</option><option value=\"1\">식중</option>";
		tmpHtml += "<option value=\"3\">식후</option><option value=\"4\">식후 30분</option></select></div></td>";
		tmpHtml += "<td align=\"center\" bgcolor=\""+tmpColor +"\">";
		tmpHtml += "<div id=\"stopAlarmDiv\"><select name=\"_stopAlarm" + i +"\" id=\"_stopAlarm" + i +"\" class=\"select_white\" style=\"width:95px\" disabled=\"true\">";
		tmpHtml += "<option value=\"30\">30분</option><option value=\"60\">1시간</option><option value=\"90\">1시간 30분</option>";
		tmpHtml += "<option value=\"120\">2시간</option></select></div></td>";
		tmpHtml += "<td align=\"center\" bgcolor=\""+tmpColor +"\">";
		tmpHtml += "<input name=\"_inputTime\" align=\"center\" type=\"text\" class=\"inputbox2\" size=\"40\" id=\"_inputTime\" readonly=\"true\" /></td>";
		tmpHtml += "</tr>";
	}
	tmpHtml += "</table>";
	prescriptionTimeTableDiv.innerHTML = "" + tmpHtml;
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
		startHtml += "<select name=\"_startAlarm1" + value +"\" id=\"_startAlarm1" + value +"\" class=\"select_white\" style=\"width:40px\" disabled=\"true\" >";
		for(var i=0;i <24;i++){
			if(i < 10){
				timeStr = "0"+i;                        			
            }else{
            	timeStr = ""+i;
            }
			startHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
		}
		startHtml += "</select>&nbsp;:&nbsp;";
		startHtml += "<select name=\"_startAlarm2" + value +"\" id=\"_startAlarm2" + value +"\" class=\"select_white\" style=\"width:40px\" disabled=\"true\" >";
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
		endHtml += "<select name=\"_endAlarm1" + value +"\" id=\"_endAlarm1" + value +"\" class=\"select_white\" style=\"width:40px\" disabled=\"true\">";
		for(var i=0;i <24;i++){
			if(i < 10){
				timeStr = "0"+i;                        			
            }else{
            	timeStr = ""+i;
            }
			endHtml += "<option value=\""+timeStr+"\">"+ timeStr + "</option>";
		}
		endHtml += "</select>&nbsp;:&nbsp;";
		endHtml += "<select name=\"_endAlarm2" + value +"\" id=\"_endAlarm2" + value +"\" class=\"select_white\" style=\"width:40px\" disabled=\"true\">";
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
		tmpHtml += "<select name=\"_startAlarm" + value +"\" id=\"_startAlarm" + value +"\" class=\"select_white\" style=\"width:95px\" disabled=\"true\">";
		tmpHtml += "<option value=\"0\">취침전 30</option><option value=\"1\">취침전</option></select>";	
		if(mainForm._frequency.value == 1){
			startAlarmDiv.innerHTML = "" + tmpHtml;
		}else{
			startAlarmDiv[value].innerHTML = "" + tmpHtml;
		}
		tmpHtml = "<select name=\"_stopAlarm" + value +"\" id=\"_stopAlarm" + value +"\" class=\"select_white\" style=\"width:95px\" disabled=\"true\">";
		tmpHtml += "<option value=\"30\">30분</option><option value=\"60\">1시간</option><option value=\"90\">1시간 30분</option>";
		tmpHtml += "<option value=\"120\">2시간</option></select>";
		if(mainForm._frequency.value == 1){
			stopAlarmDiv.innerHTML = "" + tmpHtml;
		}else{
			stopAlarmDiv[value].innerHTML = "" + tmpHtml;
		}
	}else{
		var tmpHtml = "";
		var tmp = '_startAlarm1' + value;
		var tmpObj = document.getElementById(tmp);
		if(tmpObj != null){
			tmpHtml += "<select name=\"_startAlarm" + value +"\" id=\"_startAlarm" + value +"\" class=\"select_white\" style=\"width:95px\" disabled=\"true\">";
			tmpHtml += "<option value=\"0\">식전</option><option value=\"1\">식중</option>";
			tmpHtml += "<option value=\"3\">식후</option><option value=\"4\">식후 30분</option></select>";	
			if(mainForm._frequency.value == 1){
				startAlarmDiv.innerHTML = "" + tmpHtml;
			}else{
				startAlarmDiv[value].innerHTML = "" + tmpHtml;
			}
			tmpHtml = "<select name=\"_stopAlarm" + value +"\" id=\"_stopAlarm" + value +"\" class=\"select_white\" style=\"width:95px\" disabled=\"true\">";
			tmpHtml += "<option value=\"30\">30분</option><option value=\"60\">1시간</option><option value=\"90\">1시간 30분</option>";
			tmpHtml += "<option value=\"120\">2시간</option></select>";
			if(mainForm._frequency.value == 1){
				stopAlarmDiv.innerHTML = "" + tmpHtml;
			}else{
				stopAlarmDiv[value].innerHTML = "" + tmpHtml;
			}
		}
	}
}

function modifyDetailSchedule(){
	var mainForm = document.form;
	if(mainForm._startDate.value == ""){
		alert("시작 날짜를 입력 하세요.");
		return;
	}else if(mainForm._startTakenOrder.value == ""){
		alert("시작 회차를 선택 하세요.");
		return;
	}else if(mainForm._endDate.value == ""){
		alert("종료 날짜를 입력 하세요.");
		return;
	}else if(mainForm._endTakenOrder.value == ""){
		alert("종료 회차를 선택 하세요.");
		return;
	}else if(!orderCheck()){
		return;
	}
	mainForm.cmd.value = 'modifyDetailSchedule';
	mainForm.target = "patientMainPage";
	mainForm.submit();
}

function changeDate(type, value){
	var mainForm = document.form;
	var todayDt = new Date();
	var dt = new Date();
	var tmpDate = mainForm._totalDays.value;
	if(type == 'start'){
		if(Number(getTimeDistance(value)) < 0){
			alert('시작날짜가 이미 지난 날짜 입니다.');
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
				alert('시작날짜가 이미 지난 날짜입니다.');
				mainForm._startDate.value = "";
				mainForm._endDate.value = "";
				return;
			}
		}
	}
	alt();
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

function getDate(date, num, operator){
	var mainForm = document.form;
	var tmp = date;
	tmp = tmp.replace('년 ', '-');
	tmp = tmp.replace('월 ', '-');
	tmp = tmp.replace('일', '');
	tmp = tmp.split('-');
	dt = new Date(tmp[0], tmp[1] - 1, eval(tmp[2] + operator + num));
	var tmpDate = dt.getFullYear() + "년 " + ((dt.getMonth() + 1)<10? "0" + (dt.getMonth() + 1) : (dt.getMonth() + 1)) + "월 ";
	tmpDate += (dt.getDate()<10 ? "0" + dt.getDate() : dt.getDate()) + "일";
	return tmpDate;
}

function orderCheck(){
	var mainForm = document.form;
	var todayDt = new Date();
	var dt = new Date();
	var today = todayDt.getFullYear() + "년 " + ((todayDt.getMonth() + 1)<10? "0" + (todayDt.getMonth() + 1) : (todayDt.getMonth() + 1)) + "월 ";
	today += (todayDt.getDate()<10 ? "0" + todayDt.getDate() : todayDt.getDate()) + "일";
	if(today == mainForm._startDate.value){
		var tmpOrder = mainForm._startTakenOrder.value;
		if(mainForm._inputTime == undefined || mainForm._inputTime.length == undefined){
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
		<%if(!prescriptionInfo.getStatus().equals("ON")){%>
		if(dis < 0){
			alert("시작 복용 회의 시간이 지난 시간입니다.\n시작 복용 회를 다시 선택 하세요.");
			return false;
		}		
		<%}%>
	}
	return true;
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
function out_xy(){
//  alert(event.y+document.body.scrollTop);
  if(_out == "true"){
    var layer_x = alt_div.style.left;
    var layer_y = alt_div.style.top;
    layer_x = layer_x.substring(0, layer_x.length - 2);
    layer_y = layer_y.substring(0, layer_y.length - 2);
    var out_x = event.x+document.body.scrollLeft;
    var out_y = event.y+document.body.scrollTop;
    if(layer_x - 5 > out_x || out_x > Number(layer_x) + 245){
      alt();
    }
    if(layer_y - 5 > out_y || Number(layer_y) + 225 < out_y){
      alt();
    }
  }
}

function get_xy(type){
	var _style = alt_div.style;
	var x = 0;
	var y = 0;
	if(type == 'start'){
		x = 250+document.body.scrollLeft - 220;
		y = 405+document.body.scrollTop - 203;
	}else{
		x = 635+document.body.scrollLeft - 220;
		y = 405+document.body.scrollTop - 203;
	}
	if(x < 780 && y < 610){
	  _style.left = x - 15;
	  _style.top = y - 17;
	}
}

//-->
</script>
</head>

<body onload="initsize();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/pharmacist/left_menu_b_.gif','/PromesService/images/pharmacist/left_menu_c_.gif','/PromesService/images/common/bt_input_.gif','/PromesService/images/common/bt_initialize_.gif','/PromesService/images/common/bt_list_.gif')">
<form name="form" method="post"	action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value="" />
<input name="_takenOrderProperties"	type="hidden" value="" />
<input name="_id" type="hidden" value="" />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="/PromesService/images/pharmacist/main_title_a.gif" width="794" height="35" /></td>
	</tr>
	<tr>
		<td height="15">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="756" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="1" bgcolor="#ececec"></td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">교부번호</td>
								<td width="281">&nbsp; <input name="_prescriptionId" type="text" class="inputbox" size="42" id="_prescriptionId" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getId()%>" <%} %> readonly="true" /></td>
								<td width="96" bgcolor="#ddebec" class="td_table02">처방병원</td>
								<td>&nbsp; <input name="_hospital" type="text" class="inputbox" size="42" id="_hospital" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getHospital()%>" <%} %>  readonly="true" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="1" bgcolor="#ececec"></td>
					</tr>
					<tr>
						<td>
						<table width="756%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">환자이름</td>
								<td width="281">&nbsp; <input name="_userName" type="text" class="inputbox" size="42" id="_userName" <%if(userInfo != null){ %> value="<%=userInfo.getName() %>" <%} %> readonly="true" /></td>
								<td width="96" bgcolor="#ddebec" class="td_table02">환자 ID</td>
								<td>&nbsp; <input name="_userId" type="text" class="inputbox" size="42" id="_userId" readonly="true" <%if(userInfo != null){ %> value="<%=userInfo.getId() %>" <%} %>/></td>
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
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">약상자</td>
								<td width="281">
								<table width="281%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="245">&nbsp; <input name="_pillBoxId" type="text" class="inputbox" size="37" id="_pillBoxId" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getPillBox_id()%>" <%} %> readonly="true" /></td>
										<td><img src="/PromesService/images/common/icon_search.gif" width="25" height="25" border="0" /></td>
									</tr>
								</table>
								</td>
								<td width="96" bgcolor="#ddebec" class="td_table02">약타입</td>
								<td>&nbsp; <input name="_pillBoxType" type="text" class="inputbox" size="42" id="_pillBoxType" readonly="true" <%if(pillBoxInfo != null){ %> value="<%=pillBoxInfo.getType() %>" <%} %> readonly="true" /></td>
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
								<td width="96" height="25" bgcolor="#ddebec" class="td_table02">복용일수</td>
								<td width="281">
								<table width="281" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="245">&nbsp; <input name="_totalDays" type="text" class="inputbox" size="37" id="_totalDays" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getTotalDays()%>" <%} %> readonly="true"  /></td>
										<td>일</td>
									</tr>
								</table>
								</td>
								<td width="96" bgcolor="#ddebec" class="td_table02">복용횟수</td>
								<td>&nbsp; <select name="_frequency" id="_frequency" class="select_white" style="width: 260px" disabled="true">
									<%
										for (int i = 1; i <= 10; i++) {
									%>
									<option value="<%=i %>" <%if(prescriptionInfo != null){if(prescriptionInfo.getFrequency() == i){%> selected="selected" <%}}else{if(i == 4){%> selected="true" <%}} %>><%=i%> 회</option>
									<%
										}
									%>
								</select></td>
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
								<td width="96" height="38" bgcolor="#ddebec" class="td_table02">질병명</td>
								<td>&nbsp; <textarea name="_disease" cols="103" class="select_white" id="_disease" readonly="true"><%if (prescriptionInfo != null) { %><%=prescriptionInfo.getDisease().trim()%><%}%>
								</textarea></td>
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
								<td width="96" height="38" bgcolor="#ddebec" class="td_table02">주의사항</td>
								<td>&nbsp; <textarea name="_direction" cols="103" class="select_white" id="_direction" readonly="true"><%if (prescriptionInfo != null) {%><%=prescriptionInfo.getDirection().trim()%><%}%>
								</textarea></td>
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
						<td width="80" bgcolor="#e4eff0" class="td_table02">칸 번호</td>
						<td width="90" bgcolor="#e4eff0" class="td_table02">시간대</td>
						<td width="160" bgcolor="#e4eff0" class="td_table02">시작시간</td>
						<td width="160" bgcolor="#e4eff0" class="td_table02">종료시간</td>
						<td bgcolor="#e4eff0" class="td_table02">적용시간</td>
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
						<td align="center" bgcolor="<%=tmpColor %>"><select name="_containerSelect" id="containerSelect" class="select_white" style="width: 50px">
							<option selected="selected"></option>
						</select></td>
						<td align="center" bgcolor="<%=tmpColor %>"><select name="_eatTime" id="_eatTime" class="select_white" style="width: 70px">
							<option value="0">아침</option>
							<option value="1">점심</option>
							<option value="2">저녁</option>
							<option value="3">취침전</option>
							<option value="4">직접입력</option>
						</select></td>
						<td align="center" bgcolor="<%=tmpColor %>">
						<div id="startAlarmDiv"><select name="_startAlarm" id="_startAlarm" class="select_white" style="width: 95px">
							<option value="0">식전 30분</option>
							<option value="1">식전</option>
							<option value="2">식중</option>
							<option value="3">식후</option>
							<option value="4">식후 30분</option>
						</select></div>
						</td>
						<td align="center" bgcolor="<%=tmpColor %>">
						<div id="stopAlarmDiv"><select name="_stopAlarm" id="_stopAlarm" class="select_white" style="width: 95px">
							<option value="30">30분</option>
							<option value="60">1시간</option>
							<option value="90">1시간 30분</option>
							<option value="120">2시간</option>
						</select></div>
						</td>
						<td align="center" bgcolor="<%=tmpColor %>"><input name="_inputTime" type="text" class="inputbox2" size="40" id="_inputTime" align="center" readonly="true" /></td>
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
				<td height="39" align="center" background="/PromesService/images/common/box_01.gif">
				<table width="735" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="20"><img src="/PromesService/images/common/dot_01.gif" width="11" height="11" /></td>
								<td width="70" class="td_table01">시작날짜</td>
								<td><input name="_startDate" type="text" class="inputbox" size="20" id="_startDate" align="center" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getStartDate()%>" <%} %> readonly="true" /></td>
								<td width="40" align="center"><a href="javascript:alt('start');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
								<td><select name="_startTakenOrder" class="select_white" style="width: 100px" onchange="javascript:changeTakenOrder('start');">
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
								<td width="70" class="td_table01">종료날짜</td>
								<td><input name="_endDate" type="text" class="inputbox" size="20" id="_endDate" align="center" <%if(prescriptionInfo != null){ %> value="<%=prescriptionInfo.getEndDate()%>" <%} %> readonly="true"  /></td>
								<td width="40" align="center"><a href="javascript:alt('end');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
								<td><select name="_endTakenOrder" class="select_white" style="width: 100px" onchange="javascript:changeTakenOrder('end');">
									<option selected="selected"></option>
								</select></td>
							</tr>
						</table>
						</td>
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
						<td width="80" valign="bottom"><a href="javascript:modifyDetailSchedule();"><img src="/PromesService/images/common/bt_registration.gif" name="Image7" width="74" height="22" border="0" id="Image7" onmouseover="MM_swapImage('Image7','','/PromesService/images/common/bt_registration_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
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
<iframe name="userInfoResultPage" id="userInfoResultPage" src="/PromesService/home/user/userInfoResult.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0"></iframe></form>
</body>
</html>
