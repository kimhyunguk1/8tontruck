<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="java.util.Hashtable"%>
<%Hashtable outHash = (Hashtable) request.getAttribute("outHash");%>
<%String fileName = (String) request.getAttribute("fileName");%>
<%String startDate = (String) request.getAttribute("startDate");%>
<%String endDate = (String) request.getAttribute("endDate");%>
<%String type = (String) request.getAttribute("type");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="kr.re.etri.lifeinfomatics.promes.data.Define"%>
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

function initsize() {
	parent.initsize();
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

function changeDate(type, value){
	var mainForm = document.form;
	var todayDt = new Date();
	var dt = new Date();
	if(type == 'start'){
		mainForm._startDate.value = value;
		if(Number(getTimeDistance()) < 0){
			alert("통계 시작 날짜를 잘못 입력 하셨습니다.\n다시 입력 하세요.");
			mainForm._startDate.value = "";
		}		
	}else if(type == 'end'){
		mainForm._endDate.value = value;
		if(Number(getTimeDistance()) < 0){
			alert("통계 종료 날짜를 잘못 입력 하셨습니다.\n다시 입력 하세요.");
			mainForm._endDate.value = "";
		}
	}
	alt();
}

function getTimeDistance(){
	var mainForm = document.form;
	var todayDt = new Date();
	var startDate = mainForm._startDate.value;
	var endDate = mainForm._endDate.value;
	
	startDate = startDate.replace('년 ', '-');
	startDate = startDate.replace('월 ', '-');
	startDate = startDate.replace('일', '');
	startDate = startDate.split('-');
	
	endDate = endDate.replace('년 ', '-');
	endDate = endDate.replace('월 ', '-');
	endDate = endDate.replace('일', '');
	endDate = endDate.split('-');
	
	var startdt = new Date(startDate[0], startDate[1]-1, startDate[2], 0, 0, 0);
	var enddt = new Date(endDate[0], endDate[1]-1, endDate[2], 23, 59, 59);

	var dis = enddt.getTime() - startdt.getTime();
	return dis;
}

function distanceChart(){
	var mainForm = document.form;
	mainForm.cmd.value = "loadChartPage";
	mainForm._userId.value = parent.getUserId();
	mainForm._prescriptionId.value = parent.getPrescriptionId();
	mainForm._hospital.value = parent.getHospital();
	mainForm._type.value = '<%=type%>';
	mainForm.target = "dosageInfoPage";
	mainForm.submit();
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
	  _style.left = x + 5;
	  _style.top = y + 5;
	}
}

