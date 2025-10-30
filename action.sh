#!/system/bin/sh
#========================================
#  Tweak R.C.P.I - Action Script
#  Author: @Ryounime
#  Compatible with AxManager / Axeron Plugin
#========================================

MODDIR=${0%/*}
[ $AXERON ] && a()(sleep 0.01; printf "$@") || a()(sleep 0.01; echo "$@")
MOD_NAME=$(grep name= "$MODDIR/module.prop" | cut -d= -f2)
MOD_VERSION=$(grep version= "$MODDIR/module.prop" | cut -d= -f2)
MOD_AUTHOR=$(grep author= "$MODDIR/module.prop" | cut -d= -f2)
PID="$(pgrep -f "sh $MODDIR/service.sh" | head -n1)"
UPTIME=$(cut -d. -f1 /proc/uptime)
MEMINFO=$(cat /proc/meminfo | tr -s ' ')

a "***********************************************"
a "$MOD_NAME ($MOD_VERSION) by $MOD_AUTHOR"
a "***********************************************"
a " "

if [ -z "$PID" ] && [ -f "$MODDIR/service.sh" ]; then
  sh "$MODDIR/service.sh" &
  PID="$(pgrep -f "sh $MODDIR/service.sh" | head -n1)"
  a "[+] service.sh executed (PID $PID)"
else
  a "[•] service.sh already running (PID $PID)"
fi
if [ -n "$PID" ]; then
  a " "
  a "- Service: $PID"
  a "- CPU Usage: $(ps -eo %cpu,pid | grep "$PID" | grep -v grep | awk '{print $1}')%"
  a "- RES Usage: $(ps -eo res,pid | grep "$PID" | grep -v grep | awk '{print $1}')"
  a "- SHR Usage: $(ps -eo shr,pid | grep "$PID" | grep -v grep | awk '{print $1}')"
  a " "
fi

a "· OS: Android $(getprop ro.build.version.release)"
a "· Model: $(getprop ro.product.manufacturer) $(getprop ro.product.model)"
a "· Kernel: $(uname -r | cut -d- -f1,2,3)"
a "· Uptime: $((UPTIME/3600))h $((UPTIME%3600/60))m"
a "· Packages: $(cmd package list packages -s --user 0 | wc -l) (sys), $(cmd package list packages -3 --user 0 | wc -l) (apps)"
a "· Resolution: $(wm size | cut -d: -f2)"
a "· Theme: $(getprop ro.build.fingerprint | tr '/' '\n' | grep user | cut -d: -f1)"
a "· Terminal: $(cmd activity stack list | grep 0,0.*visible=true | tr -d ' ' | cut -d/ -f1 | cut -d: -f2)"
a "· CPU: $(getprop ro.soc.manufacturer) $(getprop ro.soc.model) ($(grep -c '^processor' /proc/cpuinfo)) @ $(awk '{printf("%.2f",$1/1000000)}' /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)GHz"
a "· GPU: $(dumpsys SurfaceFlinger | grep GLES: | cut -d, -f2)"
a "· Memory: $((($(echo "$MEMINFO" | grep MemTotal | cut -d' ' -f2) - $(echo "$MEMINFO" | grep MemAvailable | cut -d' ' -f2))/1024))MiB / $(($(echo "$MEMINFO" | grep MemTotal | cut -d' ' -f2)/1024))MiB"
a " "

if [ "$AXERON" ]; then
  a "[-] Open WebUI by clicking the module card."
elif [ -d /data/adb/ksu ]; then
  a "[-] Open WebUI by clicking the module card."
elif cmd package path io.github.a13e300.ksuwebui >/dev/null 2>&1; then
  a "[*] Launching KSU WebUI Standalone..."
  sleep 1
  cmd activity start -n "io.github.a13e300.ksuwebui/.WebUIActivity" -e id "$(grep id= "$MODDIR/module.prop" | cut -d= -f2)" >/dev/null 2>&1
else
  a "[!] Install KsuWebUI for WebUI access"
  sleep 3
  am start -a android.intent.action.VIEW -d "https://github.com/5ec1cff/KsuWebUIStandalone/releases" >/dev/null 2>&1
fi

a " "
a "[Tweak R.C.P.I] Initialization complete."