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
$_SESSION['item']="5";
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
<Script Language="JavaScript">
<!--
function clean()
{
if (document.form1.search.value=="Key Words"){document.form1.search.value=""}
}
//-->
</script>


<?php    
include("../conn.php");       
$porder=$_GET['R1'];
$pcrit=$_GET['D1'];
if ($porder==""){ $porder="phylum_c";}
if ($porder=="phylum"){ 
  $pporder="phylum,`class`,`order`,family";
  $porderch="門名";
  $p1=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="`class`"){ 
 $pporder="`class`,`order`,family";
 $porderch="綱名";
  $p3=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="`order`"){
 $pporder="`order`,family";
 $porderch="目名";
  $p5=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="family"){
 $pporder="family";
 $porderch="科名";
  $p7=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="phylum_c"){
 $pporder="phylum_c,class_c,order_c,family_c";
 $porderch="門中文名";
  $p2=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="class_c"){
 $pporder="class_c,order_c,family_c";
 $porderch="綱中文名";
  $p4=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="order_c"){
 $pporder="order_c,family_c";
 $porderch="目中文名";
  $p6=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="family_c"){
 $pporder="family_c";
 $porderch="科中文名";
  $p8=" style='border: 1 ridge #B4B4B4'";
}elseif ($porder=="total"){
 $pporder="total";
 $porderch="筆數";
  $p9=" style='border: 1 ridge #B4B4B4'";
}  
if ($pcrit==""){ $pcrit="Plantae";}
if ($pcrit=="Animalia"){ $ch1="selected";}
if ($pcrit=="Plantae"){ $ch2="selected";}
if ($pcrit=="Fungi"){ $ch3="selected";}
if ($pcrit=="Protista"){ $ch4="selected";}
if ($pcrit=="Monera"){ $ch5="selected";}
if ($pcrit=="all"){ $ch6="selected";}
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
$key=$_GET['search'];
if ($key=="Key Words"){ $key="";}
if ($key==""){
 $sqlstr="SELECT count(0) from view_wlfamily order by " . $pporder;
}else{
 $sqlstr="SELECT count(0) from view_wlfamily where phylum_c like '%" . $key . "%' or phylum like '%" . $key . "%' or class_c like '%" . $key . "%' or `class` like '%" . $key . "%' or order_c like '%" . $key . "%' or `order` like '%" . $key . "%' or family_c like '%" . $key . "%' or family like '%" . $key . "%' order by " . $pporder;
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
<table border=0 cellpadding=0 cellspacing=0 width=95%><tr><td>
<form name="form1" action="FamilyList.php">
  <center>
  <?php if ($key==""){?>
  <font size="4" color="#393939"><B><?php echo $sn_index?> Familys Organism in All Stations</B></font>&nbsp;&nbsp;&nbsp;
  <?php }else{?>
  <font size="4" color="#393939"><B><?php echo $sn_index?> Records for Key Word:『<?php echo $key?>』</font>&nbsp;&nbsp;&nbsp;
  <?php }?>
  <input type="text" onclick=clean() name="search" size="11" value="Key Words" style="color: #666666"><input type="submit" value="FIND" name="sent" style="font-size: 7pt; position: relative; width: 40; height: 25; left: 1; top: 0; letter-spacing: 1">
  <center><A HREF="familylist.php?page=1&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/first.gif" title="First Page"></a>&nbsp; 
  <?php if ($group > 0){ ?>                   
  <A HREF="familylist.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/previous10.gif" title="Previous 10 Page"></a>&nbsp;                                                    
   <?php }else{ ?>               
  <img border="0"  src="../images/previous10dis.gif" title="Previous 10 Page(失效)">&nbsp;                                                    
   <?php } ?>                  
    <A HREF="familylist.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/previous.gif" title="Previous Page"></a>&nbsp;                                                    
<A HREF="familylist.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/next.gif" title="Next Page"></a>&nbsp;                                                     
   <?php if ($group < $pgroup){ ?>                  
<A HREF="familylist.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/next10.gif" title="Next 10 Page"></a>&nbsp;                                                     
   <?php }else{ ?>               
<img border="0"  src="../images/next10dis.gif" title="Next 10 Page(失效)">&nbsp;                                                     
  <?php } ?>                 
  <A HREF="familylist.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/last.gif" title="Last Page"></a>&nbsp;&nbsp;          
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
echo "<A HREF='familylist.php?page=".$i."&R1=".$porder."&search=". urlencode($key)."&pz=".$pz. "&D1=".$pcrit."'><font class=font16 color='".$icolor."'>".$ibold. $i. $ibold2."</a></font>&nbsp;";                                              
                                   
};                      
?>             
  &nbsp;<font class=font16><?php echo $pagecount?>Pages&nbsp;&nbsp;Page size:
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
<center><table border="1" height="49" cellspacing="1" cellpadding="2" width="90%">         
   <tr>         
    <td class=tdHead nowrap>Kingdom<a href="familylist.php?page=<?php echo page?>&R1=kingdom&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p2?>></a></font></td>         
    <td class=tdHead nowrap>Phylum<a href="familylist.php?page=<?php echo page?>&R1=phylum&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p1?>></a></font></td>         
    <td class=tdHead nowrap>Class<a href="familylist.php?page=<?php echo page?>&R1=`class`&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p3?>></a></font></td>         
    <td class=tdHead nowrap>Order<a href="familylist.php?page=<?php echo page?>&R1=`order`&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p5?>></a></font></td>      
    <td class=tdHead nowrap>Family<a href="familylist.php?page=<?php echo page?>&R1=family&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p7?>></a></font></td>      
    <td class=tdHead nowrap>Total<a href="familylist.php?page=<?php echo page?>&R1=total&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" title="sort" <?php echo p9?>></a></font></td>      
    </tr>         
