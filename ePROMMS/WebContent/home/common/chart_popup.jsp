<%@page contentType="text/html; charset=euc-kr"%>
<%String fileName = (String) request.getAttribute("fileName");%>
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

function popupClose(){
	this.close();
}

//-->
</script>
</head>
<body onload="MM_preloadImages('/PromesService/images/pharmacist/bt_input_.gif','/PromesService/images/pharmacist/bt_cancel_.gif','/PromesService/images/common/bt_colse_.gif')">
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="80" valign="top"><img src="/PromesService/images/common/popup_im02.gif" width="700" height="67" /></td>
  </tr>
  <tr>
    <td align="center"><table width="650" border="0" cellspacing="0" cellpadding="0">
<tr>
     <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td height="1" bgcolor="#aac7cb"></td>
       </tr>
       <tr>
         <td height="25" bgcolor="#E3EDEE" class="td_table02">기간 :2009.6.26~2009.6.29</td>
       </tr>
       <tr>
         <td height="1" bgcolor="#aac7cb"></td>
       </tr>
       <tr>
         <td height="5">&nbsp;</td>
       </tr>
     </table></td>
             </tr>
      <tr>
        <td><table width="650" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="180"><table width="100%" border="0" cellspacing="0" cellpadding="0">
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
                      <tr>
                        <td width="80" height="25" bgcolor="#e4eff0" class="td_table02">환자ID</td>
                        <td height="25">&nbsp;&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="2" bgcolor="#d0d0d0"></td>
                      </tr>
                      <tr>
                        <td height="25" bgcolor="#e4eff0" class="td_table02">환자이름</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="2" bgcolor="#d0d0d0"></td>
                      </tr>
                      <tr>
                        <td height="25" bgcolor="#e4eff0" class="td_table02">약상자</td>
                        <td>&nbsp;&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="2" bgcolor="d0d0d0"></td>
                      </tr>
                      <tr>
                        <td height="25" bgcolor="#e4eff0" class="td_table02">전체</td>
                        <td>&nbsp;&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="2" bgcolor="#d0d0d0" ></td>
                      </tr>
                      <tr>
                        <td height="25" align="left" background="/PromesService/images/common/popup_bt_b.gif">&nbsp;<input type="checkbox" name="checkbox" id="checkbox" /></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="2" bgcolor="#d0d0d0"></td>
                      </tr>
                      <tr>
                        <td height="25" align="left" background="/PromesService/images/common/popup_bt_r.gif">&nbsp;<input type="checkbox" name="checkbox2" id="checkbox2" /></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="2" bgcolor="#d0d0d0" class="td_table01"></td>
                      </tr>
                      <tr>
                        <td height="25" align="left" background="/PromesService/images/common/popup_bt_y.gif">&nbsp;<input type="checkbox" name="checkbox3" id="checkbox3" /></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="2" bgcolor="#d0d0d0"></td>
                      </tr>
                      <tr>
                        <td height="25" align="left" background="/PromesService/images/common/popup_bt_g.gif" >&nbsp;<input type="checkbox" name="checkbox4" id="checkbox4" /></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="1" colspan="2" bgcolor="d0d0d0"></td>
                      </tr>
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
                  <td><img src="<%=("/PromesService/chart/" + fileName) %>" width="419" height="178" /></td>
                  <td background="/PromesService/images/common/box_b_2_2.gif">&nbsp;</td>
                </tr>
                <tr>
                  <td height="14" background="/PromesService/images/common/box_b_3_1.gif">&nbsp;</td>
                  <td background="/PromesService/images/common/box_b_3_2.gif">&nbsp;</td>
                  <td background="/PromesService/images/common/box_b_3_3.gif">&nbsp;</td>
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>

    </table></td>
  </tr>
  <tr>
    <td height="15">&nbsp;</td>
  </tr>
  <tr>
    <td height="2" bgcolor="#aac7cb"></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td align="center"><table width="650" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="right">&nbsp;</td>
        <td width="80" align="right"><a href="javascript:popupClose();"><img src="/PromesService/images/common/bt_colse.gif" width="74" height="22" id="Image2" border="0" onmouseover="MM_swapImage('Image2','','/PromesService/images/common/bt_colse_.gif',1)" onmouseout="MM_swapImgRestore()" /></a></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="30" >&nbsp;</td>
  </tr>
  
</table>
</body>
</html>
