<%
set rs=server.createobject("adodb.recordset")
set conn=server.createobject("adodb.connection")  
provider="provider=microsoft.jet.oledb.4.0;"  
dbpath="data source=" & server.mappath("\WLTERM.mdb")             
conn.open provider & dbpath  
%>