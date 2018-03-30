<%@ Page Language="VB" AutoEventWireup="false" CodeFile="zabomusic.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 5.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ZABOCASH: HOME</title>
    <script type="text/javascript" src="jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="amue_ajax.js"></script>
    <script type="text/javascript">
        var timer;
        var msg = "";
        $(window).load(function () {
            $("#logo").fadeIn(1000);
            $("#clog_frm").submit(function (e) { e.preventDefault(); PageMethods.auth(dodata('clog_frm'), function (r) { if (r != "") { alert(r) } else { $("#LTbl").fadeOut(500, function () { $("#MTbl").fadeIn(500, function () { timer = setInterval(refreshwindow, 1000); scrolldown() }) }) } }) });
            $("#ChatTA").keyup(function (r) { if (r.which == 13) { text() } });
            $("#create_frm").submit(function (e) { e.preventDefault(); PageMethods.create(dodata('create_frm'), function (r) { alert("Account Created!  Log on with new handle/password"); location.reload() }) });
        });
        function text() { PageMethods.SubmitText($("#ChatTA").val(), $("#HTB").val(), function (r) { $("#ChatTA").val('') }) };
        function refreshwindow() {
            PageMethods.UpdateWindow($("#TimeRec").val(), $("#HTB").val(), function (r) {
                var ra = r.split("||"); $("#LICell").html(ra[1]);
                if (ra[0] != "") {
                    var p = ra[0].split("|"); $("#CTbl").append("<tr><td>" + p[1] + " " + p[2] + ": " + p[0] + "</td></tr>");
                    $('#CDiv').scrollTop($('#CDiv').height()); $("#TimeRec").val(p[1]); $("#Aud").get(0).play()
                }
            })
        }
        function loadchat() { $("#zchat").fadeOut(500, function () { $("#ccell").fadeIn(500, function () { scrolldown() }) }) }
        function scrolldown() { $('html, body').animate({ scrollTop: $(document).height() - $(window).height() }, 500) }
    </script>
    <script type="text/javascript">
        var height_array = new Array();
        var width_array = new Array();
        width_array[1] = 320;
        height_array[1] = 240;
    </script>
    <style>
        .shadow
        {
            -moz-box-shadow: 0px 0px 20px #777;
            -webkit-box-shadow: 0px 0px 20px #777;
            box-shadow: 0px 0px 20px #777;
        }

        .Dialog
        {
            -moz-box-shadow: 0 0 3px #ccc;
            -webkit-box-shadow: 0 0 3px #ccc;
            box-shadow: 0 0 10px #ccc;
            width: 1%;
            margin: auto;
        }

        .piclink
        {
            box-shadow: 0 0 10px #000000;
            width: 50px;
            height: 50px;
            transition: transform 0.0s;
        }

            .piclink:hover
            {
                transform: scale(1.1);
            }
    </style>
