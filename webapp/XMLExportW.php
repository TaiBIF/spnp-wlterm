<?php
header('Content-Type: text/html;charset=UTF-8');
include("conn.php"); 
set_time_limit(600);
ini_set("memory_limit","24M");
  $pnow=getdate();
  $ppnow=$pnow['year'] . "-" . $pnow['mon'] . "-" .$pnow['mday'];
  $sqlstr="SELECT count(0) FROM (water INNER JOIN project ON water.Project_id = project.Project_id) INNER JOIN station ON water.id = station.id";
  $result=mysql_query($sqlstr,$link_ID);
  $datas=mysql_fetch_row($result); 
  $sn_index=$datas[0];
  $groups=intval(($sn_index-1)/1000)+1;
  for ($group=0; $group < $groups;$group++){
    $sqlstr="SELECT water.*, station.*, project.* FROM (water INNER JOIN project ON water.Project_id = project.Project_id) INNER JOIN station ON water.id = station.id  LIMIT ". $group*1000 . ",1000";
    $result=mysql_query($sqlstr,$link_ID);
    $sn_index=mysql_num_rows($result);  
    for ($index=0; $index < $sn_index ; $index++){
     $arr[$index]=mysql_fetch_array($result); 
     $filename="d:/wlterm/xml2/WLTERMWQ" . $arr[$index]['record_id'] . ".xml";
     $fp = fopen($filename, 'w');
	 fwrite($fp, "<?xml version='1.0' encoding='utf-8'?>");
	 
	 fwrite($fp, "<SimpleDarwinRecordSet");
     fwrite($fp, " xmlns='http://rs.tdwg.org/dwc/xsd/simpledarwincore/'");
      fwrite($fp, " xmlns:dc='http://purl.org/dc/terms/'");
       fwrite($fp, " xmlns:dwc='http://rs.tdwg.org/dwc/terms/'");
       fwrite($fp, " xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'");
       fwrite($fp, " xsi:schemaLocation='http://rs.tdwg.org/dwc/xsd/simpledarwincore/ http://rs.tdwg.org/dwc/xsd/tdwg_dwc_simple.xsd'>");
       fwrite($fp, "<SimpleDarwinRecord>");
fwrite($fp, "<dc:modified>".$ppnow."</dc:modified>");
fwrite($fp, "<dwc:occurrenceID>urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:WQ" . $arr[$index]['record_id']."</dwc:occurrenceID>");
fwrite($fp, "<dwc:catalogNumber>".$arr[$index]['record_id']."</dwc:catalogNumber>");
         fwrite($fp, "<dwc:basisOfRecord>O</dwc:basisOfRecord>");
         fwrite($fp,"<dwc:recordedBy>".htmlspecialchars($arr[$index]['collector']) ."</dwc:recordedBy>");
         fwrite($fp,"<recordedByInChinese>".htmlspecialchars($arr[$index]['collector_chinese']) ."</recordedByInChinese>");
		 $pdate=strtotime($arr[$index]['date']);
		 $pdate=getdate($pdate);
		 if ($pdate['hours']==0 && $pdate['minutes']==0 && $pdate['seconds']==0){
		  $showdate=$pdate['year'] . "-" . substr(100+$pdate['mon'],1,2) . "-" .substr(100+$pdate['mday'],1,2);
		 }else{
		  $showdate=$arr[$index]['date'];
		 } 
          fwrite($fp,"<dwc:eventDate>".$showdate."</dwc:eventDate>");
		 $pdate=strtotime($arr[$index]['date_end']);
		 $pdate=getdate($pdate);
		 if ($pdate['hours']==0 && $pdate['minutes']==0 && $pdate['seconds']==0){
		  $showdate=$pdate['year'] . "-" . substr(100+$pdate['mon'],1,2) . "-" .substr(100+$pdate['mday'],1,2);
		 }else{
		  $showdate=$arr[$index]['date_end'];
		 } 
          fwrite($fp,"<eventDateEnd>".$showdate."</eventDateEnd>");
         fwrite($fp,"<dwc:locality>".htmlspecialchars($arr[$index]['locality']) ."</dwc:locality>");
         fwrite($fp,"<localityInChinese>".htmlspecialchars($arr[$index]['locality_chinese']) ."</localityInChinese>");
         fwrite($fp,"<dwc:decimalLongitude>".$arr[$index]['longitude'] ."</dwc:decimalLongitude>");
         fwrite($fp,"<dwc:decimalLatitude>".$arr[$index]['latitude'] ."</dwc:decimalLatitude>");
         fwrite($fp,"<dwc:coordinateUncertaintyInMeters>".$arr[$index]['coordinate_precision'] ."</dwc:coordinateUncertaintyInMeters>");
         fwrite($fp,"<dwc:minimumElevationInMeters>".$arr[$index]['minimum_elevation'] ."</dwc:minimumElevationInMeters>");
         fwrite($fp,"<dwc:maximumElevationInMeters>".$arr[$index]['maximum_elevation'] ."</dwc:maximumElevationInMeters>");
         fwrite($fp,"<dwc:minimumDepthInMeters>".$arr[$index]['minimum_depth'] ."</dwc:minimumDepthInMeters>");
         fwrite($fp,"<dwc:maximumDepthInMeters>".$arr[$index]['maximum_depth'] ."</dwc:maximumDepthInMeters>");
         fwrite($fp,"<dwc:occurrenceDetails>全天光空域:" .  $arr[$index]['全天光空域'] . ", 直射光空域:" . $arr[$index]['直射光空域'] . ", 測站描述:" . $arr[$index]['Locality_Describe']."</dwc:occurrenceDetails>");
         fwrite($fp,"<PH>".$arr[$index]['PH'] ."</PH>");
		 if ($arr[$index]['Project_id']==3){
		  fwrite($fp,"<Conductivity Unit='μS/cm'>".$arr[$index]['Conductivity'] ."</Conductivity>"); 
		  fwrite($fp,"<DissolvedOxygen Unit='mg/L'>".$arr[$index]['DO'] ."</DissolvedOxygen>"); 
		  fwrite($fp,"<Clarity Unit='NTU'>".$arr[$index]['Clarity'] ."</Clarity>"); 
		  fwrite($fp,"<AlkaliSilicate Unit='mg/L'>".$arr[$index]['Alkali_Silicate'] ."</AlkaliSilicate>"); 
		  fwrite($fp,"<BOD Unit='mg/L'>".$arr[$index]['BOD'] ."</BOD>"); 
		  fwrite($fp,"<NO3_N Unit='mg/L'>".$arr[$index]['NO3_N'] ."</NO3_N>"); 
		  fwrite($fp,"<NO2_N Unit='mg/L'>".$arr[$index]['NO2_N'] ."</NO2_N>"); 
		  fwrite($fp,"<SO4 Unit='mg/L'>".$arr[$index]['SO4'] ."</SO4>"); 
		  fwrite($fp,"<Chloride Unit='mg/L'>".$arr[$index]['Chloride'] ."</Chloride>"); 
		  fwrite($fp,"<Phosphate Unit='mg/L'>".$arr[$index]['Phosphate'] ."</Phosphate>"); 
		  fwrite($fp,"<TP Unit='mg/L'>".$arr[$index]['TP'] ."</TP>"); 
		  fwrite($fp,"<AN Unit='mg/L'>".$arr[$index]['AN'] ."</AN>"); 
		  fwrite($fp,"<TOC Unit='mg/L'>".$arr[$index]['TOC'] ."</TOC>");
		  fwrite($fp,"<Temperature Unit='C'>".$arr[$index]['Temperature'] ."</Temperature>"); 
		 }elseif ($arr[$index]['Project_id']==4){
		  fwrite($fp,"<EC Unit='μS/cm'>".$arr[$index]['EC'] ."</EC>"); 
		  fwrite($fp,"<DO Unit='mg/L'>".$arr[$index]['DO'] ."</DO>"); 
		  fwrite($fp,"<DO_Rate Unit='%'>".$arr[$index]['DO_Rate'] ."</DO_Rate>"); 
		  fwrite($fp,"<Temperature Unit='C'>".$arr[$index]['Temperature'] ."</Temperature>"); 
		  fwrite($fp,"<Nitrate Unit='mg/L'>".$arr[$index]['Nitrate'] ."</Nitrate>"); 
		  fwrite($fp,"<NO3_δ15N Unit='one thousandth'>".$arr[$index]['NO3_15N'] ."</NO3_δ15N>"); 
		 }elseif ($arr[$index]['Project_id']==13){
		  fwrite($fp,"<Conductivity Unit='μS/cm'>".$arr[$index]['Conductivity'] ."</Conductivity>"); 
		  fwrite($fp,"<SO4 Unit='mg/L'>".$arr[$index]['SO4'] ."</SO4>"); 
		  fwrite($fp,"<Chloride Unit='mg/L'>".$arr[$index]['Chloride'] ."</Chloride>"); 
		  fwrite($fp,"<Phosphate Unit='mg/L'>".$arr[$index]['Phosphate'] ."</Phosphate>");
		  fwrite($fp,"<Temperature Unit='C'>".$arr[$index]['Temperature'] ."</Temperature>"); 
		  fwrite($fp,"<Nitrate Unit='mg/L'>".$arr[$index]['Nitrate'] ."</Nitrate>"); 
		  fwrite($fp,"<Fluorine Unit='mg/L'>".$arr[$index]['Fl'] ."</Fluorine>"); 
		  fwrite($fp,"<Ammonia Unit='mg/L'>".$arr[$index]['NH4'] ."</Ammonia>");
		  fwrite($fp,"<NO2 Unit='mg/L'>".$arr[$index]['NO2'] ."</NO2>"); 
		  fwrite($fp,"<DOC Unit='mg/L'>".$arr[$index]['DOC'] ."</DOC>");
		  fwrite($fp,"<Sodium Unit='mg/L'>".$arr[$index]['Na'] ."</Sodium>");
		  fwrite($fp,"<Mg Unit='mg/L'>".$arr[$index]['Mg'] ."</Mg>"); 
		  fwrite($fp,"<Ca Unit='mg/L'>".$arr[$index]['Ca'] ."</Ca>"); 
		  fwrite($fp,"<K Unit='mg/L'>".$arr[$index]['K'] ."</K>"); 
		  fwrite($fp,"<Sr Unit='mg/L'>".$arr[$index]['Sr'] ."</Sr>"); 
		  fwrite($fp,"<Ba Unit='mg/L'>".$arr[$index]['Ba'] ."</Ba>");
		  fwrite($fp,"<Si Unit='mg/L'>".$arr[$index]['Si'] ."</Si>"); 
		 }
         fwrite($fp,"<projectName>".$arr[$index]['projectname'] ."</projectName>");
         fwrite($fp,"<executivePeriod>".$arr[$index]['executiveperiod'] ."</executivePeriod>");
         fwrite($fp,"<associatedAgency>".htmlspecialchars($arr[$index]['associatedagency']) ."</associatedAgency>");
         fwrite($fp,"<executiveAgency>".htmlspecialchars($arr[$index]['executiveagency']) ."</executiveAgency>");
         fwrite($fp,"<hostName>".htmlspecialchars($arr[$index]['hostname']) ."</hostName>");
         fwrite($fp,"<hostNameInChinese>".htmlspecialchars($arr[$index]['hostname_chinese']) ."</hostNameInChinese>");
         fwrite($fp,"<hostAddress>".htmlspecialchars($arr[$index]['hostaddress']) ."</hostAddress>");
         fwrite($fp,"<e-Mail>".htmlspecialchars($arr[$index]['hoste_mail']) ."</e-Mail>");
         fwrite($fp,"<coordination>".htmlspecialchars($arr[$index]['coordination']) ."</coordination>");
         fwrite($fp,"<executiveWay>".htmlspecialchars($arr[$index]['executiveway']) ."</executiveWay>");
         fwrite($fp,"<projectSummary>".htmlspecialchars($arr[$index]['projectsummary']) ."</projectSummary>");
   fwrite($fp, "</SimpleDarwinRecord>"); 
   fwrite($fp, "</SimpleDarwinRecordSet>"); 
   fclose($fp);   
     }
	}
echo "Done!";
?>
