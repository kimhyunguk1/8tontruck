<%@page contentType="text/html; charset=euc-kr"%>
<%String userList = (String) request.getParameter("userList");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="kr.re.etri.lifeinfomatics.promes.util.Util"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 SMS Service</title>
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

function popupClose(){
	this.close();
}

function delProtector(value){
	var mainForm = document.form;
	mainForm._name[value].value = "";
	mainForm._ph[value].value = "";
}

function cleanMessage(value){
	var mainForm = document.form;
	if(!value){
		mainForm._msg.value = "";
	}else if(value && mainForm._msg.value == '메시지를 입력해 주세요.'){
		mainForm._msg.value = "";	
	}
}

function semdMessage(){
	var mainForm = document.form;
	var tmpName = mainForm._name;
	var tmpPh = mainForm._ph;
	var tmpStr = "";
	for(var i = 0;i <10;i++){
		var tmp = tmpPh[i].value;
		if(tmp != null && tmp != ""){
			tmpStr += tmpName[i].value + ":" + tmp + ",";
		}
	}
	if(tmpStr == ""){
		alert('한명 이상의 사용자를 입력해 주세요.');
		return;
	}
	
	mainForm.cmd.value = "smsSendMessage";
	mainForm._phList.value = tmpStr;
	mainForm.target = "smsSendResultPage";
	mainForm.submit();
}

function checkPh(value){
	var mainForm = document.form;
	var tmpPh = mainForm._ph[value].value;
	
	tmpPh = tmpPh.split("-").join("");
	var chkNum = 0;
	for(var i=0;i<tmpPh.length;i++){
		if(tmpPh.charAt(i)>='0' && tmpPh.charAt(i)<='9' || tmpPh.charAt(i) == '-'){
			chkNum++;	
		}
	}
	if(tmpPh.length != chkNum){
		alert("휴대폰 번호는 숫자와 특수문자 - 만 사용 가능 합니다.");
		mainForm._ph[value].value = "";
		return;
	}else if(tmpPh.length != 10 && tmpPh.length !=11){
		alert("사용할 수 없는 휴대폰 번호 입니다.");
		mainForm._ph[value].value = "";
		return;
	}

	var ph1 = tmpPh.substr(0, 3);
	
	if(ph1 != '010' && ph1 != '011' && ph1 != '016' && ph1 != '017' && ph1 != '019' && ph1 != '018'){
		alert("문자를 전송 할 수 없는 휴대폰 번호 입니다.");
		mainForm._ph[value].value = "";
		return;
	}
	
	var newPh = "";
	if(tmpPh.length == 10){
		newPh = tmpPh.substr(0, 3) + "-" + tmpPh.substr(3, 3) + "-" + tmpPh.substr(6, 4);
	}else if(tmpPh.length == 11){
		newPh = tmpPh.substr(0, 3) + "-" + tmpPh.substr(3, 4) + "-" + tmpPh.substr(7, 4);
	}
	mainForm._ph[value].value = newPh;
}

function checkCallBack(){
	var mainForm = document.form;
	var tmpPh = mainForm._callBack.value;
	
	tmpPh = tmpPh.split("-").join("");
	var chkNum = 0;
	for(var i=0;i<tmpPh.length;i++){
		if(tmpPh.charAt(i)>='0' && tmpPh.charAt(i)<='9' || tmpPh.charAt(i) == '-'){
			chkNum++;	
		}
	}
	if(tmpPh.length != chkNum){
		alert("휴대폰 번호는 숫자와 특수문자 - 만 사용 가능 합니다.");
		mainForm._callBack.value = "";
		return;
	}else if(tmpPh.length != 10 && tmpPh.length !=11){
		alert("사용할 수 없는 휴대폰 번호 입니다.");
		mainForm._callBack.value = "";
		return;
	}

	var ph1 = tmpPh.substr(0, 3);
	
	if(ph1 != '010' && ph1 != '011' && ph1 != '016' && ph1 != '017' && ph1 != '019' && ph1 != '018'){
		alert("문자를 전송 할 수 없는 휴대폰 번호 입니다.");
		mainForm._callBack.value = "";
		return;
	}
	
	var newPh = "";
	if(tmpPh.length == 10){
		newPh = tmpPh.substr(0, 3) + "-" + tmpPh.substr(3, 3) + "-" + tmpPh.substr(6, 4);
	}else if(tmpPh.length == 11){
		newPh = tmpPh.substr(0, 3) + "-" + tmpPh.substr(3, 4) + "-" + tmpPh.substr(7, 4);
	}
	mainForm._callBack.value = newPh;
}


