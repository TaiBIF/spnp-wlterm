<!--#include file="conn.asp "-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<title></title>
<STYLE TYPE="text/css">
        <!-- body, th, td, input, select, textarea, select, checkbox {font:10pt Arial}
         a:link {font: 10pt "Arial"; text-decoration: none;color:none}
         a:visited      {font: 10pt "Arial"; text-decoration: none; color: 000000}
         a:active       {font: 10pt "Arial"; text-decoration: none; color: 00CC66}
         a:hover        {font: 10pt Arial; text-decoration: underline; color: ff0000}
        -->
   </STYLE>

</head>
<body>
<% 
record_id=request("record_id")
PI=request("PI")
if PI="1" then
 sql="SELECT alage.*, Station.*, Project.* FROM (alage INNER JOIN Project ON alage.Project_id = Project.Project_id) INNER JOIN Station ON alage.id = Station.id "
 sql=sql & "where record_id=" & record_id
else
 sql="SELECT water.*, Station.*, Project.* FROM (water INNER JOIN Project ON water.Project_id = Project.Project_id) INNER JOIN Station ON water.id = Station.id "
 sql=sql & "where record_id=" & record_id
end if 
rs.open sql ,conn ,1,1 
%>

<div align="center">
  <center>
<%if PI="3" then%>  
  <table border="0" width="100%">
    <tr>
      <td width="100%"><font size="2">Water Quality Records NO.: WQ<%=record_id%></font>
      <table border="1" width="100%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Date</td>
      <td height="17"><%=rs("date")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><%=rs("全天光空域")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>NO3_N mg/L</td>    
      <td height="17"><%=rs("NO3_N")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      Staion ID</td>
      <td height="17" ><%=rs("station.id")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      直射光空域</td>    
      <td height="17"><%=rs("直射光空域")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      NO2_N mg/L</td>    
      <td height="17"><%=rs("NO2_N")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality</td>
      <td height="17"><%=rs("locality")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector</td>    
      <td height="17"><%=rs("collector")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>SO4 mg/L</td>    
      <td height="17"><%=rs("SO4")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Latitude</td>
      <td height="17"><%=rs("latitude")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector in Chinese</td>
      <td height="17"><%=rs("collector_chinese")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Chloride mg/L</td>    
      <td height="17"><%=rs("Chloride")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Longitude</td>
      <td height="12"><%=rs("longitude")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>PH</td>
      <td height="12"><%=rs("PH")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Phosphate mg/L</td>    
      <td height="12"><%=rs("Phosphate")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Coordinate Precision</td>
      <td height="19"><%=rs("coordinate_precision")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Conductivity μS/cm</td>
      <td height="19"><%=rs("Conductivity")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>TP mg/L</td>    
      <td height="19"><%=rs("TP")%>　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>
      <td height="19"><%=rs("minimum_depth")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>DO mg/L</td>    
      <td height="19"><%=rs("DO")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>AN mg/L</td>    
      <td height="19"><%=rs("AN")%>　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Depth</td>
      <td height="18"><%=rs("maximum_depth")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Clarity mg/L</td>    
      <td height="18"><%=rs("Clarity")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>TOC mg/L</td>    
      <td height="18"><%=rs("TOC")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Elevation</td>
      <td height="19"><%=rs("maximum_elevation")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Alkali Silicate mg/L</td>    
      <td height="19"><%=rs("Alkali_Silicate")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Elevation</td>
      <td height="19"><%=rs("minimum_elevation")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      BOD mg/L</td>    
      <td height="19"><%=rs("BOD")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality Summary</td>
      <td height="19" colspan="5"><%=rs("Locality_describe")%>&nbsp;<a href="../LocalMapE.asp?id=<%=rs("Station.id")%>&pid=<%=PI%>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<%elseif PI="4" then %>
  <table border="0" width="100%">
    <tr>
      <td width="100%"><font size="2">Nitrate Record NO.：WQ<%=record_id%></font>
      <table border="1" width="100%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Date</td>
      <td height="17"><%=rs("date")%></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Elevation</td>
      <td height="17"><%=rs("maximum_elevation")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Tem.&nbsp; ℃</td>    
      <td height="17"><%=rs("NO3_N")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      Station ID</td>
      <td height="17" ><%=rs("station.id")%></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Elevation</td>
      <td height="17"><%=rs("minimum_elevation")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      Nitrate mg/L</td>    
      <td height="17"><%=rs("Nitrate")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality_</td>
      <td height="17"><%=rs("locality")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><%=rs("全天光空域")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap rowspan="2">NO3-穩定氮同<br>
      位素 &#8240;</td>    
      <td height="34" rowspan="2"><%=rs("NO3_15N")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>latitude</td>
      <td height="17"><%=rs("latitude")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>直射光空域</td>   
      <td height="17"><%=rs("直射光空域")%>　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>longitude</td>
      <td height="12"><%=rs("longitude")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector</td>    
      <td height="12"><%=rs("collector")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>PH</td>    
      <td height="12"><%=rs("ph")%>　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Coordinate Precision</td>
      <td height="19"><%=rs("coordinate_precision")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector in Chinese</td>
      <td height="19"><%=rs("collector_chinese")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>EC &micro;S/cm</td>    
      <td height="19"><%=rs("EC")%>　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>
      <td height="19"><%=rs("minimum_depth")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>DO mg/L</td>    
      <td height="19"><%=rs("DO")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Depth</td>
      <td height="18"><%=rs("maximum_depth")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>DO Rate %</td>    
      <td height="18"><%=rs("DO_Rate")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="18">　</td>
    </tr>
     <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality Summary</td>
      <td height="19" colspan="5"><%=rs("Locality_describe")%>&nbsp;<a href="../LocalMap.asp?id=<%=rs("Station.id")%>&pid=<%=PI%>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<%elseif PI="13" then%>  
  <table border="0" width="100%">
    <tr>
      <td width="100%"><font size="2">Main Water Elemnets Record NO.：WQ<%=record_id%></font>
      <table border="1" width="100%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Date</td>
      <td height="17"><%=rs("date")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><%=rs("全天光空域")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>NH4</td>    
      <td height="17"><%=rs("NH4")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      St ID</td>
      <td height="17" ><%=rs("station.id")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      Collector</td>    
      <td height="17"><%=rs("collector")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap >
      NO2 mg/L</td>    
      <td height="17"><%=rs("NO2")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>locality</td>
      <td height="17"><%=rs("locality")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector in Chinese</td>    
      <td height="17"><%=rs("collector_chinese")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>DOC mg/L</td>    
      <td height="17"><%=rs("DOC")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Latitude</td>
      <td height="17"><%=rs("latitude")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Water Tem.&nbsp; ℃</td>
      <td height="17"><%=rs("temperature")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Na mg/L</td>    
      <td height="17"><%=rs("Na")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Longitude</td>
      <td height="12"><%=rs("longitude")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>PH</td>
      <td height="12"><%=rs("PH")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Mg mg/L</td>    
      <td height="12"><%=rs("Mg")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Coordinate Uncertern M</td>
      <td height="19"><%=rs("coordinate_precision")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Conductivity μS/cm</td>
      <td height="19"><%=rs("Conductivity")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>K mg/L</td>    
      <td height="19"><%=rs("K")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>
      <td height="19"><%=rs("minimum_depth")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Nitrate mg/L</td>    
      <td height="19"><%=rs("nitrate")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Ca mg/L</td>    
      <td height="19"><%=rs("Ca")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Depth</td>
      <td height="18"><%=rs("maximum_depth")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>SO4 mg/L</td>    
      <td height="18"><%=rs("SO4")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Sr mg/L</td>    
      <td height="18"><%=rs("Sr")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Eelevation</td>
      <td height="19"><%=rs("maximum_elevation")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Phosphate mg/L</td>    
      <td height="19"><%=rs("Phosphate")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Ba</td>    
      <td height="19"><%=rs("Ba")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" >Minimum Eelevation</td>
      <td height="19"><%=rs("minimum_elevation")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" >
      Chloride mg/L</td>    
      <td height="19" ><%=rs("Chloride")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC"  >Si</td>    
      <td height="19"><%=rs("Si")%>&nbsp;</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>直射光空域</td>
      <td height="19"><%=rs("直射光空域")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>
      Fl mg/L</td>    
      <td height="19"><%=rs("Fl")%>&nbsp;</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >　</td>    
      <td height="19">　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality Describe</td>
      <td height="19" colspan="5"><%=rs("Locality_describe")%>&nbsp;<a href="../LocalMapE.asp?id=<%=rs("Station.id")%>&pid=<%=PI%>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
  
