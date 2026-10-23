# DESIGN — Supply Siege (round 1)

Style: Dead Cells / fancy modern SNES — bold outlines, saturated flats, ~64×64 heroes, ~32×32 lesser.

## Replace loop
1. Open `assets/replace_me/` — each file is named by slot (`tower_idle`, `monster_walk_01`, `gate_front`).
2. Drop your human PNG over the matching path in `assets/art/...` (see `ASSETS_MANIFEST.toml`).
3. Set that entry's `status = "human"`. Watermark clears when art+audio are all human.

## Slots (round 1)
| Slot | Path | Size |
|------|------|------|
| tile_grass | art/tiles/grass_32.png | 32² |
| tower_idle | art/characters/tower_idle.png | 64² |
| monster_walk_01 | art/characters/monster_walk_01.png | 32² |
| gate_front | art/props/gate_64.png | 64² |
| ui_gold | art/ui/icon_gold.png | 16² |
