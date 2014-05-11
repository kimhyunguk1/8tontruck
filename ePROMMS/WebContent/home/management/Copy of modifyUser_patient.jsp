<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.ProtectorInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Patient Info</title>
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

function init(){
	
	<%if(userInfo != null){%>
		var mainForm = document.form;
		mainForm._userId.value = '<%=userInfo.getId()%>';		
		<%ArrayList<ProtectorInfo> protectors = userInfo.getProtectors();
		for(int i = 0; i < protectors.size();i++){
			ProtectorInfo protectorInfo = protectors.get(i);
			%>
			addProtectorTable('<%=protectorInfo.getName()%>','<%=protectorInfo.getHp()%>','<%=String.valueOf(protectorInfo.isSms())%>',true);
			<%
		}
		
		
			ArrayList<PillBoxInfo> pillBoxs = userInfo.getPillBoxs();
			for(int i = 0; i< pillBoxs.size();i++){
				PillBoxInfo pillBoxInfo = pillBoxs.get(i);
				%>
				addPillBoxTable('<%=pillBoxInfo.getId()%>','<%=pillBoxInfo.getType()%>','<%=pillBoxInfo.getRegDate()%>', true);
				<%
			}
		
	}
	%>
}

function phoneCheck(){
// 	var mainForm = document.form;
// 	var tmpHp1 = mainForm._hp2.value;
// 	var tmpHp2 = mainForm._hp3.value;
// 	var chkNum = 0;
// 	var chkEng = 0;
	
// 	for(var i=0;i<tmpHp1.length;i++){
// 		if(tmpHp1.charAt(i)>='0' && tmpHp1.charAt(i)<='9'){
// 			chkNum++;	
// 		}
// 		else if(tmpHp1.charAt(i)>='a' && tmpHp1.charAt(i)<='z'){
// 			chkEng++;
// 		}
// 	}
// 	if(tmpHp1.length!=(chkNum+chkEng) || chkEng != 0 || tmpHp1.length < 3 || tmpHp1.length > 4){
// 		alert("휴대폰의 앞자리는 3~4자리 숫자로 이루어져야 합니다.");
// 		return false;
// 	}
// 	chkNum = 0;
// 	chkEng = 0;
// 	for(i=0;i<tmpHp2.length;i++){
// 		if(tmpHp2.charAt(i)>='0' && tmpHp2.charAt(i)<='9'){
// 			chkNum++;	
// 		}
// 		else if(tmpHp2.charAt(i)>='a' && tmpHp2.charAt(i)<='z'){
// 			chkEng++;
// 		}
// 	}
// 	if(tmpHp2.length!=(chkNum+chkEng) || chkEng != 0 || tmpHp2.length != 4){
// 		alert("휴대폰의 뒷자리는 4자리 숫자로 이루어져야 합니다.");
// 		return false;
// 	}
	return true;
}

/*********************** 보호자 관련 *************************************/
function checkProtectors(name, ph){
	var mainForm = document.form;
	if(mainForm._tabProtectorName != null){
		if(mainForm._tabProtectorName.length == undefined){
			if(mainForm._tabProtectorName.value == name && mainForm._tabProtectorPh.value == ph){
				return false;
			} 
		}else{
			for(var i = 0;i < mainForm._tabProtectorName.length;i++){
				if(mainForm._tabProtectorName[i].value == name && mainForm._tabProtectorPh[i].value == ph){
					return false;
			} 	}
		}
	}
	return true;
}

function addProtector(){
	var mainForm = document.form;
	if(mainForm._protectorName.value == null || mainForm._protectorName.value == ""){
		alert("<fmt:message key='enter_the_name_of_protectors/guardians'/>");
		return;
	}
	
	var tmpHp = mainForm._hp1.value + "-" + mainForm._hp2.value + "-" + mainForm._hp3.value; 
	
	if(!phoneCheck()){
		return;
	}	
	if(!checkProtectors(mainForm._protectorName.value, tmpHp)){
		alert("<fmt:message key='the_protectors/guardians_was_already_registered.'/>");
		return; 
	}
	if(idxProtector < 5){
		addProtectorTable(mainForm._protectorName.value, tmpHp, true, true);
		mainForm._protectorName.value = "";
// 		mainForm._hp1.value = "010";
		mainForm._hp2.value = "";
// 		mainForm._hp3.value = "";
		mainForm._protectorName.focus();
	}else{
		alert("<fmt:message key='more_than_5_protectors_cannot_be_registered._'/>");
	}
}