//-->
</script>
</head>
<body onload="initsize();MM_preloadImages('/PromesService/images/common/bt_look_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<input name="_type" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td height="41" background="/PromesService/images/common/bar_04.gif" colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
          <td width="130">&nbsp;</td>
          <td width="110"><input name="_startDate" type="text" class="inputbox" size="15" id="_startDate" <%if(startDate != null){ %> value="<%=startDate %>" <%}%> /></td>
		  <td width="30"><a href="javascript:alt('start');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
          <td width="20">~</td>
          <td width="110"><input name="_endDate" type="text" class="inputbox" size="15" id="_endDate" <%if(endDate != null){ %> value="<%=endDate %>" <%}%> /></td>
          <td width="30"><a href="javascript:alt('end');"><img src="/PromesService/images/common/icon_calendar.gif" width="20" height="20" border="0" /></a></td>
          <td><a href="javascript:distanceChart();"><img src="/PromesService/images/common/bt_look.gif" width="57" height="22" id="Image4" border="0" onmouseover="MM_swapImage('Image4','','/PromesService/images/common/bt_look_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
       </tr>
    </table></td>
  </tr>
  <tr>
		<td height="5" colspan="3"></td>
  </tr>
  <tr>
    <td width="200"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="14" height="14" background="/PromesService/images/common/box_b_1_1.gif">&nbsp;</td>
          <td background="/PromesService/images/common/box_b_1_2.gif">&nbsp;</td>
          <td width="14" height="14" background="/PromesService/images/common/box_b_1_3.gif">&nbsp;</td>
        </tr>
        <tr>
          <td background="/PromesService/images/common/box_b_2_1.gif">&nbsp;</td>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="1" colspan="2" bgcolor="#d0d0d0"></td>
              </tr>
               <%if(!type.equals(Define.USER_PATIENT)){ %>
              <tr>
                <td width="80" height="25" bgcolor="#e4eff0" class="td_table02">환자ID</td>
                <td height="25" class="td_table01">&nbsp;<%=outHash.get("userId")%></td>
              </tr>
              <tr>
                <td height="1" colspan="2" bgcolor="#d0d0d0"></td>
              </tr>
              <%} %>
              <tr>
                <td width="80" height="25" bgcolor="#e4eff0" class="td_table02">전체</td>
                <td class="td_table01">&nbsp;<%=outHash.get("total")%></td>
              </tr>
              <tr>
                <td height="1" colspan="2" bgcolor="#d0d0d0" ></td>
              </tr>
              <tr>
                <td height="25" align="left" background="/PromesService/images/common/popup_bt_b.gif">&nbsp;</td>
                <td class="td_table01">&nbsp;<%=outHash.get(Define.TAKEN_SATUS_PRETAKEN)%></td>
              </tr>
              <tr>
                <td height="1" colspan="2" bgcolor="#d0d0d0"></td>
              </tr>
              <tr>
                <td height="25" align="left" background="/PromesService/images/common/popup_bt_r.gif">&nbsp;</td>
                <td class="td_table01">&nbsp;<%=outHash.get(Define.TAKEN_SATUS_UNTAKEN)%></td>
              </tr>
              <tr>
                <td height="1" colspan="2" bgcolor="#d0d0d0" class="td_table01"></td>
              </tr>
              <tr>
                <td height="25" align="left" background="/PromesService/images/common/popup_bt_y.gif">&nbsp;</td>
                <td class="td_table01">&nbsp;<%=outHash.get(Define.TAKEN_SATUS_SMSOUTTAKEN)%></td>
              </tr>
              <tr>
                <td height="1" colspan="2" bgcolor="#d0d0d0"></td>
              </tr>
              <tr>
                <td height="25" align="left" background="/PromesService/images/common/popup_bt_g.gif" >&nbsp;</td>
                <td class="td_table01">&nbsp;<%=outHash.get(Define.TAKEN_SATUS_NONE)%></td>
              </tr>
              <tr>
                <td height="1" colspan="2" bgcolor="d0d0d0"></td>
              </tr>
              <tr>
				<td height="25" class="td_table02">&nbsp;</td>
                <td class="td_table01">&nbsp;</td>
              </tr>
              <tr>
                <td height="1" colspan="2"></td>
              </tr>
              <tr>
				<td height="25" class="td_table02">&nbsp;</td>
                <td class="td_table01">&nbsp;</td>
              </tr>
              <tr>
                <td height="1" colspan="2"></td>
              </tr>
              <%if(type.equals(Define.USER_PATIENT)){ %>
              <tr>
				<td height="25" class="td_table02">&nbsp;</td>
                <td class="td_table01">&nbsp;</td>
              </tr>
              <tr>
                <td height="1" colspan="2"></td>
              </tr>
              <%} %>
          </table></td>
          <td background="/PromesService/images/common/box_b_2_2.gif">&nbsp;</td>
        </tr>
        <tr>
          <td height="14" background="/PromesService/images/common/box_b_3_1.gif">&nbsp;</td>
          <td background="/PromesService/images/common/box_b_3_2.gif">&nbsp;</td>
          <td background="/PromesService/images/common/box_b_3_3.gif">&nbsp;</td>
        </tr>
    </table></td>
    <td width="10">&nbsp;</td>
    <td valign="top"><table width="100%" height="237" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="14" height="14" background="/PromesService/images/common/box_b_1_1.gif">&nbsp;</td>
          <td background="/PromesService/images/common/box_b_1_2.gif">&nbsp;</td>
          <td width="14" height="14" background="/PromesService/images/common/box_b_1_3.gif">&nbsp;</td>
        </tr>
        <tr>
          <td height="209" background="/PromesService/images/common/box_b_2_1.gif">&nbsp;</td>
          <td><img src="<%=("/PromesService/chart/" + fileName) %>" width="519" height="205" /></td>
          <td background="/PromesService/images/common/box_b_2_2.gif">&nbsp;</td>
        </tr>
        <tr>
          <td height="14" background="/PromesService/images/common/box_b_3_1.gif">&nbsp;</td>
          <td background="/PromesService/images/common/box_b_3_2.gif">&nbsp;</td>
          <td background="/PromesService/images/common/box_b_3_3.gif">&nbsp;</td>
        </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>