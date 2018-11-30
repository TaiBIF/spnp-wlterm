<!--
<?php
include("../function_redirect.php");
$sc=$_GET['sc'];
if ($sc!=""){$ptitle=$_GET['ch']."&nbsp;".$sc;}
$fa=$_GET['fa'];  
if ($fa !=""){$ptitle=$_GET['ch']."&nbsp;".$fa;}
$cl=$_GET['cl'];  
if ($cl !=""){$ptitle=$_GET['ch']."&nbsp;".$cl;}
$por=$_GET['or'];  
if ($por !=""){$ptitle=$_GET['ch']."&nbsp;".$por;}
$ph=$_GET['ph'];  
if ($ph !=""){$ptitle=$_GET['ch']."&nbsp;".$ph;}
$porder=$_GET['R1'];
$id=$_GET['id'];

if ($fa=="" && $cl=="" && $por=="" && substr($id,0,2)=="W_"){
  $redi="http://wlterm.biodiv.sinica.edu.tw/chi/data_detail.php?id=". $id;
  redirect($redi,301);
} 
?>
//--> 
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

<tr><td valign="top" width="100%" align="center" height="52" >
<?php  
include("left.php");
?>
</td></tr><tr height="5"><td></td></tr><tr><td width="95%" valign="top" align="center">
  <!--Begin of webpage//--><!--Begin of webpage//-->   

