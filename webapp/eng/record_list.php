﻿<!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN"> 
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
$_SESSION['item']="7";
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

<?php   
include("../conn.php"); 
    
$porder=$_GET['R1'];
$pcrit=$_GET['D1'];
$sc=$_GET['sc'];
$fa=$_GET['fa'];
$or=$_GET['or'];
$cl=$_GET['cl'];
if ($sc != ""){
 $ptitle=$sc;
}elseif ($fa != ""){
 $ptitle=$fa;
}elseif ($or != ""){
 $ptitle=$or;
}elseif ($cl != ""){
 $ptitle=$cl;
}else{
 $ptitle="";
}
 
if ($pcrit=="")$pcrit="ALL";
if ($pcrit=="ALL"){
 $ppcrit="All Stations";
}else{
 $ppcrit="Station:" . $pcrit ;   
}
if ($porder=="")$porder="family";
if ($porder=="family"){ 
  $pporder="family,scientific_name";
  $p1=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="scientific_name"){ 
  $pporder="scientific_name";
  $p2=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="date"){ 
  $pporder="`date`";
  $p3=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="locality"){ 
  $pporder="locality";
  $p4=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="collector"){ 
  $pporder="collector";
  $p6=" style='border: 1 ridge #B4B4B4'";
}else{
  $pporder="`".$porder."`";
} 
$key=$_GET['key'];
if ($_GET['pz'] != ""){
 $pz=intval($_GET['pz']);}
else{
 $pz =20;
}
if ($pz ==15){
 $s15="selected";
}elseif ($pz ==10){
 $s10="selected";
}elseif ($pz ==20){
 $s20="selected";
}elseif ($pz ==30){
 $s30="selected";
}elseif ($pz ==50){
 $s50="selected";
}elseif ($pz ==100){
 $s100="selected";
}elseif ($pz ==200){
 $s200="selected";
}elseif ($pz ==500){
 $s500="selected";
} 
if ($pcrit=="ALL" ){
 if ($sc != ""){
  $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id where scientific_name='" . $sc . "' order by " . $pporder;
 }elseif ($fa != ""){
   $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id where family='" . $fa . "'  order by " . $pporder;
 }elseif ($or != ""){
   $sqlstr="SELECT view_count(0) FROM view_main INNER JOIN station ON view_main.id = station.id where `order`='" . $or . "'  order by " . $pporder;
 }elseif ($cl != ""){
   $sqlstr="SELECT count(0) FROM view_main INNER JOIN station ON view_main.id = station.id where `class`='" . cl . "'  order by " . $pporder;
 }else{
  $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id  order by " . $pporder;
 }
}else{
 if ($sc != ""){
  $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id where  main.id=" . $pcrit . " and scientific_name='" . $sc . "' order by " . $pporder;
 }elseif ($fa != ""){
   $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id where main.id=" . $pcrit . " and family='" . $fa . "'  order by " . $pporder;
 }elseif ($or != ""){
   $sqlstr="SELECT count(0) FROM view_main INNER JOIN station ON view_main.id = station.id where  view_main.id=" . $pcrit . " and `order`='" . $or . "'  order by " . $pporder;
 }elseif ($cl != ""){
   $sqlstr="SELECT count(0) FROM view_main INNER JOIN station ON view_main.id = station.id where  view_main.id=" . $pcrit . " and  `class`='" . cl . "'  order by " . $pporder;
 }else{
  $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id where main.id=" . $pcrit . " order by " . $pporder;
 }
}
 $result=mysql_query($sqlstr,$link_ID);
  $datatotal = mysql_fetch_row($result);
  $sn_index=$datatotal[0];
