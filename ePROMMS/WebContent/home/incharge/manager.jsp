<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="kr.re.etri.lifeinfomatics.promes.data.UserInfo"%>
<%@page import="java.util.Hashtable"%>
<%UserInfo userInfo = (UserInfo)request.getAttribute("userInfo"); %>
<%Hashtable userCountHash = (Hashtable)request.getAttribute("userCountHash"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Management</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"><!--

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
	var value2=0;	
	if(value2 == null || value2 == ""){
		value2 = "patient";
	}
	
	var titleHtml = "";
	var tmpHtml = "";
	tmpHtml += "<table width=\"156\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
	tmpHtml += "<tr><td align=\"right\">";
	if(value == 'Memberlist' || value == 'changeList' || value == 'list'){
		tmpHtml += "<img src=\"/PromesService/images/management/left_menu_b_.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image51\" /></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image41','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";	  
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";	   
		titleHtml = "회원관리";
	}else if(value == 'Memberinput'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_b.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<img src=\"/PromesService/images/management/left_menu_a_.gif\" name=\"Image41\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	 
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	  
		titleHtml = "회원등록";
	}else if(value == 'Membermodify'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_b.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	 
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	 
		titleHtml = "개인정보수정";
	}else if(value == 'modify'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_b.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	  
	    tmpHtml += "<a href=\"javascript:changeMenu('input');\"><img src=\"/PromesService/images/prescription/left_menu_a.gif\" name=\"Image81\" width=\"154\" height=\"26\" border=\"0\" id=\"Image81\" onmouseover=\"MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	   
		titleHtml = "처방 수정";
	}else if(value == 'input'){
		tmpHtml +="<a href=\"javascript:changeMenu('Memberlist');\"><img src=\"/PromesService/images/management/left_menu_b.gif\" name=\"Image51\" width=\"154\" height=\"26\" border=\"0\" id=\"Image41\" onmouseover=\"MM_swapImage('Image51','','/PromesService/images/management/left_menu_b_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    tmpHtml += "<a href=\"javascript:changeMenu('Memberinput');\"><img src=\"/PromesService/images/management/left_menu_a.gif\" name=\"Image61\" width=\"154\" height=\"26\" border=\"0\" id=\"Image61\" onmouseover=\"MM_swapImage('Image61','','/PromesService/images/management/left_menu_a_.gif',1)\" onmouseout=\"MM_swapImgRestore()\" /></a></td>";
	    tmpHtml += "</tr><tr><td align=\"right\">";
	   
        tmpHtml +="<img src=\"/PromesService/images/prescription/left_menu_a_.gif\" name=\"Image3\" width=\"154\" height=\"26\" border=\"0\" id=\"Image3\" /></td>";
		tmpHtml += "</tr><tr><td align=\"right\">";
	    
		titleHtml = "수약 입력";
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
	if(value == 'Memberlist' || value == 'list'){
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadSearchUserInfoListPage&_type=" + value2 + "\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}else if(value == 'Memberinput'){
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadAddUserInfoPage\" frameborder=\"0\" scrolling=\"AUTO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
	}else if(value == 'input'){
		tmpHtml ="<iframe name=\"managementMainPage\" id=\"managementMainPage\" src=\"/PromesService/PromesServerServlet?cmd=loadAddPrescriptionPage\" frameborder=\"0\" scrolling=\"NO\" framespacing=\"0\" width=\"100%\" onload=\"javascript:initsize();\"></iframe>";
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
	_patientDiv.innerHTML = "환자 : " + value1 + " 명";
	_pharmacistDiv.innerHTML = "담당자 : " + value2 + " 명";	
}

//-->
</script>
</head>
<body onload="MM_preloadImages('/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/pharmacist/left_menu_b_.gif','/PromesService/images/common/bt_secession_.gif','/PromesService/images/management/left_menu_b_.gif','/PromesService/images/common/bt_delete_.gif','/PromesService/images/common/bt_all delete_.gif','/PromesService/images/common/bt_inquiry2_.gif')">
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
                        <td align="left" class="td_login2">님 안녕하세요.</td>
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
                        <td align="left"><div id="_patientDiv">환자 : <%=userCountHash.get("PATIENT") %> 명</div></td>
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
                        <td align="left"><div id="_pharmacistDiv">담당자 : <%=userCountHash.get("INCHARGE") %> 명</div></td>
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
    					<tr><td align="right"><img src="/PromesService/images/management/left_menu_b_.gif" name="Image51" width="154" height="26" border="0" id="Image51" /></td>
	    				</tr>
	    				<tr><td align="right"><a href="javascript:changeMenu('Memberinput');"><img src="/PromesService/images/management/left_menu_a.gif" name="Image41" width="154" height="26" border="0" id="Image41" onmouseover="MM_swapImage('Image41','','/PromesService/images/management/left_menu_a_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
	  					</tr>	  				
	    				<tr><td align="right"><a href="javascript:changeMenu('input');"><img src="/PromesService/images/prescription/left_menu_a.gif" name="Image81" width="154" height="26" border="0" id="Image81" onmouseover="MM_swapImage('Image81','','/PromesService/images/prescription/left_menu_a_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
						</tr>						
	   					<tr><td align="right">&nbsp;</td></tr>   
                    </table></div></td>
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
                <td><div id="title">회원관리</div></td>
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
