/*
YouTube ADS Remove

Surge4.0:
[Script]
# 如果您是 YouTube Premium，请不要开启此模块。
youtube_ad = type=http-request,pattern=^https?:\/\/.+?\.googlevideo\.com\/.+&(oad|ctier)=(?!A),script-path=https://raw.githubusercontent.com/SavileLee/Profiles/Rules/FilterRules/X/Scripts/YouTube.js

QX 1.0.0:
^https?:\/\/.+?\.googlevideo\.com\/.+&(oad|ctier)=(?!A) url script-request-header https://raw.githubusercontent.com/SavileLee/Profiles/Rules/FilterRules/X/Scripts/YouTube.js

Surge & QX Mitm = *.googlevideo.com
*/

if ($request.url.indexOf("&oad") != -1) {
  $done({ response: {body: ""} });
} else if ($request.url.indexOf("&ctier") != -1) {
  let url = $request.url.replace(/ctier=[A-Z]/, "ctier=A");
  $done({ response: { status: 302, headers: { Location: url } } });
} else {
  $done({})
}
