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
 $_SESSION['item']=13;
include("left.php");
?>

</td></tr><tr height="1"><td></td></tr><tr><td width="100%" valign="top" align="center" height="100%">
  <!--Begin of webpage//--><!--Begin of webpage//-->   


</head>
<body topmargin="5">
<?php
include("../conn.php"); 
$porder=$_GET['R1'];
$pcrit=$_GET['D1'];
if ($pcrit==""){ $pcrit="ALL";}
if ($pcrit=="ALL"){
 $ppcrit="全部測站";
}else{
 $ppcrit="測站:" . $pcrit;    
} 
if ($porder==""){ $porder="id";}
if ($porder=="id"){ 
  $p1=" style='border: 1 ridge #B4B4B4'";
  $pporder="station.id,`date`";
}elseif ($porder=="locality_chinese"){ 
  $p2=" style='border: 1 ridge #B4B4B4'";
  $pporder="locality_chinese,`date`";
}elseif ($porder=="`date`"){
  $p3=" style='border: 1 ridge #B4B4B4'";
  $pporder="`date`,station.id";
}elseif ($porder=="air"){
  $p4=" style='border: 1 ridge #B4B4B4'";
  $pporder="air DESC";
}elseif ($porder=="water"){
  $p5=" style='border: 1 ridge #B4B4B4'";
  $pporder="water DESC";
}elseif ($porder=="soil_0cm"){
  $p6=" style='border: 1 ridge #B4B4B4'";
  $pporder="soil_0cm DESC";
}elseif ($porder=="soil_25cm"){
  $p7=" style='border: 1 ridge #B4B4B4'";
  $pporder="soil_25cm DESC";
}elseif ($porder=="soil_50cm"){
  $p8=" style='border: 1 ridge #B4B4B4'";
  $pporder="soil_50cm DESC";
}elseif ($porder=="soil_65cm"){
  $p9=" style='border: 1 ridge #B4B4B4'";
  $pporder="soil_65cm DESC";
}elseif ($porder=="soil_90cm"){
  $p10=" style='border: 1 ridge #B4B4B4'";
  $pporder="soil_90cm DESC";
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
 if ($pcrit != "ALL"){
  $sqlstr="SELECT count(0) FROM temperature INNER JOIN station ON temperature.id = station.id where station.id=" . $pcrit . "  order by " . $pporder;
 }else{
  $sqlstr="SELECT count(0) FROM temperature INNER JOIN station ON temperature.id = station.id order by " . $pporder;
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
<form name="form1" action="temperature.php"  style="margin-top:5px">
<table border=0 cellpadding=0 cellspacing=0><tr><td>
  <center><font size="3" color="#393939"><B><?php echo $ppcrit?>環境日均溫監測資料</B></font>&nbsp;共<?php echo $sn_index?>筆
    <a href="LocalMap.php?id=<?php echo $pcrit?>&pid=14"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
  </center>
  <center><A HREF="temperature.php?page=1&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/first.gif" title="第一頁"></a>&nbsp;    
  <?php if ($group > 0){ ?>                   
  <A HREF="temperature.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous10.gif" title="上10頁"></a>&nbsp;                                                    
   <?php }else{ ?>               
  <img border="0"  src="../images/previous10dis.gif" title="上10頁(失效)">&nbsp;                                                    
   <?php } ?>                  
    <A HREF="temperature.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous.gif" title="上一頁"></a>&nbsp;                                                    
<A HREF="temperature.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next.gif" title="下一頁"></a>&nbsp;                                                     
   <?php if ($group < $pgroup){ ?>                  
<A HREF="temperature.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next10.gif" title="下10頁"></a>&nbsp;                                                     
   <?php }else{ ?>               
<img border="0"  src="../images/next10dis.gif" title="下10頁(失效)">&nbsp;                                                     
  <?php } ?>                 
  <A HREF="temperature.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/last.gif" title="最後一頁"></a>&nbsp;&nbsp;          
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
echo "<A HREF='temperature.php?page=".$i."&R1=".$porder."&pz=".$pz. "&D1=".$pcrit."&PI=".$PI."'><font class=font16 color='".$icolor."'>".$ibold. $i. $ibold2."</a></font>&nbsp;";                                              
                                   
};                      
?>             
  &nbsp;<font class=font16>共<?php echo $pagecount?>頁&nbsp;&nbsp;每頁
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

  筆&nbsp;"&nbsp;</td>
     
    </tr>  
  </table>  
  <input type="hidden" name="page" value="<?php echo $page?>">         
<table border="1" height="49" cellspacing="1" cellpadding="2">         
   <tr>         
    <td class=tdHead nowrap>測站<a href="temperature.php?page=<?php echo $page?>&R1=id&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p1?>></a></td>         
    <td class=tdHead nowrap>測站站名<a href="temperature.php?page=<?php echo $page?>&R1=locality_chinese&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p2?>></a></td>         
    <td class=tdHead nowrap>調查日期<a href="temperature.php?page=<?php echo $page?>&R1=`date`&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p3?>></a></td>      
    <td class=tdHead nowrap>氣溫<a href="temperature.php?page=<?php echo $page?>&R1=air&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p4?>></a></td>         
    <td class=tdHead nowrap>水溫<a href="temperature.php?page=<?php echo $page?>&R1=water&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p5?>></a></td>      
    <td class=tdHead nowrap>土表溫<a href="temperature.php?page=<?php echo $page?>&R1=soil_0cm&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p6?>></a></td>         
    <td class=tdHead nowrap><font class=font11>土下25cm</font><a href="temperature.php?page=<?php echo $page?>&R1=soil_25cm&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p7?>></a></td>      
    <td class=tdHead nowrap><font class=font11>土下50cm</font><a href="temperature.php?page=<?php echo $page?>&R1=soil_50cm&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p8?>></a></td>      
    <td class=tdHead nowrap><font class=font11>土下65cm</font><a href="temperature.php?page=<?php echo $page?>&R1=soil_65cm&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p9?>></a></td>      
    <td class=tdHead nowrap><font class=font11>土下90cm</font><a href="temperature.php?page=<?php echo $page?>&R1=soil_90cm&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"></font><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p10?>></a></td>      
    <td class=tdHead nowrap>xml</td>      
    </tr>         
    
        <?php        
 if ($pcrit != "ALL"){
  $sqlstr="SELECT temperature.*, station.* FROM temperature INNER JOIN station ON temperature.id = station.id where station.id=" . $pcrit . "  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
 }else{
  $sqlstr="SELECT temperature.*, station.* FROM temperature INNER JOIN station ON temperature.id = station.id" . "  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
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
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['locality_chinese']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['date']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['air']."&nbsp;</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['water']."&nbsp;</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['soil_0cm']."&nbsp;</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['soil_25cm']."&nbsp;</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['soil_50cm']."&nbsp;</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['soil_65cm']."&nbsp;</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['soil_90cm']."&nbsp;</td>";   
     echo "<td align='left' class=".$tdclass."><a href='../xml_tem.php?record_id=". $arr[$index]['record_id']."'><img border='0' src='../images/xml.jpg' ></a></td></tr>";   
    }; 
	}      
    ?>        
  </table>       
   <p style="margin-top: 3">       
    <A HREF="temperature.php?page=1&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/first_2.gif" title="第一頁" align="absmiddle" hspace="3" vspace="1"></a>              
    <?php if ($group > 0){ ?>                       
  <A HREF="temperature.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous10_2.gif" title="上10頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <?php }else{ ?>                     
  <img border="0"  src="../images/previous10dis_2.gif" title="上10頁" align="absmiddle" hspace="3" vspace="1">                                    
   <?php } ?>                        
    <A HREF="temperature.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous_2.gif" title="上一頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="temperature.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next_2.gif" title="下一頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php if ($group < $pgroup){ ?>                   
<A HREF="temperature.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next10_2.gif" title="下10頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php }else{ ?>                     
<img border="0"  src="../images/next10dis_2.gif" title="下10頁" align="absmiddle" hspace="3" vspace="1">                                     
  <?php } ?>                       
  <A HREF="temperature.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>"><img border="0"  src="../images/last_2.gif" title="最後一頁" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <input type="hidden" name="R1" value="<?php echo $porder?>">
 <input type="hidden" name="D1" value="<?php echo $pcrit?>">
</form>


  </center>


  </td></tr></table>
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>