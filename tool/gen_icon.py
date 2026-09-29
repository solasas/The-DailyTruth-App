#!/usr/bin/env python3
"""Generate the app launcher icon — the "T." brand mark (cream serif T with a
red full stop on an ink ground) — and write every platform size in place.

Pure Pillow, no network / no extra Flutter deps; the serif comes from the
bundled Playfair Display Black. Re-run after tweaking the constants below:
python3 tool/gen_icon.py
"""
import os
from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FONT = os.path.join(ROOT, "assets", "fonts", "PlayfairDisplay-Black.ttf")

BG = (20, 19, 18, 255)           # ink  #141312
INK = (243, 239, 232, 255)       # cream #F3EFE8
DOT = (226, 70, 60, 255)         # logo red #E2463C

SS = 4  # supersample factor

# Glyph geometry, as fractions of the canvas. The mark is kept inside the
# central ~60% so it survives Android adaptive-icon masks unchanged.
CAP_HEIGHT = 0.40   # height of the "T"
DOT_R = 0.052       # dot radius
GAP = 0.015         # space between the T's right edge and the dot


def draw_icon(size, *, bg=True, inset=0.0):
    """Render the icon at `size` px. `inset` shrinks the artwork toward the
    centre (0.18 => 18% padding) for maskable / adaptive foregrounds."""
    S = size * SS
    img = Image.new("RGBA", (S, S), BG if bg else (0, 0, 0, 0))
    d = ImageDraw.Draw(img)

    scale = (1.0 - 2 * inset) * S

    # Size the font so the T's ink box is CAP_HEIGHT tall.
    probe = ImageFont.truetype(FONT, 1000)
    l, t, r, b = probe.getbbox("T")
    font = ImageFont.truetype(FONT, int(1000 * CAP_HEIGHT * scale / (b - t)))
    l, t, r, b = font.getbbox("T")
    t_w, t_h = r - l, b - t

    dot_d = 2 * DOT_R * scale
    total_w = t_w + GAP * scale + dot_d
    x0 = (S - total_w) / 2
    y0 = (S - t_h) / 2 + 0.01 * scale  # optical centring: nudge down a hair

    d.text((x0 - l, y0 - t), "T", font=font, fill=INK)

    cx = x0 + t_w + GAP * scale + dot_d / 2
    cy = y0 + t_h - dot_d / 2
    rr = dot_d / 2
    d.ellipse([cx - rr, cy - rr, cx + rr, cy + rr], fill=DOT)

    return img.resize((size, size), Image.LANCZOS)


def save(img, *paths, rgb=False):
    if rgb:
        flat = Image.new("RGB", img.size, BG[:3])
        flat.paste(img, mask=img.split()[3] if img.mode == "RGBA" else None)
        img = flat
    p = os.path.join(ROOT, *paths)
    os.makedirs(os.path.dirname(p), exist_ok=True)
    img.save(p)
    print("wrote", os.path.relpath(p, ROOT))


# --- source of truth --------------------------------------------------------
save(draw_icon(1024), "assets", "icon", "app_icon.png")
save(draw_icon(1024, bg=False, inset=0.16), "assets", "icon", "app_icon_foreground.png")

# --- Android legacy + adaptive ------------------------------------------------
RES = ("android", "app", "src", "main", "res")
for d, legacy, adaptive in [
    ("mdpi", 48, 108), ("hdpi", 72, 162), ("xhdpi", 96, 216),
    ("xxhdpi", 144, 324), ("xxxhdpi", 192, 432),
]:
    save(draw_icon(legacy), *RES, f"mipmap-{d}", "ic_launcher.png")
    # Adaptive foreground: full-bleed artwork on transparent; the ink
    # `ic_launcher_background` shows through and the launcher applies its own
    # mask + safe-zone. The master art already carries generous margins.
    save(draw_icon(adaptive, bg=False, inset=0.0), *RES, f"mipmap-{d}", "ic_launcher_foreground.png")
    # Splash mark (96dp): a plain PNG, since on API 26+ `@mipmap/ic_launcher`
    # resolves to the adaptive-icon XML, which a splash <bitmap> can't load.
    save(draw_icon(legacy * 2), *RES, f"mipmap-{d}", "launch_image.png")

_anydpi = os.path.join(ROOT, *RES, "mipmap-anydpi-v26", "ic_launcher.xml")
os.makedirs(os.path.dirname(_anydpi), exist_ok=True)
with open(_anydpi, "w") as f:
    f.write(
        '<?xml version="1.0" encoding="utf-8"?>\n'
        '<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">\n'
        '    <background android:drawable="@drawable/ic_launcher_background"/>\n'
        '    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>\n'
        '</adaptive-icon>\n'
    )
print("wrote", os.path.relpath(_anydpi, ROOT))

_bg = os.path.join(ROOT, *RES, "drawable", "ic_launcher_background.xml")
os.makedirs(os.path.dirname(_bg), exist_ok=True)
with open(_bg, "w") as f:
    f.write(
        '<?xml version="1.0" encoding="utf-8"?>\n'
        '<shape xmlns:android="http://schemas.android.com/apk/res/android" '
        'android:shape="rectangle">\n'
        '    <solid android:color="#141312"/>\n'
        '</shape>\n'
    )
print("wrote", os.path.relpath(_bg, ROOT))

# --- iOS AppIcon.appiconset --------------------------------------------------
IOS = ("ios", "Runner", "Assets.xcassets", "AppIcon.appiconset")
ios_specs = {
    "Icon-App-20x20@1x.png": 20, "Icon-App-20x20@2x.png": 40, "Icon-App-20x20@3x.png": 60,
    "Icon-App-29x29@1x.png": 29, "Icon-App-29x29@2x.png": 58, "Icon-App-29x29@3x.png": 87,
    "Icon-App-40x40@1x.png": 40, "Icon-App-40x40@2x.png": 80, "Icon-App-40x40@3x.png": 120,
    "Icon-App-60x60@2x.png": 120, "Icon-App-60x60@3x.png": 180,
    "Icon-App-76x76@1x.png": 76, "Icon-App-76x76@2x.png": 152,
    "Icon-App-83.5x83.5@2x.png": 167,
    "Icon-App-1024x1024@1x.png": 1024,
}
for name, px in ios_specs.items():
    # iOS icons must be opaque (no alpha) — App Store rejects alpha channels.
    save(draw_icon(px), *IOS, name, rgb=True)

# --- Web ------------------------------------------------------------------------
save(draw_icon(16), "web", "favicon.png")
save(draw_icon(192), "web", "icons", "Icon-192.png")
save(draw_icon(512), "web", "icons", "Icon-512.png")
save(draw_icon(192, inset=0.16), "web", "icons", "Icon-maskable-192.png")
save(draw_icon(512, inset=0.16), "web", "icons", "Icon-maskable-512.png")

print("done")
