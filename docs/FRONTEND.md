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
