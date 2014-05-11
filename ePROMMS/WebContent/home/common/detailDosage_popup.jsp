<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.Define"%>
<%String prescriptionId = (String) request.getParameter("prescriptionId");%>
<%String type = (String) request.getParameter("type");%>
<%String userId = (String) request.getParameter("userId");%>
<%String day = Util.toString((String) request.getParameter("day"));%>
<%String timeStr = (String) request.getParameter("timeStr");%>
<%String hospital = Util.toString((String) request.getParameter("hospital"));%>
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

function initsize(){
	var mainForm = document.form;
}

function popupClose(){
	this.close();
}

function updateDetailSchedule(){
	var mainForm = document.form;
	var scheduleData = "";
	var tmpScheduleId = mainForm._scheduleId;
	var tmpStatrtHour = mainForm._startHour;
	var tmpStartMinute = mainForm._startMinute;
	var tmpEndHour = mainForm._endHour;
	var tmpEndMinute = mainForm._endMinute;
	
	if(mainForm._scheduleId != null){
		if(mainForm._scheduleId.length == undefined){
			scheduleData += "[" + tmpScheduleId.value;
			scheduleData += "/" + '<%=day%> ' + tmpStatrtHour.value + tmpStartMinute.value;
			scheduleData += "/" + '<%=day%> ' + tmpEndHour.value + tmpEndMinute.value + "]";
		}else{
			for(var i = 0;i < mainForm._scheduleId.length;i++){
				scheduleData += "[" + tmpScheduleId[i].value;
				scheduleData += "/" + '<%=day%> ' + tmpStatrtHour[i].value + tmpStartMinute[i].value;
				scheduleData += "/" + '<%=day%> ' + tmpEndHour[i].value + tmpEndMinute[i].value + "]";
			}
		}
	}
	mainForm.cmd.value = "updateDetailSchedule";
	mainForm._prescriptionId.value = '<%=prescriptionId%>';
	mainForm._userId.value = '<%=Util.toString(userId)%>';
	mainForm._hospital.value = '<%=hospital%>';
	mainForm._day.value = '<%=day%>';
	mainForm._scheduleData.value = scheduleData;
	mainForm.target = "dosageInfoPage";
	mainForm.submit();
	this.close();
}
//-->
</script>
</head>
<body onload="initsize();MM_preloadImages('/PromesService/images/common/bt_popup_id_.gif','/PromesService/images/common/bt_popup_colse_.gif','/PromesService/images/common/bt_popup_revision_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_prescriptionId" type="hidden" value=""/>
<input name="_userId" type="hidden" value=""/>
<input name="_hospital" type="hidden" value=""/>
<input name="_day" type="hidden" value=""/>
<input name="_scheduleData" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="100%" align="center" valign="top" class="box01"><table width="418" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="11"></td>
      </tr>
      <tr>
        <td height="65" valign="top"><table width="418" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="54" align="left" valign="top" background="/PromesService/images/common/popup_im07.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120" height="22">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td class="td_table01">- <%=day %> </td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td valign="top"><table width="418" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="5" height="5" background="/PromesService/images/common/box_a_1_1.gif"></td>
            <td background="/PromesService/images/common/box_a_1_2.gif"></td>
            <td width="5" height="5" background="/PromesService/images/common/box_a_1_3.gif"></td>
          </tr>
          <tr>
            <td background="/PromesService/images/common/box_a_2_1.gif">&nbsp;</td>
            <td align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <%
              String[] timeArr = timeStr.split("]");
			  for(int i = 0;i < timeArr.length;i++){
				  String tmp = timeArr[i];
				  tmp = tmp.replace("[","");
				  if(!tmp.equals("")){
					  String[] tmpArr = tmp.split("/");
					  String[] startArr = tmpArr[1].split(":");
					  String[] endArr = tmpArr[2].split(":");%>
					  <tr>
		                <td height="25" class="td_table05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		                  <tr>
		                    <td width="50" class="td_table05"><input id="_scheduleId" type="hidden" name="_scheduleId" value="<%=tmpArr[0] %>"><%=(i+1)%>회</td>
		                    <td width="10"></td>
		                    <td width="55"><select name="_startHour" class="select_white" style="width:45px">
		                    <%for(int y = 1;y <= 24;y++){
                        		String str = "";
                        		if(y < 10){
                        			str = "0"+y;                        			
                        		}else{
                        			str = ""+y;
                        		}%>
                            	<option <%if(str.equals(startArr[0])){%> selected="true"<%}%> value="<%=str %>" ><%=str %></option>		
                        	<%}%>
		                    </select></td>
		                    <td width="20" class="td_login2">시</td>
		                    <td width="55"><select name="_startMinute" class="select_white" style="width:45px">
                       		<%for(int y = 0;y < 60;y+=10){
                        		String str = "";
                        		if(y < 10){
                        			str = "0"+y;                        			
                        		}else{
                        			str = ""+y;
                        		}%>
                            	<option <%if(str.equals(startArr[1])){%> selected="true"<%}%> value="<%=str %>" ><%=str %></option>		
                        	<%}%>
		                    </select></td>
		                    <td width="15" class="td_login2">분</td>
		                    <td width="25" align="center" class="td_login2">~</td>
		                    <td width="55"><select name="_endHour" class="select_white" style="width:45px">
		                    <%for(int y = 1;y <= 24;y++){
                        		String str = "";
                        		if(y < 10){
                        			str = "0"+y;                        			
                        		}else{
                        			str = ""+y;
                        		}%>
                            	<option <%if(str.equals(endArr[0])){%> selected="true"<%}%> value="<%=str %>" ><%=str %></option>		
                        	<%}%>
		                    </select></td>
		                    <td width="20" class="td_login2">시</td>
		                    <td width="55"><select name="_endMinute" class="select_white" style="width:45px">
		                    <%for(int y = 0;y < 60;y+=10){
                        		String str = "";
                        		if(y < 10){
                        			str = "0"+y;                        			
                        		}else{
                        			str = ""+y;
                        		}%>
                            	<option <%if(str.equals(endArr[1])){%> selected="true"<%}%> value="<%=str %>" ><%=str %></option>		
                        	<%}%>
		                    </select></td>
		                    <td width="15" class="td_login2">분</td>
		                    <td class="td_table06">&nbsp;</td>
		                  </tr>
		                </table></td>
		              </tr>
		              <tr>
		                <td height="1" colspan="5" bgcolor="adcfcf"></td>
		              </tr>
			  	<%}
			  }%>
            </table></td>
            <td background="/PromesService/images/common/box_a_2_2.gif">&nbsp;</td>
          </tr>
          <tr>
            <td height="5" background="/PromesService/images/common/box_a_3_1.gif"></td>
            <td background="/PromesService/images/common/box_a_3_2.gif"></td>
            <td background="/PromesService/images/common/box_a_3_3.gif"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="10" colspan="2"></td>
          </tr>
          <tr>
            <td width="54" align="left"><a href="javascript:popupClose();"><img src="/PromesService/images/common/bt_popup_colse.gif" width="47" height="19" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_popup_colse_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
            <%if(type.equals(Define.USER_PATIENT)){%>
				<td><a href="javascript:updateDetailSchedule();"><img src="/PromesService/images/common/bt_popup_revision.gif" width="47" height="19" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_popup_revision_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>            	
            <%}else{%>
         		<td>&nbsp;</td>
            <%} %>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="11"></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
