<%@ Page Language="VB" AutoEventWireup="false" CodeFile="zabomusic.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 5.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="jplayer.blue.monday.css" />
    <title>ZABOCASH: HOME</title>
    <script type="text/javascript" src="jquery-1.10.2.js"></script>
    <script type="text/javascript" src="jquery.jplayer.min.js" ></script>
    <script type="text/javascript">
        var timer;
        $(document).ready(function() {
            $("#Logo").animate({ opacity: 1 }, 1000); $("#HTB").focus();
            $("#LBut").click(function() {
                PageMethods.Auth($("#HTB").val(), $("#PwdTB").val(), function(r) { if (r == "True") { $("#LTbl").hide(); $("#MTbl").show(); timer = setInterval(refreshwindow, 1000) } else { alert(r) } });
            });
            $("#LoBtn").click(function() { PageMethods.Logout($("#HTB").val(), function(r) { $("#HTB").val(''); $("#PwdTB").val(''); $("#LTbl").show(); $("#MTbl").hide(); $("#CTbl").empty() }) });
            $("#ChatTA").keyup(function(result) { if (result.which == 13) { textsubmit() } });
            PageMethods.Count();
        });
        function textsubmit() {PageMethods.SubmitText($("#ChatTA").val(), $("#HTB").val(), function(r) { $("#ChatTA").val('') })};
        function refreshwindow() {
            PageMethods.UpdateWindow($("#TimeRec").val(), $("#HTB").val(), function(r) {
                var ra = r.split("||"); $("#LICell").empty().append(ra[1]);
                if (ra[0] != "") {
                    var p = ra[0].split("|"); $("#CTbl").append("<tr><td>" + p[1] + " " + p[2] + ": " + p[0] + "</td></tr>");
                    $('#CDiv').scrollTop($('#CDiv').height()); $("#TimeRec").val(p[1]);$("#Aud").get(0).play()
                };
            });
        };
        function CreateAcct() {
            PageMethods.CreateAccount($("#FNTB").val(), $("#LNTB").val(), $("#CreateHandleTB").val(), $("#CreatePassTB").val(), function(r) {
                if (r == "True") { alert("Account Created!  Log on with new handle/password"); $('#LTbl').show(); $('#SignupTable').hide(); } else { alert("Error Creating Account") };
                $("#CreateHandleTB").val(''); $("#CreatePassTB").val('');
            });
        };
</script>

<!--Stuff for streaming video -->

<script type="text/javascript">
    var height_array = new Array();
    var width_array = new Array();
    width_array[1] = 320;
    height_array[1] = 240;
</script>