<?php 
include("../conn.php"); 
if ($porder==""){$porder="date";}
$pporder=$porder;
if ($porder=="scientific_name"){ 
  $p1=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="family"){ 
  $p0=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="date"){ 
  $p2=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="locality_chinese"){
  $p3=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="latitude"){
  $p4=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="longitude"){
  $p5=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="minimum_depth"){
  $p6=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="collector_chinese"){
  $p7=" style='border: 1 ridge #B4B4B4'";
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
}elseif ($pz ==25){
 $s25="selected";
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
if ($fa=="" && $cl=="" && $por=="" && $ph==""){
	if ($sc!=""){
	 $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id where scientific_name='" . $sc . "' order by " . $pporder;
	}elseif (substr($id,0,2)=="PP"){
	 $sqlstr="SELECT count(0) FROM (main INNER JOIN station ON main.id = station.id) INNER JOIN project ON station.P_ID = project.project_id where project_id='" . substr($id,2,strlen($id)-2) . "'";
	}else{
	 $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id where main.id ='" .$id . "'  order by " . $pporder;
	}
}else{
  if ($fa != ""){
   $sqlstr="SELECT count(0) FROM main INNER JOIN station ON main.id = station.id where family='" . $fa . "'  order by " . $pporder;
  }elseif ($por != ""){
   $sqlstr="SELECT count(0) FROM View_main INNER JOIN station ON View_main.stid = station.id where `order`='" . $por . "'  order by " . $pporder;
  }elseif ($cl != ""){
   $sqlstr="SELECT count(0) FROM View_main INNER JOIN station ON View_main.stid = station.id where `class`='" . $cl . "'  order by " . $pporder;
  }elseif ($ph != ""){
   $sqlstr="SELECT count(0) FROM View_main INNER JOIN station ON View_main.stid = station.id where `phylum`='" . $ph . "'  order by " . $pporder;
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
<table border="0" cellpadding="0" cellspacing="0" width="95%"><tr><td valign="top">
 <form name="form1" action="specieslist2.php">
<center>
  <font size="3">
  <?php if ($sc!="" || $fa!="" || $por!="" || $cl != "" || $ph != ""){ ?>
  <?php echo $ptitle?>&nbsp;調查資料共&nbsp;<?php echo $sn_index?>&nbsp;筆&nbsp;
  <?php if ($sc!=""){?> 
  <a href="LocalMap.php?id=0&pid=99&sc=<?php echo $sc?>&ch=<?php echo $_GET['ch']?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
  <?php }elseif ($fa!=""){?>
  <a href="LocalMap.php?id=0&pid=99&fa=<?php echo $fa?>&ch=<?php echo $_GET['ch']?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
  <?php }elseif ($por!=""){?>
  <a href="LocalMap.php?id=0&pid=99&or=<?php echo $por?>&ch=<?php echo $_GET['ch']?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
  <?php }elseif ($cl!=""){?>
  <a href="LocalMap.php?id=0&pid=99&cl=<?php echo $cl?>&ph=<?php echo $ph?>&ch=<?php echo $_GET['ch']?>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>
  <?php }?>
  <?php }?>
  <center>
  <center><A HREF="specieslist2.php?page=1&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/first.gif" title="第一頁"></a>&nbsp;    
  <?php if ($group > 0){ ?>                   
  <A HREF="specieslist2.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous10.gif" title="上10頁"></a>&nbsp;                                                    
   <?php }else{ ?>               
  <img border="0"  src="../images/previous10dis.gif" title="上10頁(失效)">&nbsp;                                                    
   <?php } ?>                  
    <A HREF="specieslist2.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous.gif" title="上一頁"></a>&nbsp;                                                    
<A HREF="specieslist2.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next.gif" title="下一頁"></a>&nbsp;                                                     
   <?php if ($group < $pgroup){ ?>                  
<A HREF="specieslist2.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next10.gif" title="下10頁"></a>&nbsp;                                                     
   <?php }else{ ?>               
<img border="0"  src="../images/next10dis.gif" title="下10頁(失效)">&nbsp;                                                     
  <?php } ?>                 
  <A HREF="specieslist2.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/last.gif" title="最後一頁"></a>&nbsp;&nbsp;          
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
echo "<A HREF='specieslist2.php?page=".$i."&R1=".$porder."&sc=".$sc. "&fa=".$fa."&or=".$or."&cl=".$cl."&pz=".$pz."&c1=".$c1."'><font class=font16 color='".$icolor."'>".$ibold. $i. $ibold2."</a></font>&nbsp;";                                              
                                   
};                      
?>             
  &nbsp;<font class=font16>共<?php echo $pagecount?>頁&nbsp;&nbsp;每頁
    <select name="pz" id="select"  style="font-size: 11px" onChange=submit()>
  	<option value="10"  <?php echo $s15?>>10</option>
  	<option value="15"  <?php echo $s15?>>15</option>
  	<option value="20"  <?php echo $s20?>>20</option>
  	<option value="25"  <?php echo $s25?>>25</option>
	<option value="30" <?php echo $s30?>>30</option>
	<option value="50" <?php echo $s50?>>50</option>
	<option value="100" <?php echo $s100?>>100</option>
	<option value="200" <?php echo $s200?>>200</option>
	<option value="500" <?php echo $s500?>>500</option>
  </select>

  筆&nbsp;&nbsp;</font>
  </td>
     
    </tr>  
  </table>  
  <input type="hidden" name="page" value="<?php echo $page?>">                 
<table border="1" height="49" cellspacing="1" cellpadding="2" width=95%>         
   <tr> 
    <td class=tdHead nowrap>科名<a href="specieslist2.php?id=<?php echo id?>&R1=family&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p0?>></a></font></td>         
    <td class=tdHead nowrap>學名<a href="specieslist2.php?id=<?php echo id?>&R1=scientific_name&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p1?>></a></font></td>         
    <td class=tdHead nowrap>日期<a href="specieslist2.php?id=<?php echo id?>&R1=date&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p2?>></a></font></td>         
    <td class=tdHead nowrap>地點<a href="specieslist2.php?id=<?php echo id?>&R1=locality_chinese&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p3?>></a></font></td>         
    <td class=tdHead nowrap>緯度<a href="specieslist2.php?id=<?php echo id?>&R1=latitude&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p4?>></a></font></td>         
    <td class=tdHead nowrap>經度<a href="specieslist2.php?id=<?php echo id?>&R1=longitude&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p5?>></a></font></td>         
    <td class=tdHead nowrap>深度<a href="specieslist2.php?id=<?php echo id?>&R1=minimum_depth&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p6?>></a></font></td>      
    <td class=tdHead nowrap>調查者<a href="specieslist2.php?id=<?php echo id?>&R1=collector_chinese&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="排序" <?php echo $p7?>></a></font></td>      
    <td class=tdHead nowrap>內容</font></td>      
    </tr>         
    
<?php 
if ($fa=="" && $cl=="" && $por==""  && $ph==""){
	if ($sc!=""){
	 $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id where scientific_name='" . $sc . "' order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
	}elseif (substr($id,0,2)=="PP"){
	 $sqlstr="SELECT * FROM (main INNER JOIN station ON main.id = station.id) INNER JOIN project ON station.P_ID = project.project_id where project_id='" . substr($id,2,strlen($id)-2) . "'". " LIMIT ". ($page-1)*$pz . ", ". $pz;
	}else{
	 $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id where main.id ='" .$id . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
	}
}else{
  if ($fa != ""){
   $sqlstr="SELECT main.*, station.* FROM main INNER JOIN station ON main.id = station.id where family='" . $fa . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
  }elseif ($por != ""){
   $sqlstr="SELECT View_main.*, station.* FROM View_main INNER JOIN station ON View_main.stid = station.id where `order`='" . $por . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
  }elseif ($cl != ""){
   $sqlstr="SELECT View_main.*, station.* FROM View_main INNER JOIN station ON View_main.stid = station.id where `class`='" . $cl . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
  }elseif ($ph != ""){
   $sqlstr="SELECT View_main.*, station.* FROM View_main INNER JOIN station ON View_main.stid = station.id where `phylum`='" . $ph . "'  order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
  }
}	
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
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['date']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['locality_chinese']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['latitude']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['longitude']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['minimum_depth']."-".$arr[$index]['maximum_depth']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['collector_chinese']."</td>";   
     $plink="data_detail.php?record_id=" . $arr[$index]['record_id'];
     echo "<td align='left' class=".$tdclass."><a href='". $plink."'><center><img border='0' src='../images/smallearth.gif' width='22' height='15' align='center'></font></a></td></tr>";     }; 
	}      
    ?>        
   </table>      
   <p style="margin-top: 3">       
 <font face="新細明體" size="2" color="#800000">      
    <A HREF="specieslist2.php?page=1&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/first_2.gif" title="第一頁" align="absmiddle" hspace="3" vspace="1"></a>              
    <?php if ($group > 0){ ?>                       
  <A HREF="specieslist2.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous10_2.gif" title="上10頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <?php }else{ ?>                     
  <img border="0"  src="../images/previous10dis_2.gif" title="上10頁" align="absmiddle" hspace="3" vspace="1">                                    
   <?php } ?>                        
    <A HREF="specieslist2.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/previous_2.gif" title="上一頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="specieslist2.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next_2.gif" title="下一頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php if ($group < $pgroup){ ?>                   
<A HREF="specieslist2.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/next10_2.gif" title="下10頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php }else{ ?>                     
<img border="0"  src="../images/next10dis_2.gif" title="下10頁" align="absmiddle" hspace="3" vspace="1">                                     
  <?php } ?>                       
  <A HREF="specieslist2.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&sc=<?php echo $sc?>&fa=<?php echo $fa?>&or=<?php echo $por?>&cl=<?php echo $cl?>&ph=<?php echo $ph?>&pz=<?php echo $pz?>"><img border="0"  src="../images/last_2.gif" title="最後一頁" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <input type="hidden" name="R1" value="<?php echo $porder?>">
 <input type="hidden" name="sc" value="<?php echo $sc?>">
 <input type="hidden" name="fa" value="<?php echo $fa?>">
 <input type="hidden" name="or" value="<?php echo $por?>">
 <input type="hidden" name="cl" value="<?php echo $cl?>">
 <input type="hidden" name="ph" value="<?php echo $ph?>">
 <input type="hidden" name="PI" value="<?php echo $pI?>">

</form>
       
    


  </font>
</td></tr></table>
  <!--End of webpage//--><!--End of webpage//-->         
</td></tr></table>  
                                                                     
</body>
</html>