<?php 
if ($key==""){
 $sqlstr="SELECT * from view_wlfamily order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
}else{
 $sqlstr="SELECT * from view_wlfamily where phylum_c like '%" . $key . "%' or phylum like '%" . $key . "%' or class_c like '%" . $key . "%' or `class` like '%" . $key . "%' or order_c like '%" . $key . "%' or `order` like '%" . $key . "%' or family_c like '%" . $key . "%' or family like '%" . $key . "%' order by " . $pporder. " LIMIT ". ($page-1)*$pz . ", ". $pz;
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
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['kingdom']."</td>";       
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['phylum']."</td>";       
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['class']."</td>";   
     echo "<td align='left' class=".$tdclass.">". $arr[$index]['order']."</td>";   
     echo "<td align='left' class=".$tdclass."><a href='specieslist2.php?fa=". $arr[$index]['family']."'>".$arr[$index]['family']."</a></td>";   
     echo "<td align='left' class=".$tdclass."><a href='specieslist2.php?fa=". $arr[$index]['family']."'><center>".$arr[$index]['total']."</a></td></tr>";
    }; 
	}      
    ?>  
  </table>       
   <p style="margin-top: 3">       
    <A HREF="familylist.php?page=1&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/first.gif" title="First Page" align="absmiddle" hspace="3" vspace="1"></a> <?php if ($group > 0){ ?>                       
  <A HREF="familylist.php?page=<?php echo ($page-10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/previous10.gif" title="Previous 10 Page" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <?php }else{ ?>                     
  <img border="0"  src="../images/previous10dis.gif" title="Previous 10 Page" align="absmiddle" hspace="3" vspace="1">                                    
   <?php } ?>                        
    <A HREF="taibnet_species_list.php?page=<?php echo ($page-1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/previous.gif" title="Previous Page" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="familylist.php?page=<?php echo ($page+1)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/next.gif" title="Next Page" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php if ($group < $pgroup){ ?>                   
<A HREF="familylist.php?page=<?php echo ($page+10)?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/next10.gif" title="Next 10 Page" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <?php }else{ ?>                     
<img border="0"  src="../images/next10dis.gif" title="Next 10 Page" align="absmiddle" hspace="3" vspace="1">                                     
  <?php } ?>                       
  <A HREF="familylist.php?page=<?php echo $pagecount?>&R1=<?php echo $porder?>&D1=<?php echo $pcrit?>&pz=<?php echo $pz?>&search=<?php echo $key?>"><img border="0"  src="../images/last.gif" title="Last Page" align="absmiddle" hspace="3" vspace="1"></a>              
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