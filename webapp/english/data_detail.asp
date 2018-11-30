<!--#include file="conn.asp "-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
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
id=request("id")
        
 sql="SELECT main.*, Station.*, Project.* FROM (main INNER JOIN Station ON main.id = Station.id) INNER JOIN Project ON main.Project_ID = Project.Project_id where record_id=" & record_id 
rs.open sql ,conn ,1,1 
%>

<div align="center">
  <center>
  <table border="0" width="90%">
    <tr>
      <td width="100%"><font size="2">Record NO. : WLTERM<%=record_id%></font>
      <table border="1" width="100%">
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Scientific Name</td>
      <td><%=rs("scientific_name")%>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Station NO.</td>
      <td><%=rs("station.id")%>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap >Family</td>
      <td ><%=rs("family")%>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Locality</td>
      <td ><%=rs("locality")%>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Individual Count</td>
      <td><%=rs("individual_count")%>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Latitude</td>
      <td><%=rs("latitude")%>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Cover Rate</td>
      <td><%=rs("cover_rate")%>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Longitude</td>
      <td><%=rs("longitude")%>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Length</td>
      <td><%=rs("body_length")%>　<%=rs("body_length_unit")%></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Cordinate Precision</td>
      <td><%=rs("coordinate_precision")%> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Biosmass</td>
      <td><%=rs("biomass")%>　<%=rs("biomass_unit")%></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Minimum Depth</td>
      <td><%=rs("minimum_depth")%> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Invester</td>
      <td><%=rs("collector")%>　<%=rs("collector_chinese")%></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Maxmum Depth</td>
      <td><%=rs("maximum_depth")%> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Invest Way</td>
      <td><%=rs("examine_way")%>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Minimum Elevation</td>
      <td><%=rs("maximum_elevation")%> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Identifier</td>
      <td><%=rs("identified_by")%>　<%=rs("identified_by_chinese")%></td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Maxmum Elevation</td>
      <td><%=rs("minimum_elevation")%> M</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Date</td>
      <td><%=rs("date")%>　</td>
      <td width="10%" bgcolor="#CCCCCC" nowrap>　</td>
      <td>　</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#CCCCCC" nowrap>Locality Summary</td>
      <td colspan="3" valign="middle"><%=rs("locality_describe")%>&nbsp;<a href="../LocalMapE.asp?id=<%=rs("Station.id")%>&pid=<%=rs("main.project_id")%>"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a></td>
    </tr>
  </table>
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
     <font size="3" color="#000000"><a href="/XML/WLTERM<%=rs("record_id")%>.xml"><b> Get XML with Darwin Core</b></a></font>  
  </td></tr>
  </table>
  
  </center>


</body>