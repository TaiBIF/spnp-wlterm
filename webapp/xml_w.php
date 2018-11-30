<?php
header('Content-Type: text/xml;charset=UTF-8');
include("conn_clean.php"); 
set_time_limit(600);
ini_set("memory_limit","24M");
  $pnow=getdate();
  $ppnow=$pnow['year'] . "-" . $pnow['mon'] . "-" .$pnow['mday'];
    $sqlstr="SELECT water.*, station.*, project.* FROM (water INNER JOIN project ON water.Project_id = project.Project_id) INNER JOIN station ON water.id = station.id   where record_id=".$_GET['record_id'];
    $result=mysql_query($sqlstr,$link_ID);
     $arr[$index]=mysql_fetch_array($result); 
	 echo "<?xml version='1.0' encoding='utf-8'?>";
	 echo "<SimpleDarwinRecordSet";
     echo " xmlns='http://rs.tdwg.org/dwc/xsd/simpledarwincore/'";
      echo " xmlns:dc='http://purl.org/dc/terms/'";
       echo " xmlns:dwc='http://rs.tdwg.org/dwc/terms/'";
       echo " xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'";
       echo " xsi:schemaLocation='http://rs.tdwg.org/dwc/xsd/simpledarwincore/ http://rs.tdwg.org/dwc/xsd/tdwg_dwc_simple.xsd'>";
       echo "<SimpleDarwinRecord>";
