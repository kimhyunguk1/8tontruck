<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.Define"%>
<%UserInfo userInfo = (UserInfo) request.getAttribute("userInfo");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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

function getTime(value1, value2){
	if(isUser){
		<%if(userInfo != null){%>
		var time = '';
		if(value1 == 0){
			if(value2 == 0 || value2 == 1 || value2 == 2){
				time = '<%=userInfo.getMorningStart()%>';
			}else{
				time = '<%=userInfo.getMorningEnd()%>';
			}
		}else if(value1 == 1){
			if(value2 == 0 || value2 == 1 || value2 == 2){
				time = '<%=userInfo.getNoonStart()%>';
			}else{
				time = '<%=userInfo.getNoonEnd()%>';
			}
		}else if(value1 == 2){
			if(value2 == 0 || value2 == 1 || value2 == 2){
				time = '<%=userInfo.getEveningStart()%>';
			}else{
				time = '<%=userInfo.getEveningEnd()%>';
			}
		}else if(value1 == 3){
			if(value2 == 0 || value2 == 1 || value2 == 2){
				time = '<%=userInfo.getNightStart()%>';
			}else{
				time = '<%=userInfo.getNightEnd()%>';
			}
		}
		<%}else{%>
			return '';
		<%}%>
		
		if(time != ''){
			var timeArr = time.split(":");
			var dt=new Date();
			dt.setUTCHours(timeArr[0]);
			dt.setUTCMinutes(timeArr[1]);
			if(value2 == 0){
				dt.setUTCMinutes(dt.getUTCMinutes() - parseInt('30'));
			}else if(value2 == 4){
				dt.setUTCMinutes(dt.getUTCMinutes() + parseInt('30'));
			}
			
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
			return tmpSumTime;
		}else{
			return time;
		}
	}
}

function getUserId(){
	<%
	if(userInfo != null){
		%>
		return '<%=userInfo.getId()%>';
		<%
	}
	%>
	return '';
}

function getUserName(){
	<%
	if(userInfo != null){
		%>
		return '<%=userInfo.getName()%>';
		<%
	}
	%>
	return '';
}

var isUser = false;
function initsize() {	
	var a=0;
	<%
	if(userInfo != null){
		if(userInfo.getType().equals(Define.USER_PATIENT)){
			%>
			isUser = true;
			<%		
		}else{
			%>
			alert("입력한 ID는 환자 ID가 아닙니다. 확인 하세요.");
			<%
		}
		%>
		parent.setUserId('<%=userInfo.getId()%>');
		parent.setUserName('<%=userInfo.getName()%>');
		<%		
	}
	%>
}

</script>
</head>
<body onload="initsize();">
</body>
</html>