var idxProtector = 0;
function addProtectorTable(name, ph, sms, isdel){
	var table = document.getElementById("protectorTable");
	var len = table.rows.length;
	if(idxProtector < 5){
		if(isdel){
			delProtector(false);
		}
	} 	
	var oRow = table.insertRow(2 + idxProtector);
	oRow.onclick=function(){protectorTable.clickedRowIndex=this.rowIndex};
	oRow.id=idxProtector;
	
	var oCel0 = oRow.insertCell(0);     
	var oCel1 = oRow.insertCell(1);
	var oCel2 = oRow.insertCell(2);
	var oCel3 = oRow.insertCell(3);
	var oCel4 = oRow.insertCell(4);
	
	var color = '#FFFFFF';
	
	oCel0.height = 25;
	oCel0.align='center';
	oCel0.bgColor = color;
	
	oCel1.height = 25;
	oCel1.align='center';
	oCel1.bgColor = color;
	
	oCel2.height = 25;
	oCel2.align='center';
	oCel2.bgColor = color;
	
	oCel3.height = 25;
	oCel3.align='center';
	oCel3.bgColor = color;
	
	oCel4.height = 25;
	oCel4.align='center';
	oCel4.bgColor = color;
	if(isdel){
		oCel0.innerHTML="" + (idxProtector + 1);
		oCel1.innerHTML="<input name=\"_tabProtectorName\" type=\"hidden\" value=\"" + name + "\"/>"+ name;
		oCel2.innerHTML="<input name=\"_tabProtectorPh\" type=\"hidden\" value=\"" + ph + "\"/>" + ph
		if(sms == 'true'){
			oCel3.innerHTML="<input type=\"checkbox\" name=\"_sms\" id=\"_sms\" checked=\"checked\" />";
		}else{
			oCel3.innerHTML="<input type=\"checkbox\" name=\"_sms\" id=\"_sms\" />";
		}
		oCel4.innerHTML="<a href=\"javascript:delProtector(true);\"><img src=\"/PromesService/images/common/bt_X.gif\" width=\"36\" height=\"22\" id=\"Image61"+idxProtector + "\" border=\"0\" onmouseover=\"MM_swapImage('Image61"+idxProtector + "','','/PromesService/images/common/bt_X_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a>";
		idxProtector++;
	}
    changeNo("protectorTable");
	parent.initsize();
}

function delProtector(value){
	if(value){
    	protectorTable.deleteRow(protectorTable.clickedRowIndex);
   		protectorTable.clickedRowIndex = null;
    	idxProtector--;
    	if(protectorTable.rows.length == 6){
   			addProtectorTable("","", true, false);
    	}
    }else{
    	protectorTable.deleteRow(2 + idxProtector);
    	protectorTable.clickedRowIndex = null;
    }
    changeNo("protectorTable");
}

