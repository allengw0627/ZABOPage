﻿currentCamera1 = 1;
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