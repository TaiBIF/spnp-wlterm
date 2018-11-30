<?php
include("../function_redirect.php");
$record_id=$_GET['record_id'];
$id=$_GET['id'];
 if ($_SESSION['login']!="y"){
   $redi="http://wlterm.biodiv.sinica.edu.tw/eng/login.php?page=data_detail&id=".$id."&record_id=".$record_id;
   redirect($redi,301);
 }
 ?>
<!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WLTERM</title>
<script language="JavaScript" src="menu.js"></script>
</head>
<body topmargin="0"  bgcolor="#EFEFEF">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="998" height="100%"  background="../images/bd_background_998.gif">
<tr height="65"><td colspan="2">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="45">
  <tr height="45">
    <td align="center" valign="middle" height="45" ><map name="FPMap0">
	<area target="_blank" coords="22, 4, 87, 44" shape="rect" href="http://www.spnp.gov.tw/">
	<area target="_blank" coords="90, 0, 139, 44" shape="rect" href="http://www.spnp.gov.tw/">
	</map><img border="0" src="../images/title_E.gif" align="center" usemap="#FPMap0" width="750" height="45" hspace="5">
    </td>
  </tr>
  </table>
</td></tr>

<tr><td valign="top" width="100%" align="center" height="52"> 
<?php  
include("left.php");
?>
</td></tr><tr height="5"><td></td></tr><tr><td width="100%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->         
<STYLE TYPE="text/css">
        <!-- body, th, td, input, select, textarea, select, checkbox {font:10pt Arial}
         a:link {font: 10pt "Arial"; text-decoration: none;color:none}
         a:visited      {font: 10pt "Arial"; text-decoration: none; color: 000000}
         a:active       {font: 10pt "Arial"; text-decoration: none; color: 00CC66}
         a:hover        {font: 10pt Arial; text-decoration: underline; color: ff0000}
        -->
   </STYLE>

</head>
<body topmargin="5">
<?php 
include("../conn.php");
      
 $sqlstr="SELECT main.*, station.*, project.* FROM (main INNER JOIN station ON main.id = station.id) INNER JOIN project ON main.project_id = project.project_id where record_id=" . $record_id ;
  $result=mysql_query($sqlstr,$link_ID);
if ($result !="") { //找到
  $arr=mysql_fetch_array($result); 
?>

<div align="center">
  <center>
  <table border="0" width="90%">
    <tr>
      <td width="100%"><font size="2">Record NO. :urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:<?php echo $record_id?></font>
      <table border="1" width="100%">
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Scientific Name</td>
      <td><?php echo $arr['scientific_name']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Station NO.</td>
      <td><?php echo $arr['id']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap >Family</td>
      <td ><?php echo $arr['family']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Locality</td>
      <td ><?php echo $arr['locality']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Individual Count</td>
      <td><?php echo $arr['individual_count']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Latitude</td>
      <td><?php echo $arr['latitude']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Cover Rate</td>
      <td><?php echo $arr['cover_rate']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Longitude</td>
      <td><?php echo $arr['longitude']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Length</td>
      <td><?php echo $arr['body_length']?>　<?php echo $arr['body_length_unit']?></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Cordinate Precision</td>
      <td><?php echo $arr['coordinate_precision']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Biosmass</td>
      <td><?php echo $arr['biomass']?>　<?php echo $arr['biomass_unit']?></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>
      <td><?php echo $arr['minimum_depth']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Invester</td>
      <td><?php echo $arr['collector']?>　<?php echo $arr['collector_chinese']?></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Maxmum Depth</td>
      <td><?php echo $arr['maximum_depth']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Invest Way</td>
      <td><?php echo $arr['examine_way']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Minimum Elevation</td>
      <td><?php echo $arr['maximum_elevation']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Identifier</td>
      <td><?php echo $arr['identified_by']?> </td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Maxmum Elevation</td>
      <td><?php echo $arr['minimum_elevation']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Date</td>
      <td><?php echo $arr['date']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>　</td>
      <td>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Locality Summary</td>
      <td colspan="3" valign="middle"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMapE.php?id=<?php echo $arr['station.id']?>&pid=<?php echo $arr['main.project_id']?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
  <br>
    <table border="1" width="100%">
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Project Name</td>
      <td><?php echo $arr['projectname']?>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Executive Period</td>
      <td><?php echo $arr['executiveperiod']?>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Associated Agency</td>
      <td><?php echo $arr['associatedagency']?>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Executive Agency</td>
      <td><?php echo $arr['executiveagency']?>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Host Name</td>
      <td>&nbsp;<?php echo $arr['hostname']?></td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Host Address</td>
      <td><?php echo $arr['hostaddress']?>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>E-Mail</td>
      <td><?php echo $arr['hoste_mail']?>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Coordination</td>
      <td><?php echo $arr['coordination']?>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Executive Way</td>
      <td><?php echo $arr['executiveway']?>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Project Summary</td>
      <td><?php echo $arr['projectsummary']?>　</td>
    </tr>
  </table>

      </td>
     
    </tr>
    <tr><td>
     <font size="3" color="#000000"><a href="../xml_bio.php?record_id=<?php echo $arr['record_id']?>"><b><img border="0" src="../images/savexml.gif" style="vertical-align:middle" vspace="3"> Get XML with Darwin Core</b></a></font>  
  </td></tr>
  </table>
  
  </center>
<?php
}else{
echo "Not Found !";
}
?>
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>