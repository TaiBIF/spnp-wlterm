<!--
<?php
include("../function_redirect.php");
$record_id=$_GET['record_id'];
$PI=$_GET['PI'];
 if ($_SESSION['login']!="y"){
   $redi="http://wlterm.biodiv.sinica.edu.tw/chi/login.php?page=WaterQ2&PI=".$PI."&record_id=".$record_id;
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
<body topmargin="0" bgcolor="#EFEFEF">
<center><table border="0" cellpadding="0" cellspacing="0" width="998" height="100%"  background="../images/bd_background_998.gif">
<tr height="65"><td >
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="45">
  <tr height="45">
    <td align="center" valign="middle" height="45"  colspan="2"><map name="FPMap0">
	<area target="_blank" coords="75, 0, 139, 44" shape="rect" href="http://www.spnp.gov.tw/">
	</map><img border="0" src="../images/title.jpg" align="center" usemap="#FPMap0" width="750" height="45" hspace="5">
    </td>
  </tr>
  </table>
</td></tr>

<tr><td valign="top" width="100%" align="center" >
<?php  
include("left.php");
?>

</td></tr><tr height="5"><td></td></tr><tr><td width="100%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->   


</head>
<body topmargin="5">
<?php
include("../conn.php");
if ($PI=="1"){
 $sqlstr="SELECT alage.*, station.*, project.* FROM (alage INNER JOIN project ON alage.Project_id = project.Project_id) INNER JOIN station ON alage.id = station.id ";
 $sqlstr=$sqlstr . "where record_id=" . $record_id;
}else{
 $sqlstr="SELECT water.*, station.*, project.* FROM (water INNER JOIN project ON water.Project_id = project.Project_id) INNER JOIN station ON water.id = station.id ";
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
      <td width="98%"><font size="2">水質調查記錄編號：urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:WQ<?php echo $record_id?></font>
      <table border="1" width="98%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查日期</td>
      <td height="17"><?php echo $showdate?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><?php echo $arr['全天光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>硝酸鹽氮 mg/L</td>    
      <td height="17"><?php echo $arr['NO3_N']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      測站代號</td>
      <td height="17" ><?php echo $arr['id']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      直射光空域</td>    
      <td height="17"><?php echo $arr['直射光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      亞硝酸鹽氮 mg/L</td>    
      <td height="17"><?php echo $arr['NO2_N']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查地點</td>
      <td height="17"><?php echo $arr['locality_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>調查者</td>    
      <td height="17"><?php echo $arr['collector']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>硫酸鹽 mg/L</td>    
      <td height="17"><?php echo $arr['SO4']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>緯度</td>
      <td height="17"><?php echo $arr['latitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>調查者中文名</td>
      <td height="17"><?php echo $arr['collector_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>氯鹽 mg/L</td>    
      <td height="17"><?php echo $arr['Chloride']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>經度</td>
      <td height="12"><?php echo $arr['longitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>氫離子濃度</td>
      <td height="12"><?php echo $arr['PH']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>磷酸鹽 mg/L</td>    
      <td height="12"><?php echo $arr['Phosphate']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>經緯度誤差</td>
      <td height="19"><?php echo $arr['coordinate_precision']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>導電度 μS/cm</td>
      <td height="19"><?php echo $arr['Conductivity']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>總磷 mg/L</td>    
      <td height="19"><?php echo $arr['TP']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>深度上限</td>
      <td height="19"><?php echo $arr['minimum_depth']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>溶氧 mg/L</td>    
      <td height="19"><?php echo $arr['DO']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>氨氮 mg/L</td>    
      <td height="19"><?php echo $arr['AN']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>深度下限</td>
      <td height="18"><?php echo $arr['maximum_depth']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>濁度 mg/L</td>    
      <td height="18"><?php echo $arr['Clarity']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>總有機碳 mg/L</td>    
      <td height="18"><?php echo $arr['TOC']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>高度上限</td>
      <td height="19"><?php echo $arr['maximum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>矽酸鹽 mg/L</td>    
      <td height="19"><?php echo $arr['Alkali_Silicate']?>&nbsp;</td>
      <?php if ($arr['Ecoli']!=""){
	   $pEcoli="大腸桿菌CFU/100ml";
	   $Ecoli=$arr['Ecoli'];
	   }else{
	   $pEcoli="&nbsp;"; 
	   $Ecoli="&nbsp;";
	   }
	  ?>
      <td width="140" bgcolor="#CCCCCC" nowrap><?php echo $pEcoli?></td>    
      <td height="19"><?php echo $Ecoli?></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>高度下限</td>
      <td height="19"><?php echo $arr['minimum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      生化需氧量 mg/L</td>    
      <td height="19"><?php echo $arr['BOD']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查點描述</td>
      <td height="19" colspan="5"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMap.php?id=<?php echo $arr['id']?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<?php }elseif ($PI=="4"){ ?>
  <table border="0" width="95%">
    <tr>
      <td width="95%"><font size="2">硝酸鹽調查記錄編號：urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:WQ<?php echo $record_id?></font>
      <table border="1" width="98%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查日期</td>
      <td height="17"><?php echo $showdate?></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>高度上限</td>
      <td height="17"><?php echo $arr['maximum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>水溫&nbsp; ℃</td>    
      <td height="17"><?php echo $arr['temperature']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      測站代號</td>
      <td height="17" ><?php echo $arr['id']?></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>高度下限</td>
      <td height="17"><?php echo $arr['minimum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      硝酸鹽 mg/L</td>    
      <td height="17"><?php echo $arr['Nitrate']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查地點</td>
      <td height="17"><?php echo $arr['locality_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><?php echo $arr['全天光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap rowspan="2">NO3-穩定氮同<br>
      位素δ15N</td>    
      <td height="34" rowspan="2"><?php echo $arr['NO3_15N']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>緯度</td>
      <td height="17"><?php echo $arr['latitude']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>直射光空域</td>   
      <td height="17"><?php echo $arr['直射光空域']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>經度</td>
      <td height="12"><?php echo $arr['longitude']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>調查者</td>    
      <td height="12"><?php echo $arr['collector']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>PH值</td>    
      <td height="12"><?php echo $arr['ph']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>經緯度誤差</td>
      <td height="19"><?php echo $arr['coordinate_precision']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap:>調查者中文名</td>
      <td height="19"><?php echo $arr['collector_chinese']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>EC &micro;S/cm</td>    
      <td height="19"><?php echo $arr['EC']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>深度上限</td>
      <td height="19"><?php echo $arr['minimum_depth']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>溶氧量 mg/L</td>    
      <td height="19"><?php echo $arr['DO']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>&nbsp;</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>深度下限</td>
      <td height="18"><?php echo $arr['maximum_depth']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>溶氧率 %</td>    
      <td height="18"><?php echo $arr['DO_Rate']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>&nbsp;</td>    
      <td height="18">&nbsp;</td>
    </tr>
     <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查點描述</td>
      <td height="19" colspan="5"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMap.php?id=<?php echo $arr['id']?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<?php }elseif ($PI=="13"){?>  
  <table border="0" width="95%">
    <tr>
      <td width="98%"><font size="2">主要元素通量調查記錄編號：urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:WQ<?php echo $record_id?></font>
      <table border="1" width="98%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查日期</td>
      <td height="17"><?php echo $showdate?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><?php echo $arr['全天光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>氨</td>    
      <td height="17"><?php echo $arr['NH4']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      測站代號</td>
      <td height="17" ><?php echo $arr['id']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      調查者</td>    
      <td height="17"><?php echo $arr['collector']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      亞硝酸鹽 mg/L</td>    
      <td height="17"><?php echo $arr['NO2']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查地點</td>
      <td height="17"><?php echo $arr['locality_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>調查者中文名</td>    
      <td height="17"><?php echo $arr['collector_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>溶解有機碳 mg/L</td>    
      <td height="17"><?php echo $arr['DOC']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>緯度</td>
      <td height="17"><?php echo $arr['latitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>水溫&nbsp; ℃</td>
      <td height="17"><?php echo $arr['temperature']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>鈉 mg/L</td>    
      <td height="17"><?php echo $arr['Na']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>經度</td>
      <td height="12"><?php echo $arr['longitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>氫離子濃度</td>
      <td height="12"><?php echo $arr['PH']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>鎂 mg/L</td>    
      <td height="12"><?php echo $arr['Mg']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>經緯度誤差</td>
      <td height="19"><?php echo $arr['coordinate_precision']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>導電度 μS/cm</td>
      <td height="19"><?php echo $arr['Conductivity']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>鉀 mg/L</td>    
      <td height="19"><?php echo $arr['K']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>深度上限</td>
      <td height="19"><?php echo $arr['minimum_depth']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>硝酸鹽 mg/L</td>    
      <td height="19"><?php echo $arr['nitrate']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>鈣 mg/L</td>    
      <td height="19"><?php echo $arr['Ca']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>深度下限</td>
      <td height="18"><?php echo $arr['maximum_depth']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>硫酸鹽 mg/L</td>    
      <td height="18"><?php echo $arr['SO4']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>鍶 mg/L</td>    
      <td height="18"><?php echo $arr['Sr']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>高度上限</td>
      <td height="19"><?php echo $arr['maximum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>磷酸鹽 mg/L</td>    
      <td height="19"><?php echo $arr['Phosphate']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>鋇 mg/L</td>    
      <td height="19"><?php echo $arr['Ba']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" >高度下限</td>
      <td height="19"><?php echo $arr['minimum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" >
      氯鹽 mg/L</td>    
      <td height="19" ><?php echo $arr['Chloride']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC"  >矽 mg/L</td>    
      <td height="19"><?php echo $arr['Si']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>直射光空域</td>
      <td height="19"><?php echo $arr['直射光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      氟 mg/L</td>    
      <td height="19"><?php echo $arr['Fl']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查點描述</td>
      <td height="19" colspan="5"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMap.php?id=<?php echo $arr['id']?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
 
<?php }elseif ($PI=="1"){ ?>
  <table border="0" width="95%">
    <tr>
      <td width="98%"><font size="2">藻類與有機碎屑調查記錄編號：urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:AO<?php echo $record_id?></font>
      <table border="1" width="98%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查日期</td>
      <td height="17"><?php echo $showdate?></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>高度上限</td>
      <td height="17"><?php echo $arr['maximum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>深度上限</td>    
      <td height="17"><?php echo $arr['minimum_depth']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      測站代號</td>
      <td height="17" ><?php echo $arr['id']?></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>高度下限</td>
      <td height="17"><?php echo $arr['minimum_elevation']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >深度下限</td>    
      <td height="17"><?php echo $arr['maximum_depth']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查地點</td>
      <td height="17"><?php echo $arr['locality_chinese']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><?php echo $arr['全天光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>調查項目</td>    
      <td height="17"><?php echo $arr['item_chinese']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>緯度</td>
      <td height="17"><?php echo $arr['latitude']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>直射光空域</td>   
      <td height="17"><?php echo $arr['直射光空域']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>調查值</td>   
      <td height="17"><?php echo $arr['biomass']?></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>經度</td>
      <td height="12"><?php echo $arr['longitude']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>調查者</td>    
      <td height="12"><?php echo $arr['collector']?></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>單位</td>    
      <td height="12"><?php echo $arr['unit']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>經緯度誤差</td>
      <td height="19"><?php echo $arr['coordinate_precision']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap:>調查者中文名</td>
      <td height="19"><?php echo $arr['collector_chinese']?>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="19">　</td>
    </tr>
     <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>調查點描述</td>
      <td height="19" colspan="5"><?php echo $arr['locality_describe']?>&nbsp;<a href="LocalMap.php?id=<?php echo $arr['id']?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<?php }?>
  <br>
    <table border="1" width="98%">
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>計畫名稱</td>
      <td><?php echo $arr['projectname']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>執行期間</td>
      <td><?php echo $arr['executiveperiod']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>委託單位</td>
      <td><?php echo $arr['associatedagency']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>執行單位</td>
      <td><?php echo $arr['executiveagency']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>主持人</td>
      <td><?php echo $arr['hostname_chinese']?>&nbsp;<?php echo $arr['hostname']?></td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>地址</td>
      <td><?php echo $arr['hostaddress']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>E-Mail</td>
      <td><?php echo $arr['hoste_mail']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>協同主持人</td>
      <td><?php echo $arr['coordination']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>執行方法</td>
      <td><?php echo $arr['executiveway']?>&nbsp;</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>計畫摘要</td>
      <td><?php echo $arr['projectsummary']?>&nbsp;</td>
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
<?php
}else{
echo "無此資料!";
}
?>
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
</body>
</html>