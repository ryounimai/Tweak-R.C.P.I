#!/system/bin/sh

# minimalist installer – by @Ryounime

p() { ui_print "$1"; usleep ${2:-40000}; }        # print + delay (default 40ms)
sl() { usleep 60000; }                            # section delay (60ms)
sm() { usleep 30000; }                            # micro delay (30ms)

p ""
p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sl
p "⚙️  Installing Tweak R.C.P.I"; sm
p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sl

MODID=$(grep_prop id $MODPATH/module.prop)
MODNAME=$(grep_prop name $MODPATH/module.prop)
MODVER=$(grep_prop version $MODPATH/module.prop)
MODPATCH=$(grep_prop versionPatch $MODPATH/module.prop)
MODCODE=$(grep_prop versionCode $MODPATH/module.prop)
MODDATE=$(grep_prop releaseDate $MODPATH/module.prop)
MODAUTH=$(grep_prop author $MODPATH/module.prop)
MODDESC=$(grep_prop description $MODPATH/module.prop)
MODAXERON=$(grep_prop axeronPlugin $MODPATH/module.prop)

p "📦 ID          : $MODID"; sm
p "🧩 Name        : $MODNAME"; sm
p "🔢 Version     : $MODVER ($MODPATCH)"; sm
p "💾 VersionCode : $MODCODE"; sm
p "📅 ReleaseDate : $MODDATE"; sm
p "👤 Author      : $MODAUTH"; sm
p "🔧 AxeronCode  : $MODAXERON"; sm
p ""; sm
p "📝 Description :"; sm
p "   $MODDESC"; sl
p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sl

set_perm_recursive $MODPATH 0 0 0755 0644

if [ -f "$MODPATH/service.sh" ]; then
  p ""; sl
  p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sm
  p "service.sh Execution Confirmation"; sl
  p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sl
  p "🇮🇩 Menyetujui berarti sistem akan dimodifikasi:"; sm
  p "   • Angle driver dipaksakan ke aplikasi user"; sm
  p "   • Cutout diterapkan ke semua user app"; sm
  p "   • Konfigurasi game overlay diubah"; sm
  p ""; sm
  p "🇬🇧 Agreeing means system modification:"; sm
  p "   • Angle driver forced to user apps"; sm
  p "   • Cutout applied to all user apps"; sm
  p "   • Game overlay configuration modified"; sl
  p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sl
  p "Volume UP = Yes | Volume DOWN = No"; sm
  p "Waiting 10s..."; sl

  keycheck() {
    getevent -lc 1 2>&1 | grep "KEY_VOLUME" >/dev/null || return 0
    getevent -lc 1 2>&1 | grep "KEY_VOLUMEUP" >/dev/null && return 1
    getevent -lc 1 2>&1 | grep "KEY_VOLUMEDOWN" >/dev/null && return 2
    return 0
  }

  choose() {
    local t=10 c=0
    while [ $c -lt $t ]; do
      keycheck; SEL=$?
      [ "$SEL" != "0" ] && echo "$SEL" && return
      sleep 1; c=$((c+1))
    done
    echo "0"
  }

  SEL=$(choose); p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sl

  if [ "$SEL" == "1" ]; then
    p "▶️  Running service.sh..."; sl
    sh "$MODPATH/service.sh"
    p "✅ Done."; sl
  else
    p "⚠️  Skipped."; sl
  fi
fi

p ""; sl
p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sm
p "📱 Device Information"; sm
p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sl

BRAND=$(getprop ro.product.brand)
MODEL=$(getprop ro.product.model)
DEVICE=$(getprop ro.product.device)
MANUFACTURER=$(getprop ro.product.manufacturer)
ANDROID_VER=$(getprop ro.build.version.release)
API_LEVEL=$(getprop ro.build.version.sdk)
KERNEL_VER=$(uname -r)
BUILD_ID=$(getprop ro.build.display.id)
SOC_MODEL=$(getprop ro.soc.model)
SOC_MANU=$(getprop ro.soc.manufacturer)
ABI_LIST=$(getprop ro.product.cpu.abilist)
SELINUX=$(getenforce 2>/dev/null)
RUNTIME=$(getprop persist.sys.dalvik.vm.lib.2)

p "🏷️ Brand       : $BRAND"; sm
p "📱 Model       : $MODEL"; sm
p "🔧 Device      : $DEVICE"; sm
p "🏭 Manufacturer: $MANUFACTURER"; sm
p "⚙️ Android     : $ANDROID_VER (API $API_LEVEL)"; sm
p "🧠 SoC         : $SOC_MODEL ($SOC_MANU)"; sm
p "💾 ABI Support : $ABI_LIST"; sm
p "🐧 Kernel      : $KERNEL_VER"; sm
p "🔠 Build ID    : $BUILD_ID"; sm
p "☕ Runtime     : $RUNTIME"; sm
p "🛡️ SELinux     : $SELINUX"; sl

p ""; sm
p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sm
p "✅ Installation Completed"; sm
p "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; sl