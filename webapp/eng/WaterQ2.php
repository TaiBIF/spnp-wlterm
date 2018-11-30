<!--
<?php
include("../function_redirect.php");
$record_id=$_GET['record_id'];
$PI=$_GET['PI'];
 if ($_SESSION['login']!="y"){
   $redi="http://wlterm.biodiv.sinica.edu.tw/eng/login.php?page=WaterQ2&PI=".$PI."&record_id=".$record_id;
   redirect($redi,301);
 }
 ?>//--> 
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
$record_id=$_GET['record_id'];
$PI=$_GET['PI'];
if ($PI=="1"){
 $sqlstr="SELECT alage.*, Station.*, Project.* FROM (alage INNER JOIN Project ON alage.Project_id = Project.Project_id) INNER JOIN Station ON alage.id = Station.id ";
 $sqlstr=$sqlstr . "where record_id=" . $record_id;
}else{
 $sqlstr="SELECT water.*, Station.*, Project.* FROM (water INNER JOIN Project ON water.Project_id = Project.Project_id) INNER JOIN Station ON water.id = Station.id ";
 $sqlstr=$sqlstr . "where record_id=" . $record_id;
}
  $result=mysql_query($sqlstr,$link_ID);
if ($result !="") { //找到
  $arr=mysql_fetch_array($result); 
	 $pdate=strtotime($arr['date']);
	 $pdate=getdate($pdate);
	 if ($pdate['hours']==0 && $pdate['minutes']==0 && $pdate['seconds']==0){
	  $showdate=$pdate['year'] . "-" . substr(100+$pdate['mon'],1,2) . "-" .substr(100+$pdate['mday'],1,2);
	 }else{
	  $showdate=$arr['date'];
	 } 
?>
<div align="center">
  <center>
<?php if ($PI=="3"){?>  
  <table border="0" width="95%">
    <tr>
      <td width="98%"><font size="2">Water Quality Records NO.:urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:WQ<?php echo $record_id?></font>
      <table border="1" width="98%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Date</td>
      <td height="17"><?php echo $showdate?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><?php echo $arr['全天光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>NO3_N mg/L</td>    
      <td height="17"><?php echo $arr['NO3_N']?></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      Staion ID</td>
      <td height="17" ><?php echo $arr['id']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      直射光空域</td>    
      <td height="17"><?php echo $arr['直射光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      NO2_N mg/L</td>    
      <td height="17"><?php echo $arr['NO2_N']?></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality</td>
      <td height="17"><?php echo $arr['locality_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector</td>    
      <td height="17"><?php echo $arr['collector']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>SO4 mg/L</td>    
      <td height="17"><?php echo $arr['SO4']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Latitude</td>
      <td height="17"><?php echo $arr['latitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector in Chinese</td>
      <td height="17"><?php echo $arr['collector_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Chloride mg/L</td>    
      <td height="17"><?php echo $arr['Chloride']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Longitude</td>
      <td height="12"><?php echo $arr['longitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>PH</td>
      <td height="12"><?php echo $arr['PH']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Phosphate mg/L</td>    
      <td height="12"><?php echo $arr['Phosphate']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Coordinate Precision</td>
      <td height="19"><?php echo $arr['coordinate_precision']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Conductivity μS/cm</td>
      <td height="19"><?php echo $arr['Conductivity']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>TP mg/L</td>    
      <td height="19"><?php echo $arr['TP']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>
      <td height="19"><?php echo $arr['minimum_depth']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>DO mg/L</td>    
      <td height="19"><?php echo $arr['DO']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>AN mg/L</td>    
      <td height="19"><?php echo $arr['AN']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Depth</td>
      <td height="18"><?php echo $arr['maximum_depth']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Clarity mg/L</td>    
      <td height="18"><?php echo $arr['Clarity']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>TOC mg/L</td>    
      <td height="18"><?php echo $arr['TOC']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Elevation</td>
      <td height="19"><?php echo $arr['maximum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Alkali Silicate mg/L</td>    
      <td height="19"><?php echo $arr['Alkali_Silicate']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Elevation</td>
      <td height="19"><?php echo $arr['minimum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      BOD mg/L</td>    
      <td height="19"><?php echo $arr['BOD']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality_Describe</td>
      <td height="19" colspan="5"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMapE.php?id=<?php echo $arr['id']?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<?php }elseif ($PI=="4"){ ?>
  <table border="0" width="95%">
    <tr>
      <td width="98%"><font size="2">Nitrate Record NO.：urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:WQ<?php echo $record_id?></font>
      <table border="1" width="98%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Date</td>
      <td height="17"><?php echo $showdate?></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Elevation</td>
      <td height="17"><?php echo $arr['maximum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>水溫&nbsp; ℃</td>    
      <td height="17"><?php echo $arr['temperature']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      Staion ID</td>
      <td height="17" ><?php echo $arr['id']?></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Elevation</td>
      <td height="17"><?php echo $arr['minimum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      Nitrate mg/L</td>    
      <td height="17"><?php echo $arr['Nitrate']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality</td>
      <td height="17"><?php echo $arr['locality_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><?php echo $arr['全天光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap rowspan="2">NO3_δ15N</td>    
      <td height="34" rowspan="2"><?php echo $arr['NO3_15N']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Latitude</td>
      <td height="17"><?php echo $arr['latitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>直射光空域</td>   
      <td height="17"><?php echo $arr['直射光空域']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Longitude</td>
      <td height="12"><?php echo $arr['longitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector</td>    
      <td height="12"><?php echo $arr['collector']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>PH</td>    
      <td height="12"><?php echo $arr['ph']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Coordinate Precision</td>
      <td height="19"><?php echo $arr['coordinate_precision']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap:>Collector in Chinese</td>
      <td height="19"><?php echo $arr['collector_chinese']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>EC &micro;S/cm</td>    
      <td height="19"><?php echo $arr['EC']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>
      <td height="19"><?php echo $arr['minimum_depth']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>DO mg/L</td>    
      <td height="19"><?php echo $arr['DO']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Depth</td>
      <td height="18"><?php echo $arr['maximum_depth']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>DO %</td>    
      <td height="18"><?php echo $arr['DO_Rate']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="18">&nbsp;</td>
    </tr>
     <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality_Describe</td>
      <td height="19" colspan="5"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMapE.php?id=<?php echo $arr['id']?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<?php }elseif ($PI=="13"){?>  
  <table border="0" width="95%">
    <tr>
      <td width="98%"><font size="2">Main Water Elemnets Record NO.：urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:WQ<?php echo $record_id?></font>
      <table border="1" width="98%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Date</td>
      <td height="17"><?php echo $showdate?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><?php echo $arr['全天光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>NH4</td>    
      <td height="17"><?php echo $arr['NH4']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      Staion ID</td>
      <td height="17" ><?php echo $arr['id']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      Collector</td>    
      <td height="17"><?php echo $arr['collector']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      NO2 mg/L</td>    
      <td height="17"><?php echo $arr['NO2']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality</td>
      <td height="17"><?php echo $arr['locality_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector in Chinese</td>    
      <td height="17"><?php echo $arr['collector_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>DOC mg/L</td>    
      <td height="17"><?php echo $arr['DOC']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Latitude</td>
      <td height="17"><?php echo $arr['latitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Water Tem. ℃</td>
      <td height="17"><?php echo $arr['temperature']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Na mg/L</td>    
      <td height="17"><?php echo $arr['Na']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Longitude</td>
      <td height="12"><?php echo $arr['longitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>PH</td>
      <td height="12"><?php echo $arr['PH']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Mg mg/L</td>    
      <td height="12"><?php echo $arr['Mg']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Coordinate Precision</td>
      <td height="19"><?php echo $arr['coordinate_precision']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Conductivity μS/cm</td>
      <td height="19"><?php echo $arr['Conductivity']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>K mg/L</td>    
      <td height="19"><?php echo $arr['K']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>
      <td height="19"><?php echo $arr['minimum_depth']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Nitrate mg/L</td>    
      <td height="19"><?php echo $arr['nitrate']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Ca mg/L</td>    
      <td height="19"><?php echo $arr['Ca']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Depth</td>
      <td height="18"><?php echo $arr['maximum_depth']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>SO4 mg/L</td>    
      <td height="18"><?php echo $arr['SO4']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Sr mg/L</td>    
      <td height="18"><?php echo $arr['Sr']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Elevation</td>
      <td height="19"><?php echo $arr['maximum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Phosphate mg/L</td>    
      <td height="19"><?php echo $arr['Phosphate']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Ba mg/L</td>    
      <td height="19"><?php echo $arr['Ba']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" >Minimum Elevation</td>
      <td height="19"><?php echo $arr['minimum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" >
      Chloride mg/L</td>    
      <td height="19" ><?php echo $arr['Chloride']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC"  >Si mg/L</td>    
      <td height="19"><?php echo $arr['Si']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>直射光空域</td>
      <td height="19"><?php echo $arr['直射光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      Fl mg/L</td>    
      <td height="19"><?php echo $arr['Fl']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality_Describe</td>
      <td height="19" colspan="5"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMapE.php?id=<?php echo $arr['id']?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
 
<?php }elseif ($PI=="1"){ ?>
  <table border="0" width="95%">
    <tr>
      <td width="98%"><font size="2">Alage and Organic Detritus Record NO.：urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:AO<?php echo $record_id?></font>
      <table border="1" width="98%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Date</td>
      <td height="17"><?php echo $showdate?></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Elevation</td>
      <td height="17"><?php echo $arr['maximum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>    
      <td height="17"><?php echo $arr['minimum_depth']?></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      Staion ID</td>
      <td height="17" ><?php echo $arr['id']?></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Elevation</td>
      <td height="17"><?php echo $arr['minimum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >Maximum Depth</td>    
      <td height="17"><?php echo $arr['maximum_depth']?></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality</td>
      <td height="17"><?php echo $arr['locality_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><?php echo $arr['全天光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Item</td>    
      <td height="17"><?php echo $arr['item']?></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Latitude</td>
      <td height="17"><?php echo $arr['latitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>直射光空域</td>   
      <td height="17"><?php echo $arr['直射光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Biomass</td>   
      <td height="17"><?php echo $arr['biomass']?></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Longitude</td>
      <td height="12"><?php echo $arr['longitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector</td>    
      <td height="12"><?php echo $arr['collector']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Unit</td>    
      <td height="12"><?php echo $arr['unit']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Coordinate Precision</td>
      <td height="19"><?php echo $arr['coordinate_precision']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap:>Collector in Chinese</td>
      <td height="19"><?php echo $arr['collector_chinese']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="19">　</td>
    </tr>
     <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality_Describe</td>
      <td height="19" colspan="5"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMapE.php?id=<?php echo $arr['id']?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<?php }?>
  <br>
    <table border="1" width="98%">
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
     <font size="3" color="#000000">
    <?php if ($PI=="1"){ ?>
    <a href="../xml_ao.php?record_id=<?php echo $arr['record_id']?>"><b><img border="0" src="../images/savexml.gif" style="vertical-align:middle" vspace="3"> Get XML with Darwin Core</b></a></font>  
    <?php }else{?>  
    <a href="../xml_w.php?record_id=<?php echo $arr['record_id']?>"><b><img border="0" src="../images/savexml.gif" style="vertical-align:middle" vspace="3"> Get XML with Darwin Core</b></a></font>  
    <?php }?>
  </td></tr>
  </table>
  
  </center>
<?php
}else{
echo "無此資料!";
}
?>
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>