<?php
include("../function_redirect.php");
$record_id=$_GET['record_id'];
$id=$_GET['id'];
 if ($_SESSION['login']!="y"){
   $redi="http://wlterm.biodiv.sinica.edu.tw/chi/login.php?page=data_detail&id=".$id."&record_id=".$record_id;
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
        
 $sqlstr="SELECT main.*, station.*, project.*,species.family_c,species.chinese,species.author from (main Inner Join station ON main.id = station.id) Inner Join project ON main.Project_id = project.Project_id Inner Join species ON main.scientific_name = species.scientific_name where record_id=" . $record_id ;
  $result=mysql_query($sqlstr,$link_ID);
if ($result !="") { //找到
  $arr=mysql_fetch_array($result); 
?>

<div align="center">
  <center>
  <table border="0" width="90%">
    <tr>
      <td width="100%"><font size="2">記錄編號：urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:<?php echo $record_id?></font>
      <table border="1" width="100%">
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>學名</td>
      <td width="50%"><i><?php echo $arr['scientific_name']."</i> ". $arr['author'] ." ".$arr['chinese'] ?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>測站編號</td>
      <td width="30%"><?php echo $arr['id']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap >科名</td>
      <td ><?php echo $arr['family']." ". $arr['family_c']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>調查地點</td>
      <td ><?php echo $arr['locality_chinese']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>個體數</td>
      <td><?php echo $arr['individual_count']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>緯度</td>
      <td><?php echo $arr['latitude']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>覆蓋率</td>
      <td><?php echo $arr['cover_rate']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>經度</td>
      <td><?php echo $arr['longitude']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>體長</td>
      <td><?php echo $arr['body_length']?>　<?php echo $arr['body_length_unit']?></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>經緯度誤差&nbsp;</td>
      <td><?php echo $arr['coordinate_precision']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>量測值</td>
      <td><?php echo $arr['biomass']?>　<?php echo $arr['biomass_unit']?></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>深度上限</td>
      <td><?php echo $arr['minimum_depth']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>調查者</td>
      <td><?php echo $arr['collector']?>　<?php echo $arr['collector_chinese']?></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>深度下限</td>
      <td><?php echo $arr['maximum_depth']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>調查方法</td>
      <td><?php echo $arr['examine_way']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>高度上限</td>
      <td><?php echo $arr['maximum_elevation']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>鑑定者</td>
      <td><?php echo $arr['identified_by']?>　<?php echo $arr['identified_by_chinese']?></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>高度下限</td>
      <td><?php echo $arr['minimum_elevation']?> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>調查日期</td>
      <td><?php echo $arr['date']?>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>　</td>
      <td>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>地點描述</td>
      <td colspan="3" valign="middle"><?php echo $arr['locality_describe']?>&nbsp;<a href="locamap.php?id=<?php echo $arr['id']?>&pid=<?php echo $arr['Project_id']?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
  <br>
    <table border="1" width="100%">
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>計畫名稱</td>
      <td><?php echo $arr['projectname']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>執行期間</td>
      <td><?php echo $arr['executiveperiod']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>委託單位</td>
      <td><?php echo $arr['associatedagency']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>執行單位</td>
      <td><?php echo $arr['executiveagency']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>主持人</td>
      <td><?php echo $arr['hostname_chinese']?>&nbsp;<?php echo $arr['hostname']?></td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>地址</td>
      <td><?php echo $arr['hostaddress']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>E-Mail</td>
      <td><?php echo $arr['hoste_mail']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>協同主持</td>
      <td><?php echo $arr['coordination']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>執行方法</td>
      <td><?php echo $arr['executiveway']?>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>計畫摘要</td>
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
echo "無此資料!";
}
?>
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>