<style>
.shadow{-moz-box-shadow: 0px 0px 20px #777;-webkit-box-shadow: 0px 0px 20px #777;box-shadow: 0px 0px 20px #777;}
.Dialog{-moz-box-shadow: 0 0 3px #ccc; -webkit-box-shadow: 0 0 3px #ccc;box-shadow: 0 0 10px #ccc;width:1%;margin-left:auto;margin-right:auto;}
</style>
</head>
<body style="background-image: url('dark1.jpg');color:White">
    <form id="form1" runat="server">
    <table style="margin:auto;"><tr>
    <td colspan="6"><a href="https://soundcloud.com/zabocashmusic" target="_blank"><img style="width: 50px; height: 50px" src="soundcloud.jpg" alt="SC" /></a>
            <a href="https://twitter.com/zabocash" target="_blank"><img style="width: 50px; height: 50px" src="twitter.png" alt="twitter" /></a></td></tr>
    </table>
    <img id="Logo" style="display:block; opacity:0;margin: auto;width:500px;height:400px" alt="zabocash" runat="server" src="ZCBlack.jpg" />
    <table id="MusicTbl" style="margin:auto">
    <tr>
    <td style="font-size: xx-large;text-align:center" >NEW MIXES!</td>
    </tr>
    <tr><td style="font-size: xx-large" colspan="3"><a href="http://www.zabocash.com/music/zabocashtranceathon(1-25-14).mp3">Tranceathon 1-25-14</a></td></tr>
    <tr><td style="font-size: xx-large" colspan="3"><a href="http://www.zabocash.com/music/ZMixJanuary2014.mp3">ZMix January 2014</a></td></tr>
    <tr><td style="font-size: xx-large" colspan="3"><a href="http://www.zabocash.com/music/ZMixFebruary2014.mp3">ZMix February 2014</a></td></tr>
    <tr><td style="font-size: xx-large" colspan="3"><a href="http://www.zabocash.com/music/zabocashlivemix(2-16-14).mp3">Tech House mix Feb 16, 2014 (just because)</a></td></tr>
    
    </table>
    <table id="StreamTbl" style="margin:auto; width: 1%">
    <tr>
        <td colspan="2" style="text-align:center">
               <a href="http://50.181.15.248:84/broadwave.m3u?src=1&rate=1">Click to Listen!!</a></td></tr><tr>
        <td><img src="http://50.181.15.248:8080/?src=1&mode=3" class="webcam" id="webcam1" onmousedown="PTZMouseDown1(event)" width="620" height="440" alt="Live Stream" /></td>
    </tr>
    </table>
    <div>
        <table id="MTbl" class="Dialog " style="color:Black; display:none;width:50%;border-width:thin;border-style:ridge ">
        <tr>
        <td><div id="CDiv" style="width:700px;height:200px;max-height:200px; background-color:white;overflow-y:scroll;"><table id="CTbl" ></table></div></td>
        <td id="LICell"></td>
        </tr>
        <tr><td><textarea cols="20" rows="3" id="ChatTA"></textarea></td></tr>
        <tr><td><input type="button" id="SendButton" value="Send" onclick="textsubmit();"/><input type="button" id="LoBtn" value="Logout"/></td></tr>
        <tr><td><input runat="server" type="text" id="TimeRec" style="display:none" /></td></tr>
        </table>
        <table id="LTbl" class="Dialog">
        <tr>
        <td>
            Logon to chat: <input type="text" id="HTB" />      
        </td>
        </tr>
        <tr>
        <td>Password: <input type="password" id="PwdTB" /></td>
        </tr>
        <tr>
        <td><input type="button" id="LBut" value="Logon" /></td><td><a href="javascript:;" onclick="$('#LTbl').hide();$('#SignupTable').show();">dont have an account?</a></td>
        </tr>
        </table>
        
        <table id="SignupTable" class="Dialog" style="display:none">
        <tr>
        <td>Handle: <input type="text" id="CreateHandleTB" /></td>
        </tr>
        <tr>
        <td>Password: <input type="password" id="CreatePassTB" /></td>
        </tr>
        <tr>
        <td>First Name: <input type="text" id="FNTB" /></td>
        </tr>
        <tr>
        <td>Last Name: <input type="text" id="LNTB" /></td>
        </tr>
        <tr>
        <td><input type="button" id="CreateAccountButton" value="Create Account" onclick="CreateAcct();" /></td>
        <td><input type="button" id="CancelCreateButton" value="Cancel" onclick="$('#LTbl').show(); $('#SignupTable').hide();" /></td>
        </tr>
        </table>
        <audio id="Aud" src="VEH2 Synths - 004 C.wav"></audio>
    </div>
    Audio Streamed by the
<a href="http://www.nch.com.au/streaming/index.html">BroadWave Streaming Audio Server</a>
by <a href="http://www.nch.com.au/index.html">NCH Software</a>.
       
        <!--<div id="jquery_jplayer_1" class="jp-jplayer">
        </div>
        <div id="jp_container_1" class="jp-audio" style="margin-left: auto; margin-right: auto">
            <div class="jp-type-single">
                <div class="jp-gui jp-interface">
                    <ul class="jp-controls">
                        <li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
                        <li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
                        <li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
                        <li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
                        <li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
                        <li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max
                            volume</a></li>
                    </ul>
                    <div class="jp-progress">
                        <div class="jp-seek-bar">
                            <div class="jp-play-bar">
                            </div>
                        </div>
                    </div>
                    <div class="jp-volume-bar">
                        <div class="jp-volume-bar-value">
                        </div>
                    </div>
                    <div class="jp-time-holder">
                        <div class="jp-current-time">
                        </div>
                        <div class="jp-duration">
                        </div>
                        <ul class="jp-toggles">
                            <li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
                            <li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat
                                off</a></li>
                        </ul>
                    </div>
                </div>
                <div class="jp-title">
                    <ul>
                        <li>Control</li>
                    </ul>
                </div>
                <div class="jp-no-solution">
                    <span>Update Required</span> To play the media you will need to either update your
                    browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/"
                        target="_blank">Flash plugin</a>.
                </div>
            </div>
        </div>
    
    <table style="margin:auto"><tr><td>
    <iframe style="margin:auto;border:0px; width: 1000px; height: 500px" src="http://chelsea-chat.com"></iframe>
    </td></tr></table> 

<!-- moar Stuff for streaming video -->

<script type="text/javascript">
<!--
    currentCamera1 = 1;
    errorimg1 = 0;
    document.images.webcam1.onload = DoIt1;
    document.images.webcam1.onerror = ErrorImage1;
    function LoadImage1() {
        uniq1 = Math.random();
        document.images.webcam1.src = "http://50.181.15.248:8080/cam_" + currentCamera1 + ".jpg?&uniq=" + uniq1;
        document.images.webcam1.onload = DoIt1;
    }
    function PTZMouseDown1(e) {
        var IE = document.all ? true : false;
        var x, y;
        var myx, myy;
        var myifr = document.getElementById("_iframe-ptz");
        tp = getElPos1();
        myx = tp[0];
        myy = tp[1];
        if (IE) {
            var scrollX = document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft;
            var scrollY = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;
            x = event.clientX - myx + scrollX;
            y = event.clientY - myy + scrollY;
        } else {
            x = e.pageX - myx;
            y = e.pageY - myy;
        }
        if ((width_array[currentCamera1] != null) && (width_array[currentCamera1] > 0)) x = Math.round((x * 400) / width_array[currentCamera1]);
        if ((height_array[currentCamera1] != null) && (height_array[currentCamera1] > 0)) y = Math.round((y * 300) / height_array[currentCamera1]);
        if (x > 400) x = 400;
        if (y > 300) y = 300;
        if (myifr != null) myifr.src = "http://50.181.15.248:8080/ptz?src=" + currentCamera1 + "&moveto_x=" + x + "&moveto_y=" + y + "";
        return true;
    }
    function getElPos1() {
        el = document.images.webcam1;
        x = el.offsetLeft;
        y = el.offsetTop;
        elp = el.offsetParent;
        while (elp != null) {
            x += elp.offsetLeft;
            y += elp.offsetTop;
            elp = elp.offsetParent;
        }
        return new Array(x, y);
    }
    function ErrorImage1() {
        errorimg1++;
        if (errorimg1 > 3) {
            document.images.webcam1.onload = "";
            document.images.webcam1.onerror = "";
            document.images.webcam1.src = "offline.jpg";
        } else {
            uniq1 = Math.random();
            document.images.webcam1.src = "http://50.181.15.248:8080/cam_" + currentCamera1 + ".jpg?uniq=" + uniq1;
        }
    }
    function DoIt1() {
        errorimg1 = 0;
        window.setTimeout("LoadImage1();", 40);
    }
//-->
</script>
    

    
        
             
       
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    </form>
</body>
</html>
