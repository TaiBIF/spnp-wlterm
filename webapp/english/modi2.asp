<!--#include file="conn.asp "-->
<%
 modi=request("B1")
name=request("username")
password=request("password")
if modi="�ס@��" then
  id=request("id")
  Minimum_Elevation=request("Minimum_Elevation")
  latitude=request("latitude")
  Maximum_Elevation=request("Maximum_Elevation")
  longitude=request("longitude")
  Minimum_Depth=request("Minimum_Depth")
  Coordinate_Precision=request("Coordinate_Precision")
  Maximum_Depth=request("Maximum_Depth")
  Locality=request("Locality")
  PP=request("���ѥ��Ű�")
  Locality_chinese=request("Locality_chinese")
  TT=request("���g���Ű�")
  Locality_describe=request("Locality_describe")
  if id=""  then
   response.write "���������n��줣�i�ť�"
   response.end 
  end if
  sql="select * from station where id=" & id
  rs.open sql,conn,1,3
  rs("id")=id
  rs("Minimum_Elevation")=Minimum_Elevation
  rs("latitude")=latitude
  rs("Maximum_Elevation")=Maximum_Elevation
  rs("longitude")=longitude
  rs("Minimum_Depth")=Minimum_Depth
  rs("Coordinate_Precision")=Coordinate_Precision
  rs("Maximum_Depth")=Maximum_Depth
  rs("Locality")=Locality
  rs("���ѥ��Ű�")=PP
  rs("Locality_chinese")=Locality_chinese
  rs("���g���Ű�")=TT
  rs("Locality_describe")=Locality_describe
  rs.update
end if
 response.redirect "modi.asp?id=" & id & "&name=" & name & "&password=" & password & "&modi=Y"
%>