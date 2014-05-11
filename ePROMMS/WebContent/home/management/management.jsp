<%@page contentType="text/html; charset=utf-8" isELIgnored = "false"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page import="java.util.Hashtable"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<%UserInfo userInfo = (UserInfo)request.getAttribute("userInfo"); %>
<%Hashtable userCountHash = (Hashtable)request.getAttribute("userCountHash"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Management</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"><!--
Lpad=function(str, len) 
{
   	str = str + ""; 
   	while(str.length < len) 
   	{
   		
    	str = "0"+str; 
   	} 
	return str; 
} 

/// 사용자로부터 마우스 또는 키보드 이벤트가 없을경우의 
   //자동로그아웃까지의 대기시간, 분단위 
var iMinute = 28; 
 
//자동로그아웃 처리 몇초전에 경고를 보여줄지 설정하는 부분, 초단위 
var noticeSecond = 55; 

var iSecond = iMinute * 60 ; 
var timerchecker = null; 
 
initTimer=function() 
{
	
   	//사용자부터 마우스 또는 키보드 이벤트가 발생했을경우 
   	//자동로그아웃까지의 대기시간을 다시 초기화 
   	if(window.event) 
   	{
		iSecond = iMinute * 60 ;; 
		clearTimeout(timerchecker); 
 		coverFilmMain.style.visibility='hidden'; //// 입력방지 레이어 해제 
		timer.style.visibility='hidden';  /// 자동로그아웃 경고레이어 해제 
   	} 
	rMinute = parseInt(iSecond / 60); 
	rSecond = iSecond % 60; 
	if(iSecond > 0) 
	{ 
		//지정한 시간동안 마우스, 키보드 이벤트가 발생되지 않았을 경우 
   		if(iSecond < noticeSecond) 
     	{ 
       		coverFilmMain.style.visibility='visible'; /// 입력방지 레이어 활성 
       		timer.style.visibility='visible';  /// 자동로그아웃 경고레이어 활성 
		} 
       	//자동로그아웃 경고레이어에 경고문+남은 시간 보여주는 부분 
 		timer.innerHTML =  
                   "<font family=tahoma style='font-size:70;'>LOGOUT TIME</font> </h1> <font color=red>" + Lpad(rMinute, 2)+":"+Lpad(rSecond, 2) ; 
   		iSecond--; 
 		timerchecker = setTimeout("initTimer()", 1000); // 1초 간격으로 체크 
	} 
	else 
	{ 
 		clearTimeout(timerchecker); 
		alert("장시간 미사용으로 자동 로그아웃 처리되었습니다.");  
		location.replace="/PromesService/index.jsp";
	} 
} 

// onload = initTimer;///현재 페이지 대기시간 
// document.onclick = initTimer; /// 현재 페이지의 사용자 마우스 클릭이벤트 캡춰 
// document.onkeypress = initTimer;/// 현재 페이지의 키보트 입력이벤트 캡춰 

function pageRedirect(url){
	alert(url);
	location.href="/PromesService/index.jsp";
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01shwhshsh
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
	//managementMainPage.resizeTo(managementMainPage.document.body.scrollWidth, managementMainPage.document.body.scrollHeight);
	var _height = document.getElementById('managementMainPage').contentWindow.document.body.scrollHeight;
    document.getElementById('managementMainPage').height=_height;
	// var doc = document.getElementById("managementMain");
	// if(doc.offsetHeight != 0){
		// pageheight = doc.offsetHeight;
		// parent.document.getElementById("managementMainPage").height = pageheight+"px";
	// }
}

function getId(){	
	<%
		if(userInfo != null){
		%>
			var mainForm = document.form;
			mainForm.userId.value = '<%=userInfo.getId()%>';
			return '<%=userInfo.getId()%>';
		<%}
	%>
	return '';
}


function getType(){	
	<%
		if(userInfo != null){
		%>
			return '<%=userInfo.getType()%>';
		<%}
	%>
	return '';
}

function changeMenu(value){
	console.log('${LoginuserInfo.id}');
	if('${LoginuserInfo.type}' == null || '${LoginuserInfo.type}' == ''){
		alert("login time out.");
		location.place = "/PromesService/index.jsp" ;
		return;
	}
	var value2=0;	
	if(value2 == null || value2 == ""){
		value2 = "patient";
	}
	
	var titleHtml = "";
	var tmpHtml = "";
	tmpHtml += "<table width=\"156\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
	tmpHtml += "<tr><td align=\"right\">";
	if(value == 'Memberlist' || value == 'changeList'){
		tmpHtml += "<img src=\"/PromesService/images/management/left_menu_bbb_.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image51\" /></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image41','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/prescription/left_menu_b.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" onmouseover=\"MM_swapImage('Image71','','/PromesService/images/prescription/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('todayList');\"><img src=\"/PromesService/images/prescription/left_menu_c.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" onmouseover=\"MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('totalList');\"><img src=\"/PromesService/images/prescription/left_menu_d.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		titleHtml = "<fmt:message key='management_of_members' />";
	}else if(value == 'Memberinput'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_bbb.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<img src=\"/PromesService/images/management/left_menu_a_.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/prescription/left_menu_b.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" onmouseover=\"MM_swapImage('Image71','','/PromesService/images/prescription/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('todayList');\"><img src=\"/PromesService/images/prescription/left_menu_c.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" onmouseover=\"MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('totalList');\"><img src=\"/PromesService/images/prescription/left_menu_d.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		titleHtml = "<fmt:message key='registration_of_members' />";
	}else if(value == 'Membermodify'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_bbb.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/prescription/left_menu_b.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" onmouseover=\"MM_swapImage('Image71','','/PromesService/images/prescription/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('todayList');\"><img src=\"/PromesService/images/prescription/left_menu_c.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" onmouseover=\"MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('totalList');\"><img src=\"/PromesService/images/prescription/left_menu_d.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		titleHtml = "<fmt:message key='edit_personal_information' />";
	}else if(value == 'list'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_bbb.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<img src=\"/PromesService/images/prescription/left_menu_b_.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" /></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('todayList');\"><img src=\"/PromesService/images/prescription/left_menu_c.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" onmouseover=\"MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('totalList');\"><img src=\"/PromesService/images/prescription/left_menu_d.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		titleHtml = "<fmt:message key='lists_of_members' />";
	}else if(value == 'modify'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_bbb.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/prescription/left_menu_b.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" onmouseover=\"MM_swapImage('Image71','','/PromesService/images/prescription/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('todayList');\"><img src=\"/PromesService/images/prescription/left_menu_c.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" onmouseover=\"MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('totalList');\"><img src=\"/PromesService/images/prescription/left_menu_d.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		titleHtml = "<fmt:message key='edit_the_medication' />";
	}else if(value == 'input'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_bbb.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/prescription/left_menu_b.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" onmouseover=\"MM_swapImage('Image71','','/PromesService/images/prescription/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
        tmpHtml +="<img src=\"/PromesService/images/prescription/left_menu_a_.gif\" name=\"Image3\" width=\"154\" height=\"26\" border=\"0\" id=\"Image3\" /></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('todayList');\"><img src=\"/PromesService/images/prescription/left_menu_c.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" onmouseover=\"MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('totalList');\"><img src=\"/PromesService/images/prescription/left_menu_d.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		titleHtml = "<fmt:message key='names_of_medicine' />";
	}else if(value == 'none'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_bbb.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<img src=\"/PromesService/images/prescription/left_menu_b_.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" /></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('todayList');\"><img src=\"/PromesService/images/prescription/left_menu_c.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" onmouseover=\"MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('totalList');\"><img src=\"/PromesService/images/prescription/left_menu_d.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		titleHtml = "<fmt:message key='lists_of_medicine' />";		
	}else if(value == 'todayList'){			
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_bbb.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/prescription/left_menu_b.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" onmouseover=\"MM_swapImage('Image71','','/PromesService/images/prescription/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
		tmpHtml += "<img src=\"/PromesService/images/prescription/left_menu_c_.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" /></td>";
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<a href=\"javascript:changeMenu('totalList');\"><img src=\"/PromesService/images/prescription/left_menu_d.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
        titleHtml = "<fmt:message key='medication_status,_present' />";	
	}else if(value == 'totalList'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_bbb.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('list');\"><img src=\"/PromesService/images/prescription/left_menu_b.gif\" name=\"Image71\" width=\"154\" height=\"26\" border=\"0\" id=\"Image71\" onmouseover=\"MM_swapImage('Image71','','/PromesService/images/prescription/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('todayList');\"><img src=\"/PromesService/images/prescription/left_menu_c.gif\" name=\"Image31\" width=\"154\" height=\"26\" border=\"0\" id=\"Image31\" onmouseover=\"MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";	    
// 	    tmpHtml += "</tr><tr><td align=\"right\">";
// 	    tmpHtml += "<img src=\"/PromesService/images/prescription/left_menu_d_.gif\" name=\"Image91\" width=\"154\" height=\"26\" border=\"0\" id=\"Image91\" onmouseover=\"MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" />";
		titleHtml = "<fmt:message key='medication_status,_total' />";
	}
	tmpHtml += "</tr><tr><td align=\"right\">&nbsp;</td></tr></table>"
	title.innerHTML = titleHtml;
	managementMenu.innerHTML = tmpHtml;	
	if((value != 'Membermodify' && value != 'changeList' && value != 'modify' && value != 'none') ){
		changeMain(value);
	}
}

function changeMain(value){	
	var value2=0;
	if(value2 == null || value2 == ""){
		value2 = "patient";
	}	
	var tmpHtml = "";
	if(value == 'Memberlist'){
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadSearchUserInfoListPage&_type=" + value2 + "\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}else if(value == 'Memberinput'){
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadAddUserInfoPage\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}else if(value == 'list'){
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadSearchPrescriptionPage&_type=<%=userInfo.getType()%>\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}else if(value == 'input'){
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadAddPrescriptionPage\" frameborder=\"0\" scrolling=\"NO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}else if(value == 'todayList'){		
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadTodayListPage&_userId=<%=userInfo.getId()%>&_type=<%=userInfo.getType()%>&_date=\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}else if(value == 'totalList'){	
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadTotalListPage&_userId=lovena0410&_type=PHARMACIST&_date = 0\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}
	managementMain.innerHTML = tmpHtml;
}

function loadModifyUser(value){	
	changeMenu("Membermodify");
	var tmpHtml = "";
	tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadModifyUserInfoPage&userId=<%=userInfo.getId()%>\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	managementMain.innerHTML = tmpHtml;
}

function setUserCount(value1, value2){
	_patientDiv.innerHTML = "<fmt:message key='patients' /> : " + value1;
	_pharmacistDiv.innerHTML = "<fmt:message key='staff' /> : " + value2;	
}
function refresh(datevalue){
	var tmpHtml = "";	
	tmpHtml = "<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadTodayListPage&_userId=<%=userInfo.getId()%>&_type=<%=userInfo.getType()%>&_date="+datevalue +"\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	managementMain.innerHTML = tmpHtml;
	
}

//-->
</script>
</head>
<body onload="MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/pharmacist/left_menu_b_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/management/left_menu_b_.gif','/PromesService/images/common/bt_delete_.gif','/PromesService/images/common/bt_all delete_.gif','/PromesService/images/common/bt_inquiry2_.gif')">
<!-- 비활성화 시키는 레이어--> 
 <div id='coverFilmMain' style='z-index: 99997; position:absolute; visibility:hidden; width:100%; height:100%; background-color:#000000; filter:Alpha(opacity=20); opacity:0.6; -moz-opacity:0.6; text-align:center; font-size:12pt;color:black;'></div> 
  <!-- 자동로그아웃시까지 남은 시간을 보여주는 레이어--> 
  <div id="timer" style="position:absolute; width:100%; height:40%;margin-top:20%; visibility:hidden; border:0;  color:black; font-family:tahoma; font-size:150;font-weight:bold;text-align:center"></div> 

<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="userId" type="hidden" value=""/>
<input name="type" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="/PromesService/images/common/top_im_bg.gif"><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="1024"><img src="/PromesService/images/common/top_im_title.jpg" width="1024" height="130" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="197" valign="top"><table width="197" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="530" valign="top" background="/PromesService/images/common/left_im_bg.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>&nbsp;</td>
                <td width="190"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="center"><table width="144" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="55" align="left" class="td_login">[<%=userInfo.getName()%>]</td>
                        <td align="left" class="td_login2"><fmt:message key="Hello" /></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="20" align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td align="center"><table width="115" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="10"><img src="/PromesService/images/common/icon_login.gif" width="3" height="5" /></td>
                        <td align="left"><div id="_patientDiv"><fmt:message key='patients' /> : <%=userCountHash.get("PATIENT") %> </div></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="5"></td>
                  </tr>
                  <tr>
                    <td align="center"><table width="115" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="10"><img src="/PromesService/images/common/icon_login.gif" width="3" height="5" /></td>
                        <td align="left"><div id="_pharmacistDiv"><fmt:message key='staff' /> : <%=userCountHash.get("INCHARGE") %> </div></td>
                      </tr>
                    </table></td>
                  </tr>
                   <tr>
                    <td height="5"></td>
                  </tr>            
                  <tr>
                    <td height="40" align="center" valign="bottom"><table width="145" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><a href="javascript:loadModifyUser();"><img src="/PromesService/images/common/bt_individual.gif" width="82" height="27" border="0" id="Image1" onmouseover="MM_swapImage('Image1','','/PromesService/images/common/bt_individual_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
                        <td align="right"><a href="/PromesService/index.jsp"><img src="/PromesService/images/common/bt_logout.gif" width="59" height="27" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_logout_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="20" align="center" valign="bottom">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="13" align="center" valign="bottom"><div id="managementMenu">
                    <table width="156" border="0" cellspacing="0" cellpadding="0">
                    	<tr><td align="right"><img src="/PromesService/images/management/left_menu_bbb_.gif" name="Image51" width="154" height="26" border="0" id="Image51" /></td>
	    				</tr>
	    				<tr><td align="right"><a href="javascript:changeMenu('Memberinput');"><img src="/PromesService/images/management/left_menu_a.gif" name="Image41" width="154" height="26" border="0" id="Image41" onmouseover="MM_swapImage('Image41','','/PromesService/images/management/left_menu_a_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
	  					</tr>
	  					<tr><td align="right"><a href="javascript:changeMenu('list');"><img src="/PromesService/images/prescription/left_menu_b.gif" name="Image71" width="154" height="26" border="0" id="Image71" onmouseover="MM_swapImage('Image71','','/PromesService/images/prescription/left_menu_b_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
	    				</tr>
	    				<tr><td align="right"><a href="javascript:changeMenu('input');"><img src="/PromesService/images/prescription/left_menu_a.gif" name="Image81" width="154" height="26" border="0" id="Image81" onmouseover="MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
						</tr>
						<tr><td align="right"><a href="javascript:changeMenu('todayList');"><img src="/PromesService/images/prescription/left_menu_c.gif" name="Image31" width="154" height="26" border="0" id="Image31" onmouseover="MM_swapImage('Image31','','/PromesService/images/prescription/left_menu_c_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
	    				</tr>
<!-- 	    				<tr> -->
<!-- 	    					<td align="right"><a href="javascript:changeMenu('totalList');"><img src="/PromesService/images/prescription/left_menu_d.gif" name="Image91" width="154" height="26" border="0" id="Image91" onmouseover="MM_swapImage('Image91','','/PromesService/images/prescription/left_menu_d_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td> -->
<!-- 	   					</tr> -->
	   					<tr><td align="right">&nbsp;</td></tr>    				
                    </table>
                   </div></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
        <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="20">&nbsp;</td>
            <td align="right"><table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/PromesService/images/common/icon_history.gif" width="12" height="5" /></td>
                <td>Home</td>
                <td>ㅣ</td>
                <td><div id="title"><fmt:message key='management_of_members' /></div></td>
                <td width="40" ></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td width="30">&nbsp;</td>
            <td>
	            <div id="managementMain">
	            	<iframe name="managementMainPage" id="managementMainPage" src="/PromesService/home/management/searchUser.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
	            </div>
            </td>
          </tr>
        </table>
          </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td background="/PromesService/images/common/bottom_im_bg.gif"><table width="1024" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="38" align="left"><img src="/PromesService/images/common/bottom_im_left.gif" width="38" height="48" /></td>
        <td align="right" class="td_copy">COPYRIGHT BY Jeyun Inst. LTD. All RIGHTS RESEVED..</td>
        <td width="30" class="td_copy">&nbsp;</td>
        <td width="122" align="right"><!--<img src="/PromesService/images/common/bottom_im_logo.gif" width="122" height="48" />--></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
