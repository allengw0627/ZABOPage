Imports System.Web.Services
Imports System.IO
Partial Class _Default
    Inherits System.Web.UI.Page
    Public Shared dbconn As String = "provider=SQLOLEDB;database=chat;server=compaq-web\SQLEXPRESS;user id=ChelseaChat;pwd=Chelsea12"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub
    <WebMethod()> _
     Public Shared Function Logout(ByVal handle As String) As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        Logout = "False"
        ls.Open(dbconn)
        rs.Open("select * from info where username='" & handle & "'", ls, 1, 3, 1)
        If Not rs.EOF Then
            rs("loggedin").Value = "N"
            rs.Update()
            Logout = "True"
        End If
        rs.Close()
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function CreateAccount(ByVal fn As String, ByVal ln As String, ByVal handle As String, ByVal password As String) As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        CreateAccount = "False"
        ls.Open(dbconn)
        rs.Open("select * from info where username='" & handle & "' and password='" & password & "'", ls, 1, 3, 1)
        If rs.EOF Then
            CreateAccount = "True"
            rs.AddNew()
            rs("firstname").Value = fn
            rs("lastname").Value = ln
            rs("username").Value = handle
            rs("password").Value = password
            rs.Update()
        End If
        rs.Close()
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function Auth(ByVal handle As String, ByVal pwd As String) As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        Auth = "Invalid Username/password"
        ls.Open(dbconn)
        rs.Open("select * from info where username='" & handle & "' and password='" & pwd & "'", ls, 1, 3, 1)
        If Not rs.EOF Then
            If rs("loggedin").Value = "N" Then
                rs("loggedin").Value = "Y"
                rs("usrtimestamp").Value = Now
                rs.Update()
                Auth = "True"
            Else
                Auth = "Already Logged in"
            End If
        End If
        rs.Close()
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function SubmitText(ByVal text As String, ByVal handle As String) As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        ls.Open(dbconn)
        rs.Open("select * from record where 1=2", ls, 1, 3, 1)
        rs.AddNew()
        rs("entry").Value = text
        rs("username").Value = handle
        rs("timestamp").Value = Now
        rs.Update()
        rs.Close()
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function Count() As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset

        ls.Open(dbconn)
        ls.Execute("update count set cnt=cnt+1")
        ls.Close()
    End Function
    <WebMethod()> _
    Public Shared Function UpdateWindow(ByVal time As String, ByVal handle As String) As String
        Dim ls As New ADODB.Connection
        Dim rs As New ADODB.Recordset
        Dim loggedin As String = ""
        UpdateWindow = ""
        ls.Open(dbconn)
        rs.Open("select * from record where timestamp > '" & time & "' order by timestamp DESC", ls)
        If Not rs.EOF Then UpdateWindow = rs("entry").Value & "|" & rs("timestamp").Value & "|" & rs("username").Value
        rs.Close()
        rs.Open("select usrtimestamp from info where username='" & handle & "'", ls, 1, 3, 1)
        If Not rs.EOF Then
            rs(0).Value = Now
            rs.Update()
        End If
        rs.Close()
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
