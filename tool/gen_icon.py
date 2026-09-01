#!/usr/bin/env python3
"""Generate the app launcher icon (cream ground, three grey text bars, a
rising trail of four dots) and write every platform size in place.

Pure Pillow, no network / no extra Flutter deps. Re-run after tweaking the
constants below:  python3 tool/gen_icon.py
"""
import os
from PIL import Image, ImageDraw

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

BG = (243, 238, 224, 255)        # cream
BAR = (217, 209, 193, 255)       # warm grey
GREEN = (28, 58, 36, 255)        # deep forest green
AMBER = (224, 144, 14, 255)      # golden amber

SS = 4  # supersample factor


def draw_icon(size, *, bg=True, inset=0.0):
    """Render the icon at `size` px. `inset` shrinks the artwork toward the
    centre (0.18 => 18% padding) for maskable / adaptive foregrounds."""
    S = size * SS
    img = Image.new("RGBA", (S, S), BG if bg else (0, 0, 0, 0))
    d = ImageDraw.Draw(img)

    scale = 1.0 - 2 * inset
    off = inset * S

    def X(u):  # normalised 0..1 -> px, with inset applied
        return off + u * S * scale

    def bar(u_left, u_right, u_top, u_bot):
        x0, x1, y0, y1 = X(u_left), X(u_right), X(u_top), X(u_bot)
        d.rounded_rectangle([x0, y0, x1, y1], radius=(y1 - y0) / 2, fill=BAR)

    bar(0.250, 0.755, 0.238, 0.285)
    bar(0.250, 0.755, 0.363, 0.410)
    bar(0.250, 0.575, 0.488, 0.535)

    def dot(cx, cy, r, color):
        c = (X(cx), X(cy))
        rr = r * S * scale
        d.ellipse([c[0] - rr, c[1] - rr, c[0] + rr, c[1] + rr], fill=color)

    dot(0.293, 0.700, 0.033, GREEN)
    dot(0.417, 0.756, 0.048, GREEN)
    dot(0.567, 0.723, 0.063, GREEN)
    dot(0.723, 0.634, 0.082, AMBER)

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
    # Adaptive foreground: full-bleed artwork on transparent; the cream
    # `ic_launcher_background` shows through and the launcher applies its own
    # mask + safe-zone. The master art already carries generous margins.
    save(draw_icon(adaptive, bg=False, inset=0.0), *RES, f"mipmap-{d}", "ic_launcher_foreground.png")

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
        '    <solid android:color="#F3EEE0"/>\n'
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