echo "<dc:modified>".$ppnow."</dc:modified>";
echo "<dwc:occurrenceID>urn:lsid:wlterm.biodiv.sinica.edu.tw:observation:WQ" . $arr[$index]['record_id']."</dwc:occurrenceID>";
echo "<dwc:catalogNumber>".$arr[$index]['record_id']."</dwc:catalogNumber>";
         echo "<dwc:basisOfRecord>O</dwc:basisOfRecord>";
         echo "<dwc:recordedBy>".htmlspecialchars($arr[$index]['collector']) ."</dwc:recordedBy>";
         echo "<recordedByInChinese>".htmlspecialchars($arr[$index]['collector_chinese']) ."</recordedByInChinese>";
		 $pdate=strtotime($arr[$index]['date']);
		 $pdate=getdate($pdate);
		 if ($pdate['hours']==0 && $pdate['minutes']==0 && $pdate['seconds']==0){
		  $showdate=$pdate['year'] . "-" . substr(100+$pdate['mon'],1,2) . "-" .substr(100+$pdate['mday'],1,2);
		 }else{
		  $showdate=$arr[$index]['date'];
		 } 
          echo "<dwc:eventDate>".$showdate."</dwc:eventDate>";
		 $pdate=strtotime($arr[$index]['date_end']);
		 $pdate=getdate($pdate);
		 if ($pdate['hours']==0 && $pdate['minutes']==0 && $pdate['seconds']==0){
		  $showdate=$pdate['year'] . "-" . substr(100+$pdate['mon'],1,2) . "-" .substr(100+$pdate['mday'],1,2);
		 }else{
		  $showdate=$arr[$index]['date_end'];
		 } 
          echo "<eventDateEnd>".$showdate."</eventDateEnd>";
         echo "<dwc:locality>".htmlspecialchars($arr[$index]['locality']) ."</dwc:locality>";
         echo "<localityInChinese>".htmlspecialchars($arr[$index]['locality_chinese']) ."</localityInChinese>";
         echo "<dwc:decimalLongitude>".$arr[$index]['longitude'] ."</dwc:decimalLongitude>";
         echo "<dwc:decimalLatitude>".$arr[$index]['latitude'] ."</dwc:decimalLatitude>";
         echo "<dwc:coordinateUncertaintyInMeters>".$arr[$index]['coordinate_precision'] ."</dwc:coordinateUncertaintyInMeters>";
         echo "<dwc:minimumElevationInMeters>".$arr[$index]['minimum_elevation'] ."</dwc:minimumElevationInMeters>";
         echo "<dwc:maximumElevationInMeters>".$arr[$index]['maximum_elevation'] ."</dwc:maximumElevationInMeters>";
         echo "<dwc:minimumDepthInMeters>".$arr[$index]['minimum_depth'] ."</dwc:minimumDepthInMeters>";
         echo "<dwc:maximumDepthInMeters>".$arr[$index]['maximum_depth'] ."</dwc:maximumDepthInMeters>";
         echo "<dwc:occurrenceDetails>全天光空域:" .  $arr[$index]['全天光空域'] . ", 直射光空域:" . $arr[$index]['直射光空域'] . ", 測站描述:" . $arr[$index]['Locality_Describe']."</dwc:occurrenceDetails>";
         echo "<PH>".$arr[$index]['PH'] ."</PH>";
		 if ($arr[$index]['Project_id']==3){
		  echo "<Conductivity Unit='μS/cm'>".$arr[$index]['Conductivity'] ."</Conductivity>"; 
		  echo "<DissolvedOxygen Unit='mg/L'>".$arr[$index]['DO'] ."</DissolvedOxygen>"; 
		  echo "<Clarity Unit='NTU'>".$arr[$index]['Clarity'] ."</Clarity>"; 
		  echo "<AlkaliSilicate Unit='mg/L'>".$arr[$index]['Alkali_Silicate'] ."</AlkaliSilicate>"; 
		  echo "<BOD Unit='mg/L'>".$arr[$index]['BOD'] ."</BOD>"; 
		  echo "<NO3_N Unit='mg/L'>".$arr[$index]['NO3_N'] ."</NO3_N>"; 
		  echo "<NO2_N Unit='mg/L'>".$arr[$index]['NO2_N'] ."</NO2_N>"; 
		  echo "<SO4 Unit='mg/L'>".$arr[$index]['SO4'] ."</SO4>"; 
		  echo "<Chloride Unit='mg/L'>".$arr[$index]['Chloride'] ."</Chloride>"; 
		  echo "<Phosphate Unit='mg/L'>".$arr[$index]['Phosphate'] ."</Phosphate>"; 
		  echo "<TP Unit='mg/L'>".$arr[$index]['TP'] ."</TP>"; 
		  echo "<AN Unit='mg/L'>".$arr[$index]['AN'] ."</AN>"; 
		  echo "<TOC Unit='mg/L'>".$arr[$index]['TOC'] ."</TOC>";
		  echo "<Temperature Unit='C'>".$arr[$index]['Temperature'] ."</Temperature>"; 
		 }elseif ($arr[$index]['Project_id']==4){
		  echo "<EC Unit='μS/cm'>".$arr[$index]['EC'] ."</EC>"; 
		  echo "<DO Unit='mg/L'>".$arr[$index]['DO'] ."</DO>"; 
		  echo "<DO_Rate Unit='%'>".$arr[$index]['DO_Rate'] ."</DO_Rate>"; 
		  echo "<Temperature Unit='C'>".$arr[$index]['Temperature'] ."</Temperature>"; 
		  echo "<Nitrate Unit='mg/L'>".$arr[$index]['Nitrate'] ."</Nitrate>"; 
		  echo "<NO3_δ15N Unit='one thousandth'>".$arr[$index]['NO3_15N'] ."</NO3_δ15N>"; 
		 }elseif ($arr[$index]['Project_id']==13){
		  echo "<Conductivity Unit='μS/cm'>".$arr[$index]['Conductivity'] ."</Conductivity>"; 
		  echo "<SO4 Unit='mg/L'>".$arr[$index]['SO4'] ."</SO4>"; 
		  echo "<Chloride Unit='mg/L'>".$arr[$index]['Chloride'] ."</Chloride>"; 
		  echo "<Phosphate Unit='mg/L'>".$arr[$index]['Phosphate'] ."</Phosphate>";
		  echo "<Temperature Unit='C'>".$arr[$index]['Temperature'] ."</Temperature>"; 
		  echo "<Nitrate Unit='mg/L'>".$arr[$index]['Nitrate'] ."</Nitrate>"; 
		  echo "<Fluorine Unit='mg/L'>".$arr[$index]['Fl'] ."</Fluorine>"; 
		  echo "<Ammonia Unit='mg/L'>".$arr[$index]['NH4'] ."</Ammonia>";
		  echo "<NO2 Unit='mg/L'>".$arr[$index]['NO2'] ."</NO2>"; 
		  echo "<DOC Unit='mg/L'>".$arr[$index]['DOC'] ."</DOC>";
		  echo "<Sodium Unit='mg/L'>".$arr[$index]['Na'] ."</Sodium>";
		  echo "<Mg Unit='mg/L'>".$arr[$index]['Mg'] ."</Mg>"; 
		  echo "<Ca Unit='mg/L'>".$arr[$index]['Ca'] ."</Ca>"; 
		  echo "<K Unit='mg/L'>".$arr[$index]['K'] ."</K>"; 
		  echo "<Sr Unit='mg/L'>".$arr[$index]['Sr'] ."</Sr>"; 
		  echo "<Ba Unit='mg/L'>".$arr[$index]['Ba'] ."</Ba>";
		  echo "<Si Unit='mg/L'>".$arr[$index]['Si'] ."</Si>"; 
		 }
         echo "<projectName>".$arr[$index]['projectname'] ."</projectName>";
         echo "<executivePeriod>".$arr[$index]['executiveperiod'] ."</executivePeriod>";
         echo "<associatedAgency>".htmlspecialchars($arr[$index]['associatedagency']) ."</associatedAgency>";
         echo "<executiveAgency>".htmlspecialchars($arr[$index]['executiveagency']) ."</executiveAgency>";
         echo "<hostName>".htmlspecialchars($arr[$index]['hostname']) ."</hostName>";
         echo "<hostNameInChinese>".htmlspecialchars($arr[$index]['hostname_chinese']) ."</hostNameInChinese>";
         echo "<hostAddress>".htmlspecialchars($arr[$index]['hostaddress']) ."</hostAddress>";
         echo "<e-Mail>".htmlspecialchars($arr[$index]['hoste_mail']) ."</e-Mail>";
         echo "<coordination>".htmlspecialchars($arr[$index]['coordination']) ."</coordination>";
         echo "<executiveWay>".htmlspecialchars($arr[$index]['executiveway']) ."</executiveWay>";
         echo "<projectSummary>".htmlspecialchars($arr[$index]['projectsummary']) ."</projectSummary>";
   echo "</SimpleDarwinRecord>"; 
   echo "</SimpleDarwinRecordSet>"; 
?>
