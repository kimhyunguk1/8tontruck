<%@page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<fmt:setBundle basename="lang_fr"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-PROMMS 2.0 Prescription Search</title>
<link href="/PromesService/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/PromesService/js/common.js" ></script> 
<script type="text/javascript"src="http://code.jquery.com/jquery-latest.min.js"></script>
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

function Submit(){		
	 $.ajax({		 
		 type:'POST',
		 url:'/PromesService/PromesServerServlet',			 
		 data:'cmd=searchIncharge&_searchValue='+ $('#_searchText').val(),			 
		 error:function(xhr, ajaxOptions, thrownError){
			 alert('error');
		 },
		 success:function(obj){
			 console.log(obj);
			 var tmpHtml = "";
			 tmpHtml = "<table>";
			 var str1 = obj.split("/");				 
			 for(var i=0; i < str1.length-1; i++){					
				 var str2 = str1[i].split(",");
				 tmpHtml += "<tr>";
				 for(var j=0; j <str2.length; j++){	
					 
					 if(j==0){
						 tmpHtml += "<td class='_choice' id ='_choice' style=\"display:none\">"+str2[j]+"</td>"; 
					 }else{
						 tmpHtml += "<td class='_choice' id ='_choice'>"+str2[j]+"</td>"; 
					 }					
				 }					 
				 tmpHtml +="</tr>";			 			
			 }
			 tmpHtml += "</table>";				
			 $("#resultView").html(tmpHtml);
			 
		 }
	 });
	 
	 
}

$(document).ready(function(){
	 $("#_searchSubmit").mouseover(function(){		 
		 $(this).css('cursor','hand');  
	 });
	 $('#_searchText').focus();
	 $("#_searchSubmit").click(function(){	
		 Submit();  
	 });
	 $('#_searchText').bind('keydown',function(e){
		 if(e.keyCode == 13){
			 Submit();
		 }
	 });
  	 $(document).on("mouseover","._choice", function(){
		
		$(this).css('cursor','hand');
	 });
	 $(document).on("click","._choice", function(){
		 var thisrow = $(this).parent();		 
		 $("#_hospital" , opener.document).val(thisrow.find("td:eq(2)").text());		 
		 opener.inputId(thisrow.find("td:eq(0)").text());
		 self.close();	
	 });  
	
});

//-->
</script>
</head>
<body>
<input name="cmd" type="hidden" value=""/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan="2"><fmt:message key='enter_the_name_of_hospitals,_health_centers_and_staffs_in_the_search.' /></td>
</tr>

<tr>
<td><input type="text" id="_searchText" value="" ></td>
<td width="80" valign="bottom" id="_searchSubmit"><img src="/PromesService/images/common/bt_input.gif" name="Image7" width="74" height="22" border="0" id="Image7" onmouseover="MM_swapImage('Image7','','/PromesService/images/common/bt_input_.gif',1)" onmouseout="MM_swapImgRestore()" /></td>
</tr>
<tr>
<td colspan="2"><div id="resultView"></div></td>
</tr>
</table>
</body>
</html>