</head>
<body style="background-image: url('dark1.jpg'); color: White; margin: 0px">

    <img id="logo" style="width: 100%; height: 1000px; box-shadow: 0 5px 20px #000000; display: none;min-width:2000px" src="zabo.jpg" />

    <table style="position: absolute; left: 250px; top: 200px; color: black">
        <tr>
            <td>
                <iframe width="100%" height="450" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/users/46903041&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>
                <table>
                    <tr>
                        <td>
                            <iframe width="660" height="180" src="//www.mixcloud.com/widget/iframe/?feed=http%3A%2F%2Fwww.mixcloud.com%2Fgregory-wayne-allen%2Fplaylists%2Fmixes%2F&amp;embed_uuid=5617e681-b01d-4dd9-9955-17a0e5ff95ab&amp;replace=0&amp;hide_cover=1&amp;embed_type=widget_standard&amp;hide_tracklist=1" frameborder="0"></iframe>
                
                            <div style="clear: both; height: 3px; width: 652px;"></div>
                            <p style="display: block; font-size: 11px; font-family: 'Open Sans', Helvetica, Arial, sans-serif; margin: 0px; padding: 3px 4px; color: rgb(153, 153, 153); width: 652px;"><a href="http://www.mixcloud.com/gregory-wayne-allen/playlists/mixes/?utm_source=widget&amp;amp;utm_medium=web&amp;amp;utm_campaign=base_links&amp;amp;utm_term=resource_link" target="_blank" style="color: #808080; font-weight: bold;">Mixes</a><span> by </span><a href="http://www.mixcloud.com/gregory-wayne-allen/?utm_source=widget&amp;amp;utm_medium=web&amp;amp;utm_campaign=base_links&amp;amp;utm_term=profile_link" target="_blank" style="color: #808080; font-weight: bold;">Gregory Wayne Allen</a><span> on </span><a href="http://www.mixcloud.com/?utm_source=widget&amp;utm_medium=web&amp;utm_campaign=base_links&amp;utm_term=homepage_link" target="_blank" style="color: #808080; font-weight: bold;">Mixcloud</a></p>
                            <div style="clear: both; height: 3px; width: 652px;"></div>
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                </table>

                <a href="https://twitter.com/zabocash" target="_blank">
                    <img class="piclink" src="twitter.png" alt="twitter" /></a>
                <a href="https://www.facebook.com/gregory.w.allen.31" target="_blank">
                    <img class="piclink" src="facebook.png" alt="fb" /></a>
                Audio Streamed by the
        <a href="http://www.nch.com.au/streaming/index.html">BroadWave Streaming Audio Server</a>
                by <a href="http://www.nch.com.au/index.html">NCH Software</a>.
            </td>
        </tr>
    </table>
    <br /><br /><br />
    <div id="zchat" style="width:100%;text-align:center"><h1><a href="javascript:;" onclick="loadchat()">Zabo-chat</a></h1></div>
    <div id="ccell" style="width:100%;display:none">
         <form id="clog_frm">
    <table id="LTbl" class="Dialog">
        <tr>
            <td>logon to chat:
                        <input type="text" id="HTB" name="htb" />
            </td>
        </tr>
        <tr>
            <td>Password:
                        <input type="password" id="PwdTB" name="pwdtb" /></td>
        </tr>
        <tr>
            <td>
                <input type="submit" value="logon" /></td>
            <td><a href="javascript:;" onclick="$('#LTbl').hide();$('#SignupTable').show();">dont have an account?</a></td>
        </tr>
    </table>
</form>
<table id="MTbl" class="Dialog " style="color: Black; display: none; width: 50%; border-width: thin; border-style: ridge">
    <tr>
        <td>
            <div id="CDiv" style="width: 700px; height: 200px; max-height: 200px; background-color: white; overflow-y: scroll;">
                <table id="CTbl"></table>
            </div>
        </td>
        <td id="LICell"></td>
    </tr>
    <tr>
        <td>
            <textarea cols="20" rows="3" id="ChatTA"></textarea></td>
    </tr>
    <tr>
        <td>
            <input type="button" value="Send" onclick="text();" /><input type="button" value="logout" onclick="    PageMethods.logout($('#HTB').val(), function (r) { location.reload() })" /></td>
    </tr>
    <tr>
        <td>
            <input runat="server" type="text" id="TimeRec" style="display: none" /></td>
    </tr>
</table>
<form id="create_frm">
    <table id="SignupTable" class="Dialog" style="display: none">
        <tr>
            <td>Handle:
                        <input type="text" id="CreateHandleTB" name="chtb" /></td>
        </tr>
        <tr>
            <td>Password:
                        <input type="password" id="CreatePassTB" name="cpwdtb" /></td>
        </tr>
        <tr>
            <td>First Name:
                        <input type="text" id="FNTB" name="fntb" /></td>
        </tr>
        <tr>
            <td>Last Name:
                        <input type="text" id="LNTB" name="lntb" /></td>
        </tr>
        <tr>
            <td>
                <input type="submit" value="Create Account" /></td>
            <td>
                <input type="button" id="CancelCreateButton" value="Cancel" onclick="location.reload()" /></td>
        </tr>
    </table>
</form>
    </div>

    <table style="padding: 30px; width: 100%; text-align: center; color: grey">
        <tr>
            <td>© zabocash 2014</td>
        </tr>
    </table>
    <audio id="Aud" src="VEH2 Synths - 004 C.wav"></audio>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
