<!--#include file="conn.asp "-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>WLTERM</title>
<title></title>
<STYLE TYPE="text/css">
        <!-- body, th, td, input, select, textarea, select, checkbox {font:10pt �s�ө���}
         a:link {font: 10pt "�s�ө�"; text-decoration: none;color:none}
         a:visited      {font: 10pt "�s�ө�"; text-decoration: none; color: 000000}
         a:active       {font: 10pt "�s�ө�"; text-decoration: none; color: 00CC66}
         a:hover        {font: 10pt �s�ө�; text-decoration: underline; color: ff0000}
        -->
   </STYLE>

</head>
<body>
<%
lng=request("lng") 
lat=request("lat")      
porder=request("R1")
if porder="" then porder="family"
if porder="family" then 
  pporder="family,scientific_name"
  porderch="���W"
  p1=" style='border: 1 ridge #B4B4B4'"
else
  pporder=porder
end if  
sql="SELECT main.*, Station.* FROM main INNER JOIN Station ON main.id = Station.id  where cstr(longitude)='" & lng & "' and cstr(latitude)='" & lat & "' order by " & pporder
rs.open sql ,conn ,1,1 
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
<form name="form1" action="dataPoint.asp">
        <div align="center">
  <center><A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/first.gif" ALT="�Ĥ@��"></a>&nbsp;     
  <% if group > 1 then %>                   
  <A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/previous10.gif" ALT="�W10��"></a>&nbsp;                                                     
   <% else %>               
  <img border="0"  src="images/previous10dis.gif" ALT="�W10��(����)">&nbsp;                                                     
   <% end if %>                  
    <A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/previous.gif" ALT="�W�@��"></a>&nbsp;                                                     
<A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/next.gif" ALT="�U�@��"></a>&nbsp;                                                      
   <% if group < (pgroup*10+1) then %>                  
<A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/next10.gif" ALT="�U10��"></a>&nbsp;                                                      
   <% else %>               
<img border="0"  src="images/next10dis.gif" ALT="�U10��(����)">&nbsp;                                                      
  <% end if %>                 
  <A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/last.gif" ALT="�̫�@��"></a>&nbsp;&nbsp;           
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
<A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=i%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><font size="2" color="<%=icolor%>"><%=ibold%><%=i%><%=ibold2%></font></a>                                                 
<%                                                    
next                 
                      
%>                 
  <font size="2">�@��<font face="�s�ө���" size="2" ><%=page%>/<%=pagecount%>��&nbsp;&nbsp;&nbsp;&nbsp;���a�I�@�լd&nbsp;<%=rs.recordcount%>������
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�C��<input type="text" name="pagesize" size="1" value="<%=pagesize%>" style="font-size: 9pt; position: relative; width: 25; height: 19">��</font><input type="submit" value="���" name="sent" style="color: #ff0000; font-size: 12px; background-color: #FFFFFF; vertical-align: -1; width: 35; height: 20" color="#000080">&nbsp;&nbsp;                    
 
<table border="1" height="49" cellspacing="1" cellpadding="2">         
   <tr>         
    <td bgcolor="#D6D7D6"><img border="0" src="images/bg03-2.gif"></td>  
   </font>  
</font>
    
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">��W<a href="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=page%>&R1=family&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0" src="images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="�Ƨ�" <%=p2%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">�ǦW<a href="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=page%>&R1=scientific_name&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0" src="images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="�Ƨ�" <%=p2%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">���<a href="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=page%>&R1=collect_date&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0" src="images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="�Ƨ�" <%=p3%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">�a�I<a href="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=page%>&R1=locality_chinese&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0" src="images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="�Ƨ�" <%=p4%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">�n��<a href="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=page%>&R1=locality_chinese&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0" src="images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="�Ƨ�" <%=p4%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">�g��<a href="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=page%>&R1=locality_chinese&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0" src="images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="�Ƨ�" <%=p4%>></a></font></td>         
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">�`��<a href="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=page%>&R1=minimum_depth&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0" src="images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="�Ƨ�" <%=p5%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">�լd��<a href="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=page%>&R1=collector_chinese&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0" src="images/arrow.gif" align="absmiddle" hspace="2" vspace="2" alt="�Ƨ�" <%=p6%>></a></font></td>      
    <td bgcolor="#D6D7D6" height="17" align="center" nowrap><font face="�ө���" color="#000000" size="2">���e</font></td>      
    </tr>         
    
        <%        
