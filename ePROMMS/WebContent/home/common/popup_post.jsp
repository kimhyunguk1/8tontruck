<%@page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 주소 검색</title>
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

function initsize() {
	//postResultPage.resizeTo(postResultPage.document.body.scrollWidth, postResultPage.document.body.scrollHeight);
	var _height = document.getElementById('postResultPage').contentWindow.document.body.scrollHeight;
    document.getElementById('postResultPage').height=_height;
}

function popupClose(){
	this.close();
}

function searchPost(){
	var mainForm = document.form;
	if(mainForm._key.value == null || mainForm._key.value == ""){
		alert("[동/읍/면]을 입력 하세요.");
	}else{
		mainForm.cmd.value = "searchPost";
		mainForm.target = "postResultPage";
		mainForm.submit();
	}
}

function setPost(post1, post2){
	opener.setPost(post1, post2);
	this.close();
}
//-->
</script>
</head>


<body onload="MM_preloadImages('/PromesService/images/common/bt_popup_colse_.gif','/PromesService/images/common/bt_popup_id_.gif','/PromesService/images/common/bt_popup_search_.gif')">
<form name="form" method="post" action="/PromesService/PromesServerServlet" onsubmit="return false">
<input name="cmd" type="hidden" value=""/>
<table width="442" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="335" align="center" valign="top"><table width="418" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="11"></td>
      </tr>
      <tr>
        <td height="65" valign="top"><img src="/PromesService/images/common/popup_im04.gif" width="418" height="54" /></td>
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
            <td align="center" valign="top"><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="38" valign="bottom"><table width="390" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="24" height="20"><img src="/PromesService/images/common/popup_icon_01.gif" width="12" height="12" /></td>
                        <td class="td_popup_r2">주소의 [동/읍/면]을 입력 후 [우편번호찾기] 버튼을 눌러주세요.</td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="15" align="center"></td>
                </tr>
                <tr>
                  <td align="center"><table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="left">예) 구로동</td>
                        <td width="10" align="left"></td>
                        <td><input name="_key" type="text" class="inputbox" size="25" id="_key" onkeydown="javascript:if(event.keyCode==13){searchPost();}"  /></td>
                        <td width="88" align="right"><a href="javascript:searchPost();"><img src="/PromesService/images/common/bt_popup_search.gif" width="80" height="19" id="Image1" border="0" onmouseover="MM_swapImage('Image1','','/PromesService/images/common/bt_popup_search_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="7" align="center"></td>
                </tr>
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
        <td height="30" align="left" valign="middle"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="12">&nbsp;</td>
            <td width="15"><img src="/PromesService/images/common/popup_icon_02.gif" width="7" height="7" /></td>
            <td class="td_table02">우편번호 찾기 결과</td>
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
            <td height="200" align="center" valign="top" >
               	<iframe name="postResultPage" id="postResultPage" src="/PromesService/home/common/post_result.jsp" frameborder="0" scrolling="AUTO" scrollbars="YES" framespacing="0" width="100%" height="100%" ></iframe>
            </td>
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
            <td height="10"></td>
          </tr>
          <tr>
            <td align="left"><a href="javascript:popupClose();"><img src="/PromesService/images/common/bt_popup_colse.gif" width="47" height="19" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_popup_colse_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