function getProtectors(){
	var outStr = "";
	var mainForm = document.form;
	if(mainForm._tabProtectorName != null){
		if(mainForm._tabProtectorName.length == undefined){
			var tmpSms = 0;
			if(mainForm._sms.checked){
				tmpSms = 1;
			}
			outStr += "[" + mainForm._tabProtectorName.value + "/" + mainForm._tabProtectorPh.value + "/" + tmpSms + "]"; 
		}else{
			for(var i = 0;i < mainForm._tabProtectorName.length;i++){
				var tmpSms = 0;
				if(mainForm._sms[i].checked){
					tmpSms = 1;
				}
				outStr += "[" + mainForm._tabProtectorName[i].value + "/" + mainForm._tabProtectorPh[i].value + "/" + tmpSms + "]";
			}
		}
	}
	return outStr;
}
/*********************** 약상자 관련 *************************************/
var idxPillbox = 0;
function addPillBoxTable(id, type, date, isdel)
{
	var table = document.getElementById("pillboxTable");
	var len = table.rows.length;
	if(idxPillbox < 4){
		if(isdel){
			delPillBox(false);
		}
	} 
	var oRow = table.insertRow(2 + idxPillbox);
	oRow.onclick=function(){pillboxTable.clickedRowIndex=this.rowIndex};
	oRow.id=idxPillbox;
	var oCel0 = oRow.insertCell(0);     
	var oCel1 = oRow.insertCell(1);
	var oCel2 = oRow.insertCell(2);
	var oCel3 = oRow.insertCell(3);
	var oCel4 = oRow.insertCell(4);
	
	var color = '#FFFFFF';
	
	oCel0.height = 25;
	oCel0.align='center';
	oCel0.bgColor = color;
	
	oCel1.height = 25;
	oCel1.align='center';
	oCel1.bgColor = color;
	
	oCel2.height = 25;
	oCel2.align='center';
	oCel2.bgColor = color;
	
	oCel3.height = 25;
	oCel3.align='center';
	oCel3.bgColor = color;
	
	oCel4.height = 25;
	oCel4.align='center';
	oCel4.bgColor = color;
	if(isdel)
	{
		oCel0.innerHTML="<input name=\"_pro\" type=\"hidden\" value=\"\"/>" + (idxPillbox + 1);
// 		oCel1.innerHTML="<a href=\"javascript:modifyTempPillBox('"+ id +"','"+ date + "');\">"+"<input name=\"_tabPillBoxId\" type=\"hidden\" value=\"" + id + "\"/>"+ id+"</a>";
		oCel1.innerHTML="<input name=\"_tabPillBoxId\" type=\"hidden\" value=\"" + id + "\"/>"+ id+"</a>";
		oCel2.innerHTML="<input name=\"_tabPillBoxType\" type=\"hidden\" value=\"" + type + "\"/>" + type;
		oCel3.innerHTML="<input name=\"_tabPillBoxDate\" type=\"hidden\" value=\"" + date + "\"/>" + date;
		oCel4.innerHTML="<a href=\"javascript:checkUsePillBox(true, '"+ id +"');\"><img src=\"/PromesService/images/common/bt_X.gif\" width=\"36\" height=\"22\" id=\"Image9" + idxPillbox + "\" border=\"0\" onmouseover=\"MM_swapImage('Image9"+ idxPillbox + "','','/PromesService/images/common/bt_X_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a>";
		idxPillbox++;
	}
    changeNo("pillboxTable");
	parent.initsize();
}

function modifyTempPillBox(id, date)
{
	var mainForm = document.form;
	mainForm._pillBoxId.value = id;
	mainForm._pillBoxDate.value = date;
}

function addPillBox()
{
// 	delPillBox(true);
// 	var mainForm = document.form;
// 	addPillBoxTable(mainForm._pillBoxId.value, mainForm._pillBoxType.value, mainForm._pillBoxDate.value, true);
// 	mainForm._pillBoxId.value = "";
// 	mainForm._pillBoxDate.value = "";
// 	mainForm._pillBoxType.value = "2구";
}

function checkPillBox(){
	var mainForm = document.form;
	if(mainForm._pillBoxId.value == null || mainForm._pillBoxId.value == ""){
		alert("<fmt:message key='enter_the_pillbox_ID'/>");
		return;
	}else if(mainForm._pillBoxDate.value == null || mainForm._pillBoxDate.value == ""){
		alert("<fmt:message key='enter_the_registration_date'/>");
		return;
	}
	var id = mainForm._pillBoxId.value;	
	if(mainForm._tabPillBoxId != null){
		if(mainForm._tabPillBoxId.length == undefined){
			if(mainForm._tabPillBoxId.value == id){
				alert("<fmt:message key='the_the_pillbox_ID_was_already_registered.'/>");
				return;
			}
		}else{
			for(var i = 0;i < mainForm._tabPillBoxId.length;i++){
				if(mainForm._tabPillBoxId[i].value == id){
					alert("<fmt:message key='the_the_pillbox_ID_was_already_registered.'/>");
					return;
				}
			}
		}
	}
	<%
	
	if(userInfo.getPillBoxs().size() > 0){
		ArrayList<PillBoxInfo> pillBoxs = userInfo.getPillBoxs();
		PillBoxInfo pillBoxInfo = pillBoxs.get(0);
		%>
		mainForm._takenBoxId.value = '<%=pillBoxInfo.getId()%>';	
		<%
	}	
	%>
	
	mainForm.cmd.value = "checkPillBox";
	mainForm.target = "resultPage";
	mainForm.submit();
}

