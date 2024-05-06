QQVersion="$(<QQVersion)"

qss_setgcqver(){ echo -n '{
  "apk_id": "com.tencent.mobileqq",
  "app_id": '"$2"',
  "sub_app_id": '"$2"',
  "app_key": "0S200MNJT807V3GE",
  "sort_version_name": "'"$sort_version_name"'",
  "build_time": '"$build_time"',
  "apk_sign": "a6b745bf24a2c277527716f6f36eb68d",
  "sdk_version": "'"$sdk_version"'",
  "sso_version": 20,
  "misc_bitmap": 150470524,
  "main_sig_map": 34869472,
  "sub_sig_map": 66560,
  "dump_time": '"$build_time"',
  "qua": "'"$qua"'",
  "protocol_type": '"$1
}">"$1.json";}

qss_gcqver(){ case "$QQVersion" in
"8.9.88")sort_version_name="8.9.88.13035"
  app_id="537182769"
  pad_app_id="537182808"
  build_time="1697015435"
  sdk_version="6.0.0.2556"
  qua="V1_AND_SQ_8.9.88_4852_YYB_D";;
"8.9.85")sort_version_name="8.9.85.12820"
  app_id="537180568"
  pad_app_id="537180607"
  build_time="1697015435"
  sdk_version="6.0.0.2556"
  qua="V1_AND_SQ_8.9.85_4766_YYB_D";;
"8.9.83")sort_version_name="8.9.83.12605"
  app_id="537178646"
  pad_app_id="537178685"
  build_time="1691565978"
  sdk_version="6.0.0.2554"
  qua="V1_AND_SQ_8.9.83_4680_YYB_D";;
"8.9.80")sort_version_name="8.9.80.12440"
  app_id="537176863"
  pad_app_id="537176902"
  build_time="1691565978"
  sdk_version="6.0.0.2554"
  qua="V1_AND_SQ_8.9.80_4614_YYB_D";;
"8.9.78")sort_version_name="8.9.78.12275"
  app_id="537175315"
  pad_app_id="537175354"
  build_time="1691565978"
  sdk_version="6.0.0.2554"
  qua="V1_AND_SQ_8.9.78_4548_YYB_D";;
"8.9.76")sort_version_name="8.9.76.12115"
  app_id="537173477"
  pad_app_id="537173525"
  build_time="1691565978"
  sdk_version="6.0.0.2554"
  qua="V1_AND_SQ_8.9.76_4484_YYB_D";;
"8.9.73")sort_version_name="8.9.73.11945"
  app_id="537171689"
  pad_app_id="537171737"
  build_time="1690371091"
  sdk_version="6.0.0.2553"
  qua="V1_AND_SQ_8.9.73_4416_YYB_D";;
"8.9.71")sort_version_name="8.9.71.11735"
  app_id="537170024"
  pad_app_id="537170072"
  build_time="1688720082"
  sdk_version="6.0.0.2551"
  qua="V1_AND_SQ_8.9.71_4332_YYB_D";;
"8.9.68")sort_version_name="8.9.68.11565"
  app_id="537168313"
  pad_app_id="537168361"
  build_time="1687254022"
  sdk_version="6.0.0.2549"
  qua="V1_AND_SQ_8.9.68_4264_YYB_D";;
"8.9.63")sort_version_name="8.9.63.11390"
  app_id="537164840"
  pad_app_id="537164888"
  build_time="1685069178"
  sdk_version="6.0.0.2546"
  qua="V1_AND_SQ_8.9.63_4194_YYB_D";;
*)msgbox "go-cqhttp 不支持该版本";return
esac
cd "$DIR/go-cqhttp"
GCQDir="$(ls */config.yml|sed "s|/config.yml$||")"
[ -n "$GCQDir" ]||{ msgbox "未找到账号";return;}
if [ "$(wc -l<<<"$GCQDir")" != 1 ];then
  Choose="$(eval menubox "'- 请选择账号' $(n=1;while read i;do echo -n "$n \"$i\" ";((n++));done<<<"$GCQDir")")"||return
  GCQDir="$(sed -n "${Choose}p"<<<"$GCQDir")"
fi
mkcd "$GCQDir/data/versions"
qss_setgcqver 1 "$app_id"
qss_setgcqver 6 "$pad_app_id"
msgbox "账号 $GCQDir 写入版本 $QQVersion 成功";}

qss_version(){ [ -n "$QQVersion" ]&&[ -d "txlib/$QQVersion" ]||{
Choose="$(menubox "- 请选择 QQ 版本"\
  1 "QQ 8.9.88"\
  2 "QQ 8.9.85"\
  3 "QQ 8.9.83"\
  4 "QQ 8.9.80"\
  5 "QQ 8.9.78"\
  6 "QQ 8.9.76"\
  7 "QQ 8.9.73"\
  8 "QQ 8.9.71"\
  9 "QQ 8.9.68"\
  10 "QQ 8.9.63"\
  11 "TIM 3.5.2"\
  12 "TIM 3.5.1")"||return
case "$Choose" in
  1)QQVersion=8.9.88;;
  2)QQVersion=8.9.85;;
  3)QQVersion=8.9.83;;
  4)QQVersion=8.9.80;;
  5)QQVersion=8.9.78;;
  6)QQVersion=8.9.76;;
  7)QQVersion=8.9.73;;
  8)QQVersion=8.9.71;;
  9)QQVersion=8.9.68;;
  10)QQVersion=8.9.63;;
  11)QQVersion=3.5.2;;
  12)QQVersion=3.5.1
esac
echo -n "$QQVersion">QQVersion
yesnobox "是否写入 go-cqhttp"&&qss_gcqver
cd "$HOME/QSignServer";};}

qss_start(){ tmux_start_quiet QSignServer
until curl http://localhost:2535;do sleep 3;echo -n "[F";done
tmux selectw -l;}

qss_menu(){ Choose="$(menubox "QSignServer 1.1.9-$QQVersion (202311070)"\
  1 "打开 QSignServer"\
  2 "启动 QSignServer"\
  3 "停止 QSignServer"\
  4 "写入 go-cqhttp"\
  5 "切换版本"\
  6 "文件管理"\
  7 "检查更新"\
  8 "前台启动"\
  9 "删除 QSignServer"\
  0 "返回")"
case "$Choose" in
  1)tmux_attach QSignServer;;
  2)tmux_start QSignServer;;
  3)tmux_stop QSignServer;;
  4)qss_gcqver;;
  5)rm -vrf QQVersion;;
  6)file_list;;
  7)git_update;back;;
  8)fg_start QSignServer;;
  9)yesnobox "确认删除 QSignServer？"&&{ rm -vrf "$HOME/QSignServer";return;};;
  *)return
esac;qss;}

qss_version||return
case "$1" in
  start)qss_start;;
  return)return;;
  *)qss_menu
esac