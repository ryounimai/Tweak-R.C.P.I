#!/system/bin/sh
echo "======================================="
echo "   🚀 Script Optimasi & Konfigurasi   "
echo "======================================="

echo ""
echo "=== [1] Mendeteksi aplikasi user terinstal ==="
USER_APPS=$(pm list packages -3 | sed 's/package://g')
if [ -z "$USER_APPS" ]; then
    echo "Tidak ada aplikasi user terpasang."
    exit 0
fi
echo "Ditemukan aplikasi user berikut:"
echo "$USER_APPS"
echo ""
 os_displaycutoutmode_settings
NEW_VALUE="{"
for pkg in $USER_APPS; do
    NEW_VALUE="${NEW_VALUE}${pkg}=1, "
done
if ! echo "$NEW_VALUE" | grep -q "com.android.chrome=1"; then
    NEW_VALUE="${NEW_VALUE}com.android.chrome=1}"
fi
settings put system os_displaycutoutmode_settings "$NEW_VALUE"
echo "--- Hasil os_displaycutoutmode_settings ---"
settings get system os_displaycutoutmode_settings
echo ""

echo "=== [2] Mengatur ANGLE GL Driver Selection ==="
PKG_LINES=$(echo "$USER_APPS" | tr '\n' ',')
PKGS=$(printf "%s" "$PKG_LINES" | sed 's/,$//')
if [ -z "$PKGS" ]; then
  echo "Tidak ada paket user terpasang."
  exit 0
fi
COUNT=$(printf "%s" "$PKGS" | awk -F',' '{print NF}')
VALUES=$(yes angle | head -n $COUNT | tr '\n' ',' | sed 's/,$//')
settings put global angle_gl_driver_selection_pkgs "$PKGS"
settings put global angle_gl_driver_selection_values "$VALUES"
echo "--- Hasil angle_gl_driver_selection_pkgs ---"
settings get global angle_gl_driver_selection_pkgs
echo "--- Hasil angle_gl_driver_selection_values ---"
settings get global angle_gl_driver_selection_values
echo ""

echo "=== [3] Mengatur Game Overlay (Game Tertentu) ==="

device_config put game_overlay com.YoStarEN.StellaSora mode=2,downscaleFactor=0.9,useAngle=true,fps=120,loadingBoost=1073741824:mode=3,downscaleFactor=0.9,useAngle=true,fps=120,loadingBoost=1073741824
device_config get game_overlay com.YoStarEN.StellaSora

device_config put game_overlay com.supercell.boombeach mode=2,downscaleFactor=1.0,useAngle=true,fps=120,loadingBoost=1073741824:mode=3,downscaleFactor=1.0,useAngle=true,fps=120,loadingBoost=1073741824
device_config get game_overlay com.supercell.boombeach

device_config put game_overlay com.kurogame.wutheringwaves.global mode=2,downscaleFactor=0.85,useAngle=true,fps=120,loadingBoost=1073741824:mode=3,downscaleFactor=0.85,useAngle=true,fps=120,loadingBoost=1073741824
device_config get game_overlay com.kurogame.wutheringwaves.global

device_config put game_overlay com.bushiroad.d4dj mode=2,downscaleFactor=1.0,useAngle=true,fps=120,loadingBoost=1073741824:mode=3,downscaleFactor=1.0,useAngle=true,fps=120,loadingBoost=1073741824
device_config get game_overlay com.bushiroad.d4dj

device_config put game_overlay com.supercell.clashofclans mode=2,downscaleFactor=1.0,useAngle=true,fps=120,loadingBoost=1073741824:mode=3,downscaleFactor=1.0,useAngle=true,fps=120,loadingBoost=1073741824
device_config get game_overlay com.supercell.clashofclans

device_config put game_overlay com.HoYoverse.hkrpgoversea mode=2,downscaleFactor=0.80,useAngle=true,fps=120,loadingBoost=1073741824:mode=3,downscaleFactor=0.8,useAngle=true,fps=120,loadingBoost=1073741824
device_config get game_overlay com.HoYoverse.hkrpgoversea

device_config put game_overlay com.gryphline.exastris.gp mode=2,downscaleFactor=0.85,useAngle=true,fps=120,loadingBoost=1073741824:mode=3,downscaleFactor=0.85,useAngle=true,fps=120,loadingBoost=1073741824
device_config get game_overlay com.gryphline.exastris.gp


sleep 1
echo ""
echo "=== ✅ Semua konfigurasi selesai diterapkan ==="
echo "==============================================="