#!/system/bin/sh
# ==========================================
#  Tweak R.C.P.I Uninstaller Script
#  by @Ryounime
# ==========================================

ui_print ""
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "🧹 Uninstalling Tweak R.C.P.I..."
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

MODID=$(grep_prop id $MODPATH/module.prop)
MODNAME=$(grep_prop name $MODPATH/module.prop)
MODVER=$(grep_prop version $MODPATH/module.prop)
MODAUTH=$(grep_prop author $MODPATH/module.prop)

ui_print "📦 Module ID : $MODID"
ui_print "🧩 Name      : $MODNAME"
ui_print "🔢 Version   : $MODVER"
ui_print "👤 Author    : $MODAUTH"
ui_print ""

if [ -f "$MODPATH/service.sh" ]; then
    ui_print "⚙️  Stopping active services..."
    pkill -f "$MODPATH/service.sh" 2>/dev/null
    ui_print "✅ Services stopped."
fi

ui_print ""
ui_print "🧽 Cleaning additional files..."

TARGET_DIR="/storage/emulated/0/Android/TweakRCPIFiles"
if [ -d "$TARGET_DIR" ]; then
    rm -rf "$TARGET_DIR"
    ui_print "🗑️  Removed: $TARGET_DIR"
else
    ui_print "ℹ️  No extra files found in storage."
fi

CACHE_DIR="/data/local/tmp/tweakrcpi"
if [ -d "$CACHE_DIR" ]; then
    rm -rf "$CACHE_DIR"
    ui_print "🗑️  Removed cache: $CACHE_DIR"
fi

ui_print ""
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "📱 Device Information Snapshot"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

BRAND=$(getprop ro.product.brand)
MODEL=$(getprop ro.product.model)
ANDROID_VER=$(getprop ro.build.version.release)
KERNEL_VER=$(uname -r)

ui_print "🏷️  Brand  : $BRAND"
ui_print "📱 Model  : $MODEL"
ui_print "⚙️  Android: $ANDROID_VER"
ui_print "🐧 Kernel : $KERNEL_VER"

ui_print ""
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "✅ Uninstallation Complete!"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"