//-->
</script>
</head>
<body onload="MM_preloadImages('/PromesService/images/common/bt_a_.gif','/PromesService/images/common/bt_b_.gif','/PromesService/images/common/bt_c_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet" onsubmit="return false">
<input name="cmd" type="hidden" value=""/>
<input name="_phList" type="hidden" value=""/>
<table width="243" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="243" height="546" valign="top" background="/PromesService/images/common/phone_im.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="296" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="80">&nbsp;</td>
          </tr>
          <tr>
            <td height="217" align="center" valign="top"><textarea name="_msg" cols="25" rows="16" class="select_white" id="_msg" onclick="javascript:cleanMessage(true);">메시지를 입력해 주세요!</textarea></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="154" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="123" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="35">&nbsp;</td>
                <td width="168" height="117" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="13"></td>
                  </tr>
                  <tr>
                    <td valign="top" height="105">
                   	<DIV style="width:100%; height:100%; overflow-y:auto; border-color:#EBEBEB"> 
                    <table id="phTable" border="0" cellspacing="0" cellpadding="0">
                      <%if(userList != null && !userList.equals("")){
                      	String[] userArr = userList.split(",");
                      	for(int i = 0;i < userArr.length;i++){
                      		String userStr = userArr[i];
                      		if(userStr != null && !userStr.equals("")){
                      			String[] tmpArr = userStr.split(":");
                      			if(tmpArr.length == 2){%>
                      				<tr>
                          			  <td height="20"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            			<tr>
                              		  	  <td width="10" class="td_table09"><%=(i+1) %></td>
                              		  	  <td class="td_table10"><input id="_name" name="_name" type="text" size="7" class="inputbox3" value="<%=Util.toString(tmpArr[0])%>"></td>
                              		  	  <td width="1"></td>
                              		  	  <td class="td_table10"><input id="_ph" name="_ph" type="text" size="12" class="inputbox3" value="<%=Util.toString(tmpArr[1])%>" onchange="javascript:checkPh('<%=i%>');" onkeydown="javascript:if(event.keyCode==13 || window.event.keyCode ==9){checkPh('<%=i %>');}" ></td>
                              		  	  <td valign="middle"><a href="javascript:delProtector('<%=i %>');"><font color="edc549">X</font></a></td>
                            			</tr>
                          			  </table></td>
                        			</tr>  
                        			<tr>
                          			  <td height="1"><img src="/PromesService/images/common/line01.gif" width="148" height="1" /></td>
                        			</tr>
                      			<%}
                      		}
                      	}
                      	for(int i = userArr.length;i < 10;i++){%>
               				<tr>
                   			  <td height="20"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                     			<tr>
                       		  	  <td width="10" class="td_table09"><%=(i+1) %></td>
                       		  	  <td class="td_table10"><input id="_name" name="_name" type="text" size="7" class="inputbox3" value=""></td>
                       		  	  <td width="1"></td>
                       		  	  <td class="td_table10"><input id="_ph" name="_ph" type="text" size="12" class="inputbox3" value="" onchange="javascript:checkPh('<%=i%>');" onkeydown="javascript:if(event.keyCode==13 || window.event.keyCode ==9){checkPh('<%=i %>');}" ></td>
                       		  	  <td valign="middle"><a href="javascript:delProtector('<%=i %>');"><font color="edc549">X</font></a></td>
                     			</tr>
                   			  </table></td>
                 			</tr>  
                 			<tr>
                   			  <td height="1"><img src="/PromesService/images/common/line01.gif" width="148" height="1" /></td>
                 			</tr>
               			<%}
                      }else{%>
                      <%}%>
                    </table></DIV></td>
                  </tr>
                </table></td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="108">&nbsp;</td>
                <td><input name="_callBack" type="text" class="inputbox" id="_callBack" size="14" onchange="javascript:checkCallBack();" onkeydown="javascript:if(event.keyCode==13 || window.event.keyCode ==9){checkCallBack();}"  /></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="45" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="right"><a href="javascript:cleanMessage(false);"><img src="/PromesService/images/common/bt_a.gif" width="58" height="42" id="Image1" border="0" onmouseover="MM_swapImage('Image1','','/PromesService/images/common/bt_a_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
            <td width="60" align="center"><a href="javascript:semdMessage();"><img src="/PromesService/images/common/bt_b.gif" width="58" height="42" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_b_.gif',1)" onmouseout="MM_swapImgRestore()" /></td>
            <td><a href="javascript:popupClose();"><img src="/PromesService/images/common/bt_c.gif" width="58" height="42" id="Image3" border="0" onmouseover="MM_swapImage('Image3','','/PromesService/images/common/bt_c_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<iframe name="smsSendResultPage" id="smsSendResultPage" src="/PromesService/home/pharmacist/phone_popup_result.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0"></iframe></form>
</form>
</body>
</html>
