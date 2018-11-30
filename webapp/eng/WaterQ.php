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
$PI=$_GET['PI'];
if ($PI=="3"){
  $_SESSION['item']="8";
}elseif ($PI=="4"){
  $_SESSION['item']="9";
}elseif ($PI=="1"){
  $_SESSION['item']="12";
}elseif ($PI=="13"){
  $_SESSION['item']="10";
}
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

<body topmargin="5">
<?php
include("../conn.php"); 
$pporder=$_GET['R1'];
$pcrit=$_GET['D1'];
if ($PI=="3"){
   $PIN="Water Quality";
}elseif ($PI=="4"){
   $PIN="Nitrate";
}elseif ($PI=="1"){
   $PIN="Alage Detritus";
}elseif ($PI=="13"){
   $PIN="Water Elements";
}   
if ($pcrit=="ALL"){
 $ppcrit="ALL Stations";
}else{
 $ppcrit="Station:" . $pcrit ;   
} 
if ($porder==""){ $porder="station.id";}
if ($porder=="station.id"){ 
  $p1=" style='border: 1 ridge #B4B4B4'";
  $pporder="station.id,`date`";
}elseif ($porder=="locality"){ 
  $p2=" style='border: 1 ridge #B4B4B4'";
  $pporder="locality,`date`";
}elseif ($porder=="latitude"){
  $p3=" style='border: 1 ridge #B4B4B4'";
  $pporder="latitude,`date`";
}elseif ($porder=="longitude"){
  $p4=" style='border: 1 ridge #B4B4B4'";
  $pporder="longitude,`date`";
}elseif ($porder=="minimum_elevation"){
  $p5=" style='border: 1 ridge #B4B4B4'";
  $pporder="minimum_elevation,`date`";
}elseif ($porder=="minimum_depth"){
  $p6=" style='border: 1 ridge #B4B4B4'";
  $pporder="minimum_depth,`date`";
}elseif ($porder=="collector"){
  $p7=" style='border: 1 ridge #B4B4B4'";
  $pporder="collector,`date`";
}elseif ($porder=="`date`"){
  $p8=" style='border: 1 ridge #B4B4B4'";
  $pporder="`date`,station.id";
} 
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
if ($PI=="3"){ 
 if ($pcrit <> "ALL"){
  $sqlstr="SELECT count(0) FROM water INNER JOIN station ON water.id = station.id where station.id=" . $pcrit . " and  project_id=3 order by " . $pporder;
 }else{
  $sqlstr="SELECT count(0) FROM water INNER JOIN station ON water.id = station.id" . " where project_id=3 order by " . $pporder;
 } 
}elseif ($PI=="4"){
 if ($pcrit <> "ALL"){
  $sqlstr="SELECT count(0) FROM water INNER JOIN station ON water.id = station.id where station.id=" . $pcrit . " and  project_id=4 order by " . $pporder;
 }else{
  $sqlstr="SELECT count(0) FROM water INNER JOIN station ON water.id = station.id" . " where project_id=4 order by " . $pporder;
 } 
}elseif ($PI=="13"){
 if ($pcrit <> "ALL"){
  $sqlstr="SELECT count(0) FROM water INNER JOIN station ON water.id = station.id where station.id=" . $pcrit . " and  project_id=13 order by " . $pporder;
 }else{
  $sqlstr="SELECT count(0) FROM water INNER JOIN station ON water.id = station.id" . " where project_id=13 order by " . $pporder;
 } 
}elseif ($PI=="1"){
 if ($pcrit <> "ALL"){
  $sqlstr="SELECT count(0) FROM alage INNER JOIN station ON alage.id = station.id where station.id=" . $pcrit . " and  project_id=1 order by " . $pporder;
 }else{
  $sqlstr="SELECT count(0) FROM alage INNER JOIN station ON alage.id = station.id" . " where project_id=1 order by " . $pporder;
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
<center>
<table border=0 cellpadding=0 cellspacing=0><tr><td>
<form name="form1" action="WaterQ.php">
  <center><font size="4" color="#393939"><B><?php echo $ppcrit?> <?php echo $PIN?> Records</B></font>&nbsp;Total:<?php echo $sn_index?>
    <a href="LocalMapE.php?id=<?php echo $pcrit?>&pid=<?php echo $PI?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
  </center>
  <center><A HREF="WaterQ.php?page=1&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/first.gif" title="First Page"></a>&nbsp;    
  <?php if ($group > 0){ ?>                   
  <A HREF="WaterQ.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/previous10.gif" title="Previous 10 Page"></a>&nbsp;                                                    
   <?php }else{ ?>               
  <img border="0"  src="../images/previous10dis.gif" title="Previous 10 Page(disabled)">&nbsp;                                                    
   <?php } ?>                  
    <A HREF="WaterQ.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/previous.gif" title="Previous Page"></a>&nbsp;                                                    
<A HREF="WaterQ.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/next.gif" title="Next Page"></a>&nbsp;                                                     
   <?php if ($group < $pgroup){ ?>                  
<A HREF="WaterQ.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/next10.gif" title="Next 10 Page"></a>&nbsp;                                                     
   <?php }else{ ?>               
<img border="0"  src="../images/next10dis.gif" title="Next 10 Page(disabled)">&nbsp;                                                     
  <?php } ?>                 
  <A HREF="WaterQ.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/last.gif" title="Last Page"></a>&nbsp;&nbsp;          
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
echo "<A HREF='WaterQ.php?page=".$i."&R1=".$porder."&pz=".$pz. "&D1=".$pcrit."&PI=".$PI."'><font class=font16 color='".$icolor."'>".$ibold. $i. $ibold2."</a></font>&nbsp;";                                              
                                   
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

<table border="1" height="49" cellspacing="1" cellpadding="2">         
   <tr>         
    <td class=tdHead nowrap>ST<a href="WaterQ.php?page=<?php echo $page?>&R1=station.id&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p1?>></a></td>         
    <td class=tdHead nowrap>Locality<a href="WaterQ.php?page=<?php echo $page?>&R1=locality&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p2?>></a></td>         
    <td class=tdHead nowrap>Latitude<a href="WaterQ.php?page=<?php echo $page?>&R1=latitude&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p3?>></a></td>         
    <td class=tdHead nowrap>Longitude<a href="WaterQ.php?page=<?php echo $page?>&R1=longitude&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p4?>></a></td>      
    <td class=tdHead nowrap>Elevation<a href="WaterQ.php?page=<?php echo $page?>&R1=minimum_elevation&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p5?>></a></td>         
    <td class=tdHead nowrap>Depth<a href="WaterQ.php?page=<?php echo $page?>&R1=minimum_depth&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p6?>></a></td>      
    <td class=tdHead nowrap>Collector<a href="WaterQ.php?page=<?php echo $page?>&R1=collector&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p7?>></a></td>      
    <td class=tdHead nowrap>Date<a href="WaterQ.php?page=<?php echo $page?>&R1=`date`&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p8?>></a></td>      
    <td class=tdHead nowrap>Detail</font></td>      
    </tr>         
    
        <?php        
if ($PI=="3"){ 
 if ($pcrit <> "ALL"){
  $sqlstr="SELECT water.*, station.* FROM water INNER JOIN station ON water.id = station.id where station.id=" . $pcrit . " and  project_id=3 order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }else{
  $sqlstr="SELECT water.*, station.* FROM water INNER JOIN station ON water.id = station.id" . " where project_id=3 order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 } 
}elseif ($PI=="4"){
 if ($pcrit <> "ALL"){
  $sqlstr="SELECT water.*, station.* FROM water INNER JOIN station ON water.id = station.id where station.id=" . $pcrit . " and  project_id=4 order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }else{
  $sqlstr="SELECT water.*, station.* FROM water INNER JOIN station ON water.id = station.id" . " where project_id=4 order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 } 
}elseif ($PI=="13"){
 if ($pcrit <> "ALL"){
  $sqlstr="SELECT water.*, station.* FROM water INNER JOIN station ON water.id = station.id where station.id=" . $pcrit . " and  project_id=13 order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }else{
  $sqlstr="SELECT water.*, station.* FROM water INNER JOIN station ON water.id = station.id" . " where project_id=13 order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 } 
}elseif ($PI=="1"){
 if ($pcrit <> "ALL"){
  $sqlstr="SELECT alage.*, station.* FROM alage INNER JOIN station ON alage.id = station.id where station.id=" . $pcrit . " and  project_id=1 order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }else{
  $sqlstr="SELECT alage.*, station.* FROM alage INNER JOIN station ON alage.id = station.id" . " where project_id=1 order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
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
     echo "<td align='left' class=".$tdclass."><center>". $arr[$index]['id']."</td>";       
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['locality']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['latitude']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['longitude']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['minimum_elevation']."-".  $arr[$index]['maximum_elevation']."M</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['minimum_depth']."-".  $arr[$index]['maximum_depth']."M</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['collector']."</td>"; 
	 $pdate=strtotime($arr[$index]['date']);
	 $pdate=getdate($pdate);
	 if ($pdate['hours']==0 && $pdate['minutes']==0 && $pdate['seconds']==0){
	  $showdate=$pdate['year'] . "-" . substr(100+$pdate['mon'],1,2) . "-" .substr(100+$pdate['mday'],1,2);
	 }else{
	  $showdate=$arr[$index]['date'];
	 } 
  
     echo "<td align='left' class=".$tdclass.">". $showdate."</td>";   
     echo "<td align='left' class=".$tdclass."><a href='WaterQ2.php?record_id=". $arr[$index]['record_id']."&PI=". $PI."'><center><img border='0' src='../images/smallearth.gif' width='22' height='15'></a></td></tr>";   
    }; 
	}      
    ?>        
  </table>       
   <p style="margin-top: 3">       
    <A HREF="WaterQ.php?page=1&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/first.gif" title="First Page" align="absmiddle" hspace="3" vspace="1"></a>              
    <?php if ($group > 0){ ?>                       
  <A HREF="WaterQ.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/previous10.gif" title="Previous 10 Page" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <?php }else{ ?>                     
  <img border="0"  src="../images/previous10dis.gif" title="Previous 10 Page" align="absmiddle" hspace="3" vspace="1">                                    
   <?php } ?>                        
    <A HREF="WaterQ.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/previous.gif" title="Previous Page" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="WaterQ.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/next.gif" title="Next Page" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php if ($group < $pgroup){ ?>                   
<A HREF="WaterQ.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/next10.gif" title="Next 10 Page" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php }else{ ?>                     
<img border="0"  src="../images/next10dis.gif" title="Next 10 Page" align="absmiddle" hspace="3" vspace="1">                                     
  <?php } ?>                       
  <A HREF="WaterQ.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&PI=<?php echo $PI?>"><img border="0"  src="../images/last.gif" title="Last Page" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <input type="hidden" name="R1" value="<?php echo $porder?>">
 <input type="hidden" name="D1" value="<?php echo $pcrit?>">
 <input type="hidden" name="PI" value="<?php echo $PI?>">
</form>


  </center>


  </font>
</td></tr></table>
  
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>