<%elseif PI="1" then %>
  <table border="0" width="100%">
    <tr>
      <td width="100%"><font size="2">Alage and Organic Detritus Record NO.：AO<%=record_id%></font>
      <table border="1" width="100%" height="211">
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Date</td>
      <td height="17"><%=rs("date")%></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>Maximum Eelevation</td>
      <td height="17"><%=rs("maximum_elevation")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>    
      <td height="17"><%=rs("minimum_depth")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>
      Station ID</td>
      <td height="17" ><%=rs("station.id")%></td>
      <td width="120" bgcolor="#CCCCCC" nowrap>Minimum Elevation</td>
      <td height="17"><%=rs("minimum_elevation")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap >Maximum Depth</td>    
      <td height="17"><%=rs("maximum_depth")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality</td>
      <td height="17"><%=rs("locality")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>全天光空域</td>    
      <td height="17"><%=rs("全天光空域")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Item</td>    
      <td height="17"><%=rs("item_chinese")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>latitude</td>
      <td height="17"><%=rs("latitude")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>直射光空域</td>   
      <td height="17"><%=rs("直射光空域")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Biomass</td>   
      <td height="17"><%=rs("biomass")%></td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>longitude</td>
      <td height="12"><%=rs("longitude")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Collector</td>    
      <td height="12"><%=rs("collector")%></td>
      <td width="140" bgcolor="#CCCCCC" nowrap>Unit</td>    
      <td height="12"><%=rs("unit")%>　</td>
    </tr>
    <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Coordinate Precision</td>
      <td height="19"><%=rs("coordinate_precision")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap:>Collector in Chinese</td>
      <td height="19"><%=rs("collector_chinese")%>　</td>
      <td width="140" bgcolor="#CCCCCC" nowrap>　</td>    
      <td height="19">　</td>
    </tr>
     <tr>
      <td width="120" bgcolor="#CCCCCC" nowrap>Locality Summary</td>
      <td height="19" colspan="5"><%=rs("Locality_describe")%>&nbsp;<a href="../LocalMapE.asp?id=<%=rs("Station.id")%>&pid=<%=PI%>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
