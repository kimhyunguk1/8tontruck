<%@page contentType="text/html; charset=euc-kr"%>
<%String msg = (String) request.getAttribute("msg");%>
<%String userName = (String) request.getAttribute("userName");%>
<%String userId = (String) request.getAttribute("userId");%>
<%String prescriptionId = (String) request.getAttribute("prescriptionId");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Prescription Search</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/PromesService/js/common.js" ></script> 
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

//초기화
function init(){
	var mainForm = document.form;
	mainForm.cmd.value = 'searchPrescriptionPage';
	mainForm._loginId.value = parent.getId();
	mainForm._id.value = parent.getId();
	mainForm._name.value = '<%=userName%>';
	<%if(prescriptionId != null && !prescriptionId.equals("")){%>
		mainForm._prescriptionId.value = '<%=prescriptionId%>';
	<%}%>
	
	mainForm._type.value = parent.getType();
	mainForm.target = "patientPrescriptionListPage";
	mainForm.submit();
}

function initsize() {
	//patientPrescriptionListPage.resizeTo(patientPrescriptionListPage.document.body.scrollWidth, patientPrescriptionListPage.document.body.scrollHeight);
	var _height = document.getElementById('patientPrescriptionListPage').contentWindow.document.body.scrollHeight;
    document.getElementById('patientPrescriptionListPage').height=_height;
	parent.initsize();
}

function getType(){
	return parent.getType();
}

function getId(){
	return parent.getId();
}

function changeMenu(value){
	parent.changeMenu(value);
}

function getLoginId(){
	var mainForm = document.form;
	return mainForm._loginId.value;
}

function changeTitle(value){
	parent.changeTitle(value);
}

function searchPrescription(userName, userId, prescriptionId, startDate, endDate, status){
	var mainForm = document.form;
	mainForm.cmd.value = 'searchPrescriptionPage';
	mainForm.target = "patientPrescriptionListPage";
	mainForm.submit();
}

function openDetailSearch(){
	var mainForm = document.form;
	var tmpId = mainForm._id.value;
	var tmpName = mainForm._name.value;
	var tmpPrescriptionId = mainForm._prescriptionId.value;

	var x = 0; 
	var	y = 0;
	var w = 400;
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
	var point = "width=400, height=260, top=" + y + " ,left=" + x + " scrollbars=NO , scrolling=AUTO";
	var tmpUrl = '/PromesService/home/patient/detailSearch_popup.jsp?id=' + tmpId + '&name=' + tmpName + '&prescriptionId=' + tmpPrescriptionId;
	MM_openBrWindow(tmpUrl,'patientDetailSearchPopup',point);
}
//-->
</script>
</head>
<body onload="init();MM_preloadImages('/PromesService/images/common/bt_search_.gif','/PromesService/images/common/bt_individual_.gif','/PromesService/images/common/bt_logout_.gif','/PromesService/images/prescription/left_menu_a_.gif','/PromesService/images/prescription/left_menu_c_.gif','/PromesService/images/common/bt_inquiry_.gif','/PromesService/images/common/bt_revision2_.gif','/PromesService/images/common/bt_internal_.gif','/PromesService/images/common/bt_delete2_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet">
<input name="cmd" type="hidden" value=""/>
<input name="_type" type="hidden" value="" />
<input name="_loginId" type="hidden" value="" />
<input name="_id" type="hidden" value="" />
<input name="_name" type="hidden" value="" />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="/PromesService/images/prescription/main_title_b.gif" width="794" height="35" /></td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td>
		<table width="756" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				    <iframe name="patientPrescriptionListPage" id="patientPrescriptionListPage" src="/PromesService/home/prescription/prescriptionList.jsp" frameborder="0" scrolling="AUTO" framespacing="0" width="100%" onload="javascript:initsize();"></iframe>
				</td>
			</tr>
			<tr>
				<td height="39" align="center" background="/PromesService/images/common/box_01.gif">
				<table width="735" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="20"><img src="/PromesService/images/common/dot_01.gif" width="11" height="11" /></td>
						<td width="50" class="td_table01">검 색</td>
						<td width="130"><select name="_keyType" class="select_white" style="width: 130px" id="_keyType">
							<option value="prescriptionId">교부번호</option>
						</select></td>
						<td align="left">&nbsp; <input name="_prescriptionId" type="text" class="inputbox" size="63" id="_prescriptionId" /></td>
						<td width="50" align="center"><a href="javascript:searchPrescription();">
							<img src="/PromesService/images/common/bt_inquiry2.gif" width="44" height="22" border="0" id="Image9" onmouseover="MM_swapImage('Image9','','/PromesService/images/common/bt_inquiry2_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
						<td width="75" align="center"><a href="javascript:openDetailSearch();">
							<img src="/PromesService/images/common/bt_search.gif" width="57" height="22" border="0" id="Image10" onmouseover="MM_swapImage('Image10','','/PromesService/images/common/bt_search_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<iframe name="searchResultPage" id="searchResultPage" src="/PromesService/home/user/userInfoResult.jsp" frameborder="0" scrolling="NO" framespacing="0" width="0"></iframe></form>
</form>
</body>
</html>