rs.absolutepage=page               
for i=1 to rs.pagesize    
 %>           
  <tr>   
     <td><img border="0" src="images/bg03-2.gif"></td>  
     <td height="20"><font size="1" ><%=rs("family")%></font></td>       
     <td height="20"><font size="1" ><%=rs("scientific_name")%></font></td>       
     <td height="20"><font size="1" ><%=rs("collect_date")%>&nbsp;</font></td>   
     <td height="20"><font size="1" ><%=rs("locality_chinese")%></font></td>   
     <td height="20"><font size="1" ><%=rs("latitude")%></font></td>   
     <td height="20"><font size="1" ><%=rs("longitude")%></font></td>   
     <td height="20"><font size="1" ><%=rs("minimum_depth")%>-<%=rs("maximum_depth")%></font></td>   
     <td height="20"><font size="1" ><%=rs("collector_chinese")%></font></td>   
      <%      
     plink="data_detail.asp?record_id=" & rs("record_id")
     %>
     <td height="20" align="center"><font size="1" ><a href="<%=plink%>"><img border="0" src="images/smallearth.gif" width="22" height="15" align="center"></font></a></td>   
   </tr>        
 <%         
   rs.movenext        
  if rs.eof then exit for      
  next        
    %>        
  </table>       
   <p style="margin-top: 3">       
 <font face="�s�ө���" size="2" color="#800000">      
    <A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=1&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/first_2.gif" ALT="�Ĥ@��" align="absmiddle" hspace="3" vspace="1"></a>              
    <% if group > 1 then %>                       
  <A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=(page-10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/previous10_2.gif" ALT="�W10��" align="absmiddle" hspace="3" vspace="1"></a>                                    
   <% else %>                     
  <img border="0"  src="images/previous10dis_2.gif" ALT="�W10��" align="absmiddle" hspace="3" vspace="1">                                    
   <% end if %>                        
    <A HREF="taibnet_species_list.asp?page=<%=(page-1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/previous_2.gif" ALT="�W�@��" align="absmiddle" hspace="3" vspace="1"></a>                                    
<A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=(page+1)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/next_2.gif" ALT="�U�@��" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% if group < (pgroup*10+1) then %>                   
<A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=(page+10)%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/next10_2.gif" ALT="�U10��" align="absmiddle" hspace="3" vspace="1"></a>                                     
   <% else %>                     
<img border="0"  src="images/next10dis_2.gif" ALT="�U10��" align="absmiddle" hspace="3" vspace="1">                                     
  <% end if %>                       
  <A HREF="http://coast.sinica.edu.tw/dataPoint.asp?page=<%=pagecount%>&R1=<%=porder%>&D1=<%=pcrit%>&pagesize=<%=pagesize%>&lng=<%=lng%>&lat=<%=lat%>"><img border="0"  src="images/last_2.gif" ALT="�̫�@��" align="absmiddle" hspace="3" vspace="1"></a>              
  </center>
</font>
 <p style="margin-top: 3"><font face="�s�ө���">���ܲ�</font><font size="2"><input type="text" name="page" size="5" style="font-size: 10pt; position: relative; width: 40; height: 20" value="1"></font><font face="�ө���">��</font><font size="2"><input type="submit" value="�T�w" name="B1" style="font-size: 8pt; position: relative; width: 50; height: 22; left: 1; top: 0; letter-spacing: 3"></p>
<input type="hidden" name="id" value="<%=id%>">
</form>


  </font>


</body>

</html>










