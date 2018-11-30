<?php
include("../conn_clean.php");
function uniDecode($str,$charcode){  
$text = preg_replace_callback("/%u[0-9A-Za-z]{4}/",toUtf8,$str);  
return mb_convert_encoding($text, $charcode, 'utf-8');
}
function toUtf8($ar)
{  
foreach($ar as $val){    
$val = intval(substr($val,2),16);    
if($val < 0x7F){        // 0000-007F        
$c .= chr($val);    
}elseif($val < 0x800) { // 0080-0800       
 $c .= chr(0xC0 | ($val / 64));        
 $c .= chr(0x80 | ($val % 64));    
 }else{                // 0800-FFFF        
 $c .= chr(0xE0 | (($val / 64) / 64));        
 $c .= chr(0x80 | (($val / 64) % 64));        
 $c .= chr(0x80 | ($val % 64));   
  }  }  
  return $c;
  }
$id=$_GET['id'];
$pid=$_GET['pid'];
$sc=$_GET['sc'];
$fa=$_GET['fa'];
$por=$_GET['or'];
$cl=$_GET['cl'];
if ($_GET['pfield']!=""){ 
   if ($_GET["pcr"]=="equal"){
   	 if ($_GET["pfield"]=='sid' || $_GET["pfield"]=='record_id' ){
     $qb=" =";
	 $qe="";
	 }else{
     $qb=" ='";
	 $qe="'";
	 }
    }else if ($_GET["pcr"]=="contain"){
     $qb=" like '%";
	 $qe="%'";
	}else{
     $qb=" like '";
	 $qe="%'";
	} 	    
 $sqlstr="SELECT *,locality_chinese as locality,sid as id FROM table_forgrid where `".$_GET['pfield']."` ".$qb.uniDecode($_GET['pvalue'], 'utf8'). $qe ." order by latitude,longitude";
}elseif ($fa=="" && $por=="" && $cl==""){
	if ($sc=="" || $sc=="0"){
		if ($pid=="" || $pid=="0"){
			if ($id=="" || $id=="0"){
			 $sqlstr="SELECT *  FROM station   where (not latitude is null) and id < 14 order by latitude,longitude"; 
			}elseif ($id == "ALL"){
			 $sqlstr="SELECT *  FROM station   where (not latitude is null) order by latitude,longitude"; 
			}else{
			 $sqlstr="SELECT *  FROM station   where (not latitude is null) and id =".$id." order by latitude,longitude"; 
			}
		}else{
		  if ($id=="ALL"){
		   if (($pid=="3" || $pid=="4" || $pid=="13")){
		    $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN water ON station.id = water.id where (not latitude is null) and project_id=".$pid;
		   }elseif ($pid=="1"){
		    $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN alage ON station.id = alage.id where (not latitude is null) and project_id=".$pid;
		   }elseif ($pid=="14"){
		    $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN temperature ON station.id = temperature.id where (not latitude is null) and project_id=".$pid;
		   }else{
		     $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN main ON station.id = main.id where (not latitude is null)"; 
		   }
		  }else{
			$sqlstr="SELECT *  FROM station   where (not latitude is null) and id =".$id." order by latitude,longitude"; 
		  }
		}
	}else{
	    $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN main ON station.id = main.id where  (not latitude is null) and scientific_name='".$sc."'"; 
	} 

}else{
  if ($fa != ""){
	 $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN main ON station.id = main.id where  (not latitude is null) and family='".$fa."'"; 
  }elseif ($por != ""){
	 $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN View_main ON station.id = View_main.stid where  (not latitude is null) and `order`='".$por."'"; 
  }elseif ($cl != ""){
	 $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN View_main ON station.id = View_main.stid where  (not latitude is null) and `class`='".$cl."'"; 
  }
}	
header('Content-Type: text/xml;charset=UTF-8');
echo "<markers>";  	
 $result=mysql_query($sqlstr,$link_ID);
  $result=mysql_query($sqlstr,$link_ID);  
  if ($result !="") {
  $sn2_index=mysql_num_rows($result); 
  $plat="";
  $plong="";
  for ($index=0; $index < $sn2_index ; $index++){
     $arr[$index]=mysql_fetch_array($result);                
   if ($arr[$index]['latitude']!= $plat || $arr[$index]['longitude'] !=$plong){
    echo "<marker lat='".$arr[$index]['latitude']."' lng='".$arr[$index]['longitude']."' id='".$arr[$index]['id']."' loca='".$arr[$index]['locality']."' />";  
   }	
   $plat=$arr[$index]['latitude'];
   $plong=$arr[$index]['longitude'];
 };
 }
echo "</markers>";
mysql_close();
?>