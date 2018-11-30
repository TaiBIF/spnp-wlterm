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
porder=request("R1")
pcrit=request("D1")
if pcrit="" then pcrit="ALL"
if pcrit="ALL" then
 ppcrit="All Stations"
else
 ppcrit="Station:" & pcrit    
end if 
if porder="" then porder="family"
if porder="family" then 
  pporder="family,scientific_name"
  porderch="門名"
  p1=" style='border: 1 ridge #B4B4B4'"
else
  pporder=porder
end if  
if pcrit="ALL"  then
 sql="SELECT main.*, Station.* FROM main INNER JOIN Station ON main.id = Station.id  order by " & pporder
else
 sql="SELECT main.*, Station.* FROM main INNER JOIN Station ON main.id = Station.id where main.id=" & pcrit & " order by " & pporder
end if 
rs.open sql ,conn ,1,1 
if rs.eof then
 response.write "<center>查無資料!</center>"
 response.end
end if 

if request("pagesize") <>"" then
 rs.pagesize=request("pagesize")
else
 rs.pagesize=20
end if
pagesize=rs.pagesize 
pagecount=rs.pagecount
page=clng(request("page"))
plen=len(cstr(page-1))-1
group=clng(mid(cstr(page-1),1,plen) & "1")
pgroup=int(pagecount/10)
if page < 11 then group=1
if page < 1  then page=1
if page > pagecount then page=pagecount
if group < 1 then group=1
if group > pagecount then group=pagecount
%> 
<form name="form1" action="record_list.asp">
  <center><font size="4" color="#393939"><B><%=rs.recordcount%>&nbsp;Records&nbsp;for&nbsp;<%=ppcrit%></B></font>
    <a href="../LocalMapE.asp?id=<%=pcrit%>&pid=all"><img border="0" src="../images/googlemap.gif" align="absmiddle"></a>

  <center><A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/first.gif" ALT="第一頁"></a>&nbsp;    
  <% if group > 1 then %>                   
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous10.gif" ALT="上10頁"></a>&nbsp;                                                    
   <% else %>               
  <img border="0"  src="../images/previous10dis.gif" ALT="上10頁(失效)">&nbsp;                                                    
   <% end if %>                  
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous.gif" ALT="上一頁"></a>&nbsp;                                                    
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next.gif" ALT="下一頁"></a>&nbsp;                                                     
   <% if group < (pgroup*10+1) then %>                  
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next10.gif" ALT="下10頁"></a>&nbsp;                                                     
   <% else %>               
<img border="0"  src="../images/next10dis.gif" ALT="下10頁(失效)">&nbsp;                                                     
  <% end if %>                 
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/last.gif" ALT="最後一頁"></a>&nbsp;&nbsp;          
  <font size="2"><%                  
for i=group to group+9                      
 if i > pagecount then exit for
    if i=page then 
     icolor="#FF0000"
     ibold="<B>"
     ibold2="</B>"
    else
     icolor=""
     ibold=""
     ibold2=""
    end if                 
%>                         
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=i%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><font size="2" color="<%=icolor%>"><%=ibold%><%=i%><%=ibold2%></font></a>                                                
<%                                                   
next                 
                      
%>                 
  <font size="2"><font size="2" >Page: <%=page%>/<%=pagecount%>&nbsp;&nbsp;&nbsp;&nbsp;Total:&nbsp;<%=rs.recordcount%> records
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page size: <input type="text" name="pagesize" size="1" value="<%=pagesize%>" style="font-size: 9pt; position: relative; width: 25; height: 19"></font><input type="submit" value="change" name="sent" style="color: #ff0000; font-size: 12px; background-color: #FFFFFF; vertical-align: -1; width: 45; height: 20" color="#000080">&nbsp;&nbsp;                    
 
<table border="1" height="49" cellspacing="1" cellpadding="2">         
   <tr>         
    <td bgcolor="#D6D7D6"><img border="0" src="../images/bg03-2.gif"></td>  
   </font>  
</font>
    
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Family<a href="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=page%>&R1=family&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p2%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Scientific Name<a href="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=page%>&R1=scientific_name&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p2%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Date<a href="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=page%>&R1=date&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p3%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Locality<a href="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=page%>&R1=locality&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p4%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Latitude<a href="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=page%>&R1=locality_chinese&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p4%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Longitude<a href="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=page%>&R1=locality_chinese&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p4%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Depth<a href="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=page%>&R1=minimum_depth&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p5%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Invester<a href="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=page%>&R1=collector&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0" src="../images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="排序" <%=p6%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="細明體" color="#000000" size="2">Detail</font></td>      
    </tr>         
    
        <%        
rs.absolutepage=page               
for i=1 to rs.pagesize    
 %>           
  <tr>   
     <td bgcolor="#F7F3FF"><img border="0" src="../images/bg03-2.gif"></td>  
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("family")%></font></td>       
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("scientific_name")%></font></td>       
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("date")%>&nbsp;</font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("locality")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("latitude")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("longitude")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("minimum_depth")%>-<%=rs("maximum_depth")%></font></td>   
     <td height="20" bgcolor="#F7F3FF"><font size="1" ><%=rs("collector")%></font></td>   
      <%      
     plink="data_detail.asp?record_id=" & rs("record_id")
     %>
     <td height="20" align="center" bgcolor="#F7F3FF"><a href="<%=plink%>"><font size="1" ><img border="0" src="../images/smallearth.gif" width="22" height="15" align="center"></font></a></td>   
   </tr>        
 <%         
   rs.movenext        
  if rs.eof then exit for      
  next        
    %>        
  </table>       
   <p style="margin-top: 3">       
 <font size="2" color="#800000">      
    <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/first.gif" ALT="第一頁" align="absmiddle" hspace="3" vspace="1"></a>              
    <% if group > 1 then %>                       
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous10.gif" ALT="上10頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <% else %>                     
  <img border="0"  src="../images/previous10dis.gif" ALT="上10頁" align="absmiddle" hspace="3" vspace="1">                                    
   <% end if %>                        
    <A HREF="taibnet_species_list.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/previous_2.gif" ALT="上一頁" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next.gif" ALT="下一頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% if group < (pgroup*10+1) then %>                   
<A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/next10.gif" ALT="下10頁" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% else %>                     
<img border="0"  src="../images/next10dis.gif" ALT="下10頁" align="absmiddle" hspace="3" vspace="1">                                     
  <% end if %>                       
  <A HREF="http://wlterm.biodiv.sinica.edu.tw/english/record_list.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>"><img border="0"  src="../images/last.gif" ALT="最後一頁" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <p style="margin-top: 3" align="center"><font size="2">Jump to page: <input type="text" name="page" size="5" style="font-size: 10pt; position: relative; width: 40; height: 20" value="1"></font><font size="2"><input type="submit" value="jump" name="B1" style="font-size: 8pt; position: relative; width: 50; height: 22; left: 1; top: 0; letter-spacing: 3"></p>
 <input type="hidden" name="R1" value="<%=porder%>">
 <input type="hidden" name="D1" value="<%=pcrit%>">
 <input type="hidden" name="PI" value="<%=PI%>">

</form>


  </center>


  </font>


</body>

</html>