function checkUsePillBox(value, id){
	var mainForm = document.form;
	mainForm.cmd.value = "checkUsePillBox";
	mainForm._delPiiBoxId.value = id;
	mainForm._delBool.value = value;
	mainForm.target = "resultPage";
	mainForm.submit();
}

function delPillBox(value){
	//alert(pillboxTable.clickedRowIndex);
	if(value)
	{
    	pillboxTable.deleteRow(pillboxTable.clickedRowIndex);
   		pillboxTable.clickedRowIndex = null;
    	idxPillbox--;
    	alert(pillboxTable.rows.length);
    	if(pillboxTable.rows.length > 0)
    	{
   			addPillBoxTable("","", true, false);
    	}
    }
	else
    {
    	pillboxTable.deleteRow(2 + idxPillbox);
    	pillboxTable.clickedRowIndex = null;
    }
    changeNo("pillboxTable");
}

function changeNo(table){
	var table = document.getElementById(table);
	for (var i = 2; i < table.rows.length; i++) {
    	table.rows[i].cells[0].innerHTML = (i-1);
   	}
}

function openCalendar(type){
	var x = 0; 
	var	y = 0;
	var h = 203;
	var w = 220;
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

function changeDate(type, date){
	var mainForm = document.form;
	mainForm._pillBoxDate.value = date;
	alt();
}

function getTimeList(){
	var outStr = "";
	var mainForm = document.form;
	outStr +=mainForm._mor_s1.value + mainForm._mor_s2.value+ "/";
	outStr +=mainForm._mor_e1.value + mainForm._mor_e2.value+ "/";
	outStr +=mainForm._noo_s1.value + mainForm._noo_s2.value+ "/";
	outStr +=mainForm._noo_e1.value + mainForm._noo_e2.value+ "/";
	outStr +=mainForm._eve_s1.value + mainForm._eve_s2.value+ "/";
	outStr +=mainForm._eve_e1.value + mainForm._eve_e2.value+ "/";
	outStr +=mainForm._nig_s1.value + mainForm._nig_s2.value+ "/";
	outStr +=mainForm._nig_e1.value + mainForm._nig_e2.value;
	return outStr;		
}

function checkTime(){
// 	var outStr = "";
// 	var mainForm = document.form;
	
// 	var tmpStartHour = "";
// 	var tmpStartMinutes = "";
// 	var tmpEndHour = "";
// 	var tmpEndMinutes = "";
	
// 	if(!getTimeDistance(mainForm._mor_s1.value, mainForm._mor_s2.value, mainForm._mor_e1.value, mainForm._mor_e2.value)){
// 		alert('아침 식사 종료 시간이 시작 시간보다 빠르게 입력 되었습니다.');
// 		return false;
// 	}
// 	if(!getTimeDistance(mainForm._mor_e1.value, mainForm._mor_e2.value, mainForm._noo_s1.value, mainForm._noo_s2.value)){
// 		alert('점심 식사 시작 시간이 아침 식사 종료 시간 보다 빠르게 입력 되었습니다.');
// 		return false;
// 	}
// 	if(!getTimeDistance(mainForm._noo_s1.value, mainForm._noo_s2.value, mainForm._noo_e1.value, mainForm._noo_e2.value)){
// 		alert('점심 식사 종료 시간이 시작 시간보다 빠르게 입력 되었습니다.');
// 		return false;
// 	}	
// 	if(!getTimeDistance(mainForm._noo_e1.value, mainForm._noo_e2.value, mainForm._eve_s1.value, mainForm._eve_s2.value)){
// 		alert('저녁 식사 시작 시간이 점심 식사 종료 시간 보다 빠르게 입력 되었습니다.');
// 		return false;
// 	}
// 	if(!getTimeDistance(mainForm._eve_s1.value, mainForm._eve_s2.value, mainForm._eve_e1.value, mainForm._eve_e2.value)){
// 		alert('저녁 식사 시간의 종료시간이 시작시간보다 빠르게 입력 되었습니다. 확인 하세요.');
// 		return false;
// 	}
// 	if(!getTimeDistance(mainForm._eve_e1.value, mainForm._eve_e2.value, mainForm._nig_s1.value, mainForm._nig_s2.value)){
// 		alert('취침전 시작 시간이 저녁 식사 종료 시간 보다 빠르게 입력 되었습니다.');
// 		return false;
// 	}
// 	if(!getTimeDistance(mainForm._nig_s1.value, mainForm._nig_s2.value, mainForm._nig_e1.value, mainForm._nig_e2.value)){
// 		alert('취침전 식사 시간의 종료시간이 시작시간보다 빠르게 입력 되었습니다. 확인 하세요.');
// 		return false;
// 	}
	return true;
}

function getTimeDistance(startHour, startMinutes, endHour, endMinutes){
	var startDt=new Date();
	var endDt=new Date();
	
	startDt.setUTCHours(startHour);
	startDt.setUTCMinutes(startMinutes);
	endDt.setUTCHours(endHour);
	endDt.setUTCMinutes(endMinutes);

	var dis = endDt.getTime() - startDt.getTime();
	if(dis < 0){
		return false;
	}
	return true;
}

function getPillbox()
{
	var outStr = "";
	var mainForm = document.form;
	if(mainForm._tabPillBoxId != null)
	{
		if(mainForm._tabPillBoxId.length == undefined)
		{
			outStr += "[" + mainForm._tabPillBoxId.value + "/" + mainForm._tabPillBoxType.value + "/" + mainForm._tabPillBoxDate.value + "]"; 
		}
		else
		{
			for(var i = 0;i < mainForm._tabPillBoxId.length;i++)
			{
				outStr += "[" + mainForm._tabPillBoxId[i].value + "/" + mainForm._tabPillBoxType[i].value + "/" + mainForm._tabPillBoxDate[i].value + "]";
			}
		}
	}
	return outStr;
}

function numberText(){
	if((event.keyCode < 48) || (event.keyCode > 57))
  	event.returnValue = false;
}

function checkPillBoxId(){
	var mainForm = document.form;
	var tmpPillBoxId = mainForm._pillBoxId.value;
	var code = event.keyCode
	if(code == 219  || code == 221 || code == 191){
		event.returnValue = false;
       	return;
	}
	var len = 0;
    for (var i=0; i<tmpPillBoxId.length; i++) {
		len += (tmpPillBoxId.charCodeAt(i) > 128) ? 2 : 1;
        if (len > 20){
        	alert("<fmt:message key='the_pillbox_ID_should_be_less_than_20_letters.please_enter_again.'/>");
       	  	mainForm._pillBoxId.value = "";
        }
	}
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
  get_xy();
  var _style = alt_div.style;
  if( type != null ){
	
    alt_div.innerHTML = content;
    //_style.visibility = "visible";
    _style.display = "block";
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
	  _style.display = "none";
    //_style.visibility = "hidden";
  }
}

document.write(
    "<div id=alt_div style=\"" +
    "padding:0;" +
    "border:0 solid #FF7200;" + // 말풍선 테두리 컬러
    "background-color:#efefef;color:#000;" + // 말풍선 테이블 백그라운드컬러 / 폰트컬러
    "position:absolute;" +
//     "visibility:hidden;" +
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

function get_xy(){
	var _style = alt_div.style;
	var x = point_x - 220;
	var y = point_y - 203;
	if(x < 780 && y < 610){
	  _style.left = x - 5;
	  _style.top = y - 5;
	}
}

function checkProtectorName(){
	var mainForm = document.form;
	var tmpProtectorName = mainForm._protectorName.value;
	var len = 0;
	var code = event.keyCode
	if(code == 219  || code == 221 || code == 191){
		event.returnValue = false;
       	return;
	}
    for (var i=0; i<tmpProtectorName.length; i++) {
		len += (tmpProtectorName.charCodeAt(i) > 128) ? 2 : 1;
        if (len > 20){
        	alert("<fmt:message key='Name_should_be_less_than_20_letters.'/>");
       	  	mainForm._protectorName.value = "";
       	  	event.returnValue = false;
       	  	return;
        }
	}
}

//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/pharmacist/left_menu_b_.gif','/PromesService/images/common/bt_initialize_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/common/bt_id_.gif','/PromesService/images/common/bt_X_.gif','/PromesService/images/common/bt_add2_.gif','/PromesService/images/management/left_menu_b_.gif','/PromesService/images/common/bt_registration_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_delPiiBoxId" type="hidden" value=""/>
<input name="_delBool" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_takenBoxId" type="hidden" value=""/>
<table width="756" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="1" bgcolor="#ececec"></td>
	</tr>
	<tr>
       <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="120" height="55" bgcolor="#e1eeef" class="td_table02"><fmt:message key='protector/guardians'/></td>
           <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td width="8" height="5"></td>
               <td></td>
             </tr>
             <tr>
               <td>&nbsp;</td>
               <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                     <td><table id="protectorTable" width="610" border="0" cellpadding="1" cellspacing="1" bgcolor="#ececec">
                         <tr>
                           <td width="40" height="22" align="center" bgcolor="#e4eff0" class="td_table02">NO</td>
                           <td align="center" bgcolor="#e4eff0" class="td_table02"><fmt:message key='name'/></td>
                           <td align="center" bgcolor="#e4eff0" class="td_table02"><fmt:message key='protector/guardians'/></td>
                           <td align="center" width="50" bgcolor="#e4eff0" class="td_table02">SMS</td>
                           <td width="70" bgcolor="#e4eff0">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="3" colspan="5" bgcolor="#a7c2bc"></td>
                           </tr>
                        <tr>
                           <td height="25" align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="25" align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="25" align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                         </tr>
                          <tr>
                           <td height="25" align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                         </tr>
                          <tr>
                           <td height="25" align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                         </tr>
                     </table></td>
                   </tr>
                   <tr>
                     <td height="20">&nbsp;</td>
                   </tr>
                   <tr>
                     <td><table width="610" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                           <td height="1" colspan="5" bgcolor="#ececec"></td>
                         </tr>
                         <tr>
                           <td width="100" height="25" align="center" bgcolor="#e4eff0" class="td_table02"><fmt:message key='names_of_proctors/guardians'/></td>
                           <td width="138">&nbsp;
                               <input name="_protectorName" type="text" class="inputbox" size="19" id="_protectorName"   onkeydown="javascript:checkProtectorName();" /></td>
                           <td width="100" align="center" bgcolor="#e4eff0" class="td_table02"><fmt:message key='telephone'/></td>
                           <td>
                           <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                    <tr>
<!-- 			                      <td width="58">&nbsp; -->
<!-- 			                          <select name="_hp1" class="select_white" style="width:45px"> -->
<!-- 			 							<option selected="true" value="010">010</option> -->
<!-- 			                         	<option  value="011" >011</option> -->
<!-- 			                            <option  value="016" >016</option> -->
<!-- 			                            <option  value="017" >017</option> -->
<!-- 			                      <td width="10" align="center" >-</td> -->
			                      <td width="140" >&nbsp;&nbsp;<input name="_hp2" type="text" class="inputbox" size="25" id="_hp2"   onkeypress="javascript:numberText();" /></td>
<!-- 			                      <td width="10" align="center" >-</td> -->
<!-- 			                      <td><input name="_hp3" type="text" class="inputbox" size="9" id="_hp3"   onkeypress="javascript:numberText();" /></td> -->
			                    </tr>
			                </table>
                           </td>
                           <td width="55" align="right"><a href="javascript:addProtector();" class="bt_add2"></a></td>
                         </tr>
                         <tr>
                           <td height="1" colspan="5" bgcolor="#ececec"></td>
                         </tr>
                     </table></td>
                   </tr>
               </table></td>
             </tr>
             <tr>
               <td height="5"></td>
               <td></td>
             </tr>
           </table></td>
         </tr>
       </table></td>
     </tr>
     <tr>
       <td height="1" bgcolor="#ececec"></td>
     </tr>
     
     <tr>
       <td height="1" bgcolor="#ececec"></td>
     </tr>
     <tr>
       <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="120" height="30" bgcolor="#e1eeef" class="td_table02"><fmt:message key='the_registered_number_of_the_box'/></td>
           <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td width="8" height="5"></td>
               <td></td>
             </tr>
             <tr>
               <td>&nbsp;</td>
               <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                     <td><table id="pillboxTable" width="610" border="0" cellpadding="1" cellspacing="1" bgcolor="#ececec">
                         <tr>
                           <td width="40" height="22" align="center" bgcolor="#e4eff0" class="td_table02">NO</td>
                           <td height="22" align="center" bgcolor="#e4eff0" class="td_table02">ID</td>
                           <td align="center" bgcolor="#e4eff0" class="td_table02"><fmt:message key='configurator'/></td>
                           <td align="center" bgcolor="#e4eff0" class="td_table02"><fmt:message key='the_date_of_registration'/></td>
                           <td width="70" bgcolor="#e4eff0">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="3" colspan="5" bgcolor="#a7c2bc"></td>
                         </tr>
                         <tr>
                           <td height="25" align="center" bgcolor="#FFFFFF">1</td>
                           <td height="25" align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                           <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                         </tr>
<!--  						 <tr> -->
<!--                            <td height="25" align="center" bgcolor="#FFFFFF">2</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                          </tr> -->
<!--                          <tr> -->
<!--                            <td height="25" align="center" bgcolor="#FFFFFF">3</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                          </tr> -->
<!--                           <tr> -->
<!--                            <td height="25" align="center" bgcolor="#FFFFFF">4</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                            <td align="center" bgcolor="#FFFFFF">&nbsp;</td> -->
<!--                          </tr>  -->
                     </table></td>
                   </tr>
                   <tr>
                     <td height="20">&nbsp;</td>
                   </tr>
                   <tr>
                     <td><table width="610" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                           <td height="1" colspan="8" bgcolor="#ececec"></td>
                         </tr>
                         <tr>
                           <td width="70" height="25" align="center" bgcolor="#e4eff0" class="td_table02">ID</td>
                           <td width="100">&nbsp;
                               <input name="_pillBoxId" type="text" class="inputbox" size="13" id="_pillBoxId"   onkeydown="javascript:checkPillBoxId();" /></td>
                           <td width="70" align="center" bgcolor="#e4eff0" class="td_table02"><fmt:message key='configurator'/></td>
                           <td>&nbsp;
                           <select name="_pillBoxType" class="select_white" style="width:83px" id="_pillBoxType">   
                           	 <option value="<fmt:message key='type_of_the_loadcell'/>"><fmt:message key='type_of_the_loadcell'/></option>
                           	 <option value="manual">manual</option>                           
                           </select>                                              &nbsp;</td>
                           <td width="70" align="center" bgcolor="#e4eff0" class="td_table02"><fmt:message key='the_date_of_registration'/></td>
                           <td>&nbsp;
                               <input name="_pillBoxDate" type="text" class="inputbox" size="17" id="_pillBoxDate" readonly="readonly" /></td>
                           <td width="27" align="right"><a href="javascript:alt('');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
                           <td width="55" align="right"><a href="javascript:checkPillBox();" class="bt_add2"></a></td>
                         </tr>
                         <tr>
                           <td height="1" colspan="8" bgcolor="#ececec"></td>
                         </tr>
                     </table></td>
                   </tr>
               </table></td>
             </tr>
             <tr>
               <td height="5"></td>
               <td></td>
             </tr>
           </table></td>
         </tr>
       </table></td>
    </tr>
	<tr>
       <td height="3" bgcolor="#a7c2bc"></td>
    </tr>
</table>
<iframe name="resultPage" id="resultPage" src="/PromesService/home/common/result.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0" height="0"></iframe>
</form>
</body>
</html>