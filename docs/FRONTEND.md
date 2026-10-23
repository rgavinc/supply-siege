# FRONTEND — Supply Siege (round 1)

## Owns
- Map presentation (grass tile field, camera), HUD layout/copy, watermark presentation
- Placement click UX stays wired through Backend `GameState.try_place_tower`

## Player UX
- Click the field to place a tower when you can afford it (25g)
- Survive until the wave timer ends; lose if gate HP hits 0
- Corner watermark while any art/audio in `assets/ASSETS_MANIFEST.toml` is still `ai`

## Replace art
Overwrite files at the manifest paths (same filename). Labeled stills in `assets/replace_me/`. Flip `status` to `"human"` when replaced — see `docs/DESIGN.md`.

## Web / Pages
Export preset **`Web`** lives in `export_presets.cfg`. CI runs `godot --export-release "Web" build/web/index.html` on push to `main`. Renderer is **GL Compatibility** so the browser build can target WebGL 2.

## Web / Pages
Export preset **`Web`** lives in `export_presets.cfg` (tracked for CI). Actions runs `godot --export-release "Web" build/web/index.html` on push to `main`. Renderer is **GL Compatibility** for WebGL 2.
