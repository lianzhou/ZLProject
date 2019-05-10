//
//  Constant.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define kDefaultAvatar  @"icon_defaultAvatar"
#define kLogoDefault  @"icon_logo"
#define kplaceholderImage  @"icon_placeholderImage"

#pragma mark - 温馨提示
#define kTipPhone @"手机号输入有误"

//bgcolor=\"#F5F5F5\" tr><th
#define  khtmlHeadString   @"<body   style=\"word-wrap:break-word; font-family:Arial\"><head><style>img{max-width: 100%;height:auto;display:block;}</style><style>video{max-width: 100%;height:auto;display:block;}</style><meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no\" /></head>\
<style type=\"text/css\">\
tr{display:flex;border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;border-top:1px solid #e0e0e0}\
th{background:#f0f0f0;border-top:1px solid #e0e0e0}\
td,th{flex:1;padding:5px;font-size:28rpx;border-left:1px solid #e0e0e0;word-break:break-all}</style>"

//js方法遍历图片添加点击事件 返回图片个数
#define khtmlJsGetImages @"function getImages(){\
var objs = document.getElementsByTagName(\"img\");\
for(var i=0;i<objs.length;i++){\
objs[i].onclick=function(){\
document.location=\"myweb:imageClick:\"+this.src;\
};\
};\
return objs.length;\
}\
function getImageRect(i){\
var imgs = document.getElementsByTagName(\"img\");\
var rect;\
rect = imgs[i].getBoundingClientRect().left+\"::\";\
rect = rect+imgs[i].getBoundingClientRect().top+\"::\";\
rect = rect+imgs[i].width+\"::\";\
rect = rect+imgs[i].height;\
return rect;\
}\
function getImageData(i){\
var imgs = document.getElementsByTagName(\"img\");\
var img=imgs[i]; \
var canvas=document.createElement(\"canvas\"); \
var context=canvas.getContext(\"2d\"); \
canvas.width=img.width; canvas.height=img.height; \
context.drawImage(img,0,0,img.width,img.height); \
return canvas.toDataURL(\"image/png\") \
}\
function pause() { \
var audios = document.getElementsByTagName(\"audio\");\
for (var i = 0; i < audios.length; i++) {\
var audio = audios[i];\
audio.pause();}\
}\
function getVideos () {\
var videos = document.getElementsByTagName(\"video\");\
for (var i = 0; i < videos.length; i++) {\
var video = videos[i];\
var url = video.src;\
url = url + \"#t=1\";\
video.src = url;}\
}\
"


#endif /* Constant_h */