if ($sn_index/$pz > intval($sn_index/$pz)){
$pagecount=intval($sn_index/$pz)+1;
}else{
$pagecount=intval($sn_index/$pz);
}
$page=intval($_GET['page']);
if ($page < 1) {$page=1;}
$group=intval(($page-1)/10);
$pgroup=intval(($pagecount-1)/10);
if ($page > $pagecount){$page=$pagecount;}
if ($group < 0) {$group=0;}
if ($group > $pagecount){$group=$pagecount;}
?> 
<form name="form1" action="record_list.php">
  <center><font size="4" color="#393939"><B><?php echo $sn_index?> Records for <?php echo $ppcrit?></B></font>

  <a href="LocalMapE.php?id=<?php echo $pcrit?>&pid=all"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
  <table border=0 cellpadding=0 cellspacing=0><tr><td>
  <center><A HREF="record_list.php?page=1&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/first.gif" title="First Page"></a>&nbsp;    
  <?php if ($group > 0){ ?>                  
  <A HREF="record_list.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous10.gif" title="Previous 10 Page"></a>&nbsp;                                                    
   <?php }else{ ?>               
  <img border="0"  src="../images/previous10dis.gif" title="Previous 10 Page()">&nbsp;                                                    
   <?php }?>                  
    <A HREF="record_list.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous.gif" title="Previous Page"></a>&nbsp;                                                    
<A HREF="record_list.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next.gif" title="Next Page"></a>&nbsp;                                                     
  <?php if ($group < $pgroup){ ?>                   
<A HREF="record_list.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next10.gif" title="Next 10 Page"></a>&nbsp;                                                     
   <?php }else{ ?>               
<img border="0"  src="../images/next10dis.gif" title="Next 10 Page()">&nbsp;                                                     
  <?php }?>                 
  <A HREF="record_list.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/last.gif" title="Last Page"></a>&nbsp;&nbsp;          
<?php  
for ($i=$group*10+1; $i <= $group*10+10; $i++){                      
    if ($i > $pagecount) break; 
    if ($i==$page){ 
     $icolor="#FF0000";
     $ibold="<B>";
     $ibold2="</B>";
	 }
    else{
     $icolor="";
     $ibold="";
     $ibold2="";
    }                                       
echo "<A HREF='record_list.php?page=".$i."&R1=".$porder."&key=". urlencode($key)."&pz=".$pz. "&D1=".$pcrit."'><font class=font16 color='".$icolor."'>".$ibold. $i. $ibold2."</a></font>&nbsp;";                                              
                                   
};                      
?>             
  &nbsp;<font class=font16><?php echo $pagecount?> Pages&nbsp;&nbsp;Page size:
    <select name="pz" id="select"  style="font-size: 11px" onChange=submit()>
  	<option value="10"  <?php echo $s15?>>10</option>
  	<option value="15"  <?php echo $s15?>>15</option>
  	<option value="20"  <?php echo $s20?>>20</option>
	<option value="30" <?php echo $s30?>>30</option>
	<option value="50" <?php echo $s50?>>50</option>
	<option value="100" <?php echo $s100?>>100</option>
	<option value="200" <?php echo $s200?>>200</option>
	<option value="500" <?php echo $s500?>>500</option>
  </select>

  &nbsp;&nbsp;</font>
  </td>
     
    </tr>  
  </table>  
  <input type="hidden" name="page" value="<?php echo $page?>">                 
<input type="hidden" name="R1" value="<?php echo $porder?>">  
                 
 
<table border="1" height="49" cellspacing="1" cellpadding="2" width="95%">         
   <tr>         
    <td class=tdHead nowrap>Family<a href="record_list.php?page=<?php echo $page?>&R1=family&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo $p1?>></a></font></td>         
    <td class=tdHead nowrap>Scientific Name<a href="record_list.php?page=<?php echo $page?>&R1=scientific_name&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo $p2?>></a></font></td>         
    <td class=tdHead nowrap>Date<a href="record_list.php?page=<?php echo $page?>&R1=date&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo $p3?>></a></font></td>         
    <td class=tdHead nowrap>Locality<a href="record_list.php?page=<?php echo $page?>&R1=locality&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo $p4?>></a></font></td>         
    <td class=tdHead nowrap>Latitude<a href="record_list.php?page=<?php echo $page?>&R1=locality&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo $p14?>></a></font></td>         
    <td class=tdHead nowrap>Longitude<a href="record_list.php?page=<?php echo $page?>&R1=locality&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo $p14?>></a></font></td>         
    <td class=tdHead nowrap>Depth<a href="record_list.php?page=<?php echo $page?>&R1=minimum_depth&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo $p5?>></a></font></td>      
    <td class=tdHead nowrap>Collector<a href="record_list.php?page=<?php echo $page?>&R1=collector&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo $p6?>></a></font></td>      
    <td class=tdHead nowrap>Detail</font></td>          </tr>         
    
        <?php        
