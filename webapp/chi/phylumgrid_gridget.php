<?php
ini_set("memory_limit","48M");
if ( stristr($_SERVER["HTTP_ACCEPT"],"application/xhtml+xml") ) {
		header("Content-type: application/xhtml+xml"); } else {
	header("Content-type: text/xml");
}

function phpescape($string, $in_encoding = 'UTF-8',$out_encoding = 'UCS-2') { 
    $return = ''; 
    if (function_exists('mb_get_info')) { 
        for($x = 0; $x < mb_strlen ( $string, $in_encoding ); $x ++) { 
            $str = mb_substr ( $string, $x, 1, $in_encoding ); 
            if (strlen ( $str ) > 1) { // 多字节字符 
                $return .= '%u' . strtoupper ( bin2hex ( mb_convert_encoding ( $str, $out_encoding, $in_encoding ) ) ); 
            } else { 
                $return .= '%' . strtoupper ( bin2hex ( $str ) ); 
            } 
        } 
    } 
    return $return; 
}



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
echo("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"); 
include("../conn_clean.php");

   if ($_GET["cr_mask"]=="equal"){
   	 if ($_GET["sc_mask"]=='auto_id'){
     $qb=" =";
	 $qe="";
	 }else{
     $qb=" ='";
	 $qe="'";
	 }
    }else if ($_GET["cr_mask"]=="contain"){
     $qb=" like '%";
	 $qe="%'";
	}else{
     $qb=" like '";
	 $qe="%'";
	} 	 

	//$_GET['posStart'];
	if(isset($_GET["posStart"]))
		$posStart = $_GET['posStart'];
	else
		$posStart = 0;
	if(isset($_GET["count"]))
		$count = $_GET['count'];
	else
		$count = 50;
	if(isset($_GET["sc_mask"]))
		$sc_mask = uniDecode($_GET['sc_mask'], 'utf8');
	else
		$sc_mask = "";
	if(isset($_GET["fa_mask"]))
		$fa_mask = uniDecode($_GET['fa_mask'], 'utf8');
	else
		$fa_mask = "";
	
	//$_GET['count'];
	
	
    if (!isset($_GET["orderBy"]) || $_GET["orderBy"]=="undefined")$_GET["orderBy"]="0";
    if (!isset($_GET["direction"]) || $_GET["direction"]=="asc" || $_GET["direction"]=="undefined")
      $_GET["direction"]="ASC";
     else
      $_GET["direction"]="DESC";
	  
 $sqlstr="SELECT * from view_wlphylum limit 0,1";    
 $result=mysql_query($sqlstr); 
 $arr=mysql_fetch_array($result,MYSQL_ASSOC);
 $fields=array();
 	 while (list($key) = each($arr)){ 
	   if ( $key!="id" ){
	  array_push($fields,$key);
	   }   
	 } 
    getDataFromDB('','',$fields[$_GET["orderBy"]],$_GET["direction"],$qb,$qe);
	//mysql_close($link);
	
	
	//print one level of the tree, based on parent_id
function getDataFromDB($name_mask,$code_mask,$sort_by,$sort_dir,$qb,$qe){
		GLOBAL $posStart,$count,$sc_mask,$fa_mask;
		$sql="SELECT * from view_wlphylum Where 1=1";
		if($sc_mask!='' && $fa_mask!='')
			$sql.= " and ".$sc_mask .$qb .$fa_mask.$qe;
		if($sort_dir=='')
			$sort_dir = "asc";
		if($sort_by!='')
			$sql.= " Order By `".$sort_by."` ". $sort_dir;
		//print($sql);
		//echo $sql;
		if($posStart==0){
			$sqlCount = "Select count(*) as cnt from ($sql) as tbl";
			//print($sqlCount);
			$resCount = mysql_query ($sqlCount);
			while($rowCount=mysql_fetch_array($resCount)){
				$totalCount = $rowCount["cnt"];
			}
		}
		$sql.= " LIMIT ".$posStart.",".$count;
		$res = mysql_query ($sql);
		print("<rows total_count='".$totalCount."' pos='".$posStart."'>");
		if($res){
			while($row=mysql_fetch_array($res,MYSQL_NUM)){
			       $num=count($row);
	               print("<row id='".$row[0]."'>");
				   for ($i=1 ; $i < $num; $i++){
				    print("<cell><![CDATA[&nbsp;&nbsp;".$row[$i]."]]></cell>");
				   };
	               print("<cell><![CDATA[<a href='recordgrid.php?phylum=". $row[4]."'><img border='0' src='../images/smallearth.gif' height='10'></a>]]></cell>");	
	               print("<cell><![CDATA[<a href='locamap.php?pfield=phylum&pcr=equal&pvalue=". $row[4]."&ch=".phpescape($row[3])."'><img border='0' src='../images/smallearth.gif' height='10'></a>]]></cell>");				
				print("</row>");
				$posStart++;
			}
		}else{
			echo mysql_errno().": ".mysql_error()." at ".__LINE__." line in ".__FILE__. " file<br>";
		}
		print("</rows>");
		
	}
?>