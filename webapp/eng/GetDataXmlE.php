<?php
include("../conn_clean.php");
$id=$_GET['id'];
$pid=$_GET['pid'];
$sc=$_GET['sc'];
$fa=$_GET['fa'];
$por=$_GET['or'];
$cl=$_GET['cl'];
if ($fa=="" && $por=="" && $cl==""){
	if ($sc=="" || $sc=="0"){
		if ($pid=="" || $pid=="0"){
			if ($id=="" || $id=="0"){
			 $sqlstr="SELECT *  FROM station   where (not latitude is null) and id < 12 order by latitude,longitude"; 
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
	 $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN View_main ON station.id = View_main.id where  (not latitude is null) and `order`='".$por."'"; 
  }elseif ($cl != ""){
	 $sqlstr="SELECT distinct station.id,latitude,longitude,locality FROM station INNER JOIN View_main ON station.id = View_main.id where  (not latitude is null) and `class`='".$cl."'"; 
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