if ($pcrit=="ALL" ){
 if ($sc != ""){
  $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id where scientific_name='" . $sc . "' order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }elseif ($fa != ""){
   $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id where family='" . $fa . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }elseif ($or != ""){
   $sqlstr="SELECT view_main.*, station.* FROM view_main INNER JOIN station ON view_main.id = station.id where `order`='" . $or . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }elseif ($cl != ""){
   $sqlstr="SELECT view_main.*, station.* FROM view_main INNER JOIN station ON view_main.id = station.id where `class`='" . cl . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }else{
  $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }
}else{
 if ($sc != ""){
  $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id where  main.id=" . $pcrit . " and scientific_name='" . $sc . "' order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }elseif ($fa != ""){
   $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id where main.id=" . $pcrit . " and family='" . $fa . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }elseif ($or != ""){
   $sqlstr="SELECT view_main.*, station.* FROM view_main INNER JOIN station ON view_main.id = station.id where  view_main.id=" . $pcrit . " and `order`='" . $or . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }elseif ($cl != ""){
   $sqlstr="SELECT view_main.*, station.* FROM view_main INNER JOIN station ON view_main.id = station.id where  view_main.id=" . $pcrit . " and  `class`='" . cl . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }else{
  $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id where main.id=" . $pcrit . " order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }
}
 $result=mysql_query($sqlstr,$link_ID);
  $result=mysql_query($sqlstr,$link_ID);  
  if ($result !="") {
  $sn2_index=mysql_num_rows($result); 
  for ($index=0; $index < $sn2_index ; $index++){
    if (fmod($index,2)==0){
	  $tdclass="tdN";
	  $tdclassf="tdNf";
	}else{
	  $tdclass="tdNodd";
	  $tdclassf="tdNoddf";
	}   
   $arr[$index]=mysql_fetch_array($result);                
     echo "<tr>";  
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['family']."</td>";       
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['scientific_name']."</td>";       
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['date']."&nbsp;</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['locality']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['latitude']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['longitude']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['minimum_depth']."-". $arr[$index]['maximum_depth']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['collector']."</td>";   
     $plink="data_detail.php?record_id=" . $arr[$index]['record_id'];
     echo "<td align='left' class=".$tdclass."><a href=".$plink."><img border='0' src='../images/smallearth.gif' width='22' height='15' align='center'></a></td></tr>";   
    }; 
	}      
    ?>        
  </table>       
   <p style="margin-top: 3">       
 <font face="sө" size="2" color="#800000">      
    <A HREF="record_list.php?page=1&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/first.gif" title="First Page" align="absmiddle" hspace="3" vspace="1"></a>              
  <?php if ($group > 0){ ?>                  
  <A HREF="record_list.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous10.gif" title="Previous 10 Page" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <?php }else{ ?>                     
  <img border="0"  src="../images/previous10dis.gif" title="Previous 10 Page" align="absmiddle" hspace="3" vspace="1">                                    
   <?php }?>                        
    <A HREF="taibnet_species_list.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous.gif" title="Previous Page" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="record_list.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next.gif" title="Next Page" align="absmiddle" hspace="3" vspace="1"></a>                                     
  <?php if ($group < $pgroup){ ?>                   
<A HREF="record_list.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next10.gif" title="Next 10 Page" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php }else{ ?>                     
<img border="0"  src="../images/next10dis.gif" title="Next 10 Page" align="absmiddle" hspace="3" vspace="1">                                     
  <?php }?>                       
  <A HREF="record_list.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/last.gif" title="Last Page" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <input type="hidden" name="R1" value="<?php echo $porder?>">
 <input type="hidden" name="D1" value="<?php echo $pcrit?>">
 <input type="hidden" name="PI" value="<?php echo PI?>">

</form>
</td></tr></table>

  </center>

  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>