<%end if%>
  <br>
    <table border="1" width="100%">
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Project Name</td>
      <td><%=rs("projectName")%>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Executive Period</td>
      <td><%=rs("ExecutivePeriod")%>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Associated Agency</td>
      <td><%=rs("AssociatedAgency")%>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Executive Agency</td>
      <td><%=rs("ExecutiveAgency")%>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Host Name</td>
      <td><%=rs("HostName_chinese")%>&nbsp;<%=rs("HostName")%></td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Host Address</td>
      <td><%=rs("HostAddress")%>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>E-Mail</td>
      <td><%=rs("HostE_mail")%>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Coordination</td>
      <td><%=rs("coordination")%>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Executive Way</td>
      <td><%=rs("ExecutiveWay")%>　</td>
    </tr>
    <tr>
      <td width="6%" bgcolor="#CCCCCC" nowrap>Project Summary</td>
      <td><%=rs("ProjectSummary")%>　</td>
    </tr>
  </table>

      </td>
     
    </tr>
    <tr><td>
     <font size="3" color="#000000">
    <%if PI="1" then %>
    <a href="XML/AO<%=rs("record_id")%>.xml"><b> Get XML with Darwin Core</b></a></font>  
    <%else%>  
    <a href="XML/WQ<%=rs("record_id")%>.xml"><b> Get XML with Darwin Core</b></a></font>  
    <%end if%>
  </td></tr>
  </table>
  
  </center>


</body>