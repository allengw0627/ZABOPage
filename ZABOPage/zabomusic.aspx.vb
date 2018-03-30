Imports System.Web.Services
Imports System.IO
Partial Class _Default
    Inherits System.Web.UI.Page
    Public Shared dbconn As String = "provider=SQLOLEDB;database=chat;server=compaq-web\SQLEXPRESS;user id=ChelseaChat;pwd=Chelsea12"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim ls As New ADODB.Connection
        ls.Open(dbconn)
        ls.Execute("update count set cnt=cnt+1")
        ls.Close()
    End Sub
    <WebMethod()> _
    Public Shared Function logout(handle As String) As String
        Dim ls As New ADODB.Connection
        ls.Open(dbconn)
        ls.Execute("update info set loggedin='N' where username='" & handle & "'")
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function create(fn As String, ln As String, handle As String, password As String) As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        ls.Open(dbconn)
        rs.Open("select * from info where username='" & handle & "' and password='" & password & "'", ls)
        If rs.EOF Then ls.Execute("insert into info values ('" & fn & "','" & ln & "','" & handle & "','" & password & "','N','" & Now & "')")
        rs.Close()
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function auth(i As Dictionary(Of String, String)) As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        auth = ""
        ls.Open(dbconn)
        rs.Open("select loggedin,usrtimestamp from info where username='" & i.Item("htb") & "' and password='" & i.Item("pwdtb") & "'", ls, 1, 3, 1)
        If Not rs.EOF Then
            If rs(0).Value = "N" Then
                rs(0).Value = "Y"
                rs(1).Value = Now
                rs.Update()
            Else
                auth = "Already Logged in"
            End If
        Else
            auth = "Invalid Login"
        End If
        rs.Close()
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function SubmitText(text As String, handle As String) As String
        Dim ls As New ADODB.Connection
        ls.Open(dbconn)
        ls.Execute("insert into record values ('" & text & "','" & handle & "','" & Now & "')")
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function UpdateWindow(time As String, handle As String) As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        Dim loggedin As String = ""
        UpdateWindow = ""
        ls.Open(dbconn)
        rs.Open("select * from record where timestamp > '" & time & "' order by timestamp DESC", ls)
        If Not rs.EOF Then UpdateWindow = rs("entry").Value & "|" & rs("timestamp").Value & "|" & rs("username").Value
        rs.Close()
        ls.Execute("update info set usrtimestamp='" & Now & "' where username='" & handle & "'")
        rs.Open("select username from info where loggedin='Y'", ls)
        If Not rs.EOF Then
            loggedin = "||<table>"
            Do While Not rs.EOF
                loggedin += "<tr><td>" & rs(0).Value & "</td></tr>"
                rs.MoveNext()
            Loop
            loggedin += "</table>"
            UpdateWindow += loggedin
        End If
        rs.Close()
        ls.Close()
    End Function
End Class
