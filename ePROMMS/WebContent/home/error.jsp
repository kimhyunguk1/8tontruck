<%@page contentType="text/html; charset=euc-kr"%>
<%
  String errMessage = (String) request.getAttribute("message");
  java.util.Enumeration enumeration = null;
  enumeration = request.getAttributeNames();
  while (enumeration.hasMoreElements()) {
    System.out.println("enumeration : " + enumeration.nextElement());
  }
%>
<script language="JavaScript" type="text/JavaScript">
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
</script>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="145" align="left" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td valign="top">
      <table width="710" border="0" cellpadding="0" cellspacing="0" class="td">
        <tr>
          <td width="170" height="30">&nbsp;</td>
          <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td height="30" colspan="3">&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td height="60" colspan="3" valign="top">
            <img src="/PromesService/images/common/img_fail.gif" width="320" height="50">
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td width="45">&nbsp;</td>
          <td height="28" colspan="2">
            <p><%=errMessage %></p>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td width="315" height="50">&nbsp;</td>
          <td width="180" valign="bottom">
            <a href="javascript:history.back()" onMouseOver="MM_swapImage('Image1','','/PromesService/images/common/but_ok_.gif',1)" onMouseOut="MM_swapImgRestore()">
              <img src="/PromesService/images/common/but_ok.gif" name="Image1" width="70" height="24" border="0" id="Image1">
            </a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height="25">&nbsp;</td>
  </tr>
</table>
