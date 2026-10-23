# Supply Siege

2D roguelite tower defense in **Godot 4.7.2**. Dead Cells / fancy-SNES sprite look (~64×64 heroes, ~32×32 props).

**Round 1:** one wave — survive until it ends. Lose if the gate hits 0 HP. Start with limited supplies; unlock more between runs later.

## Play

1. Install [Godot 4.7.2](https://godotengine.org/download/archive/4.7.2-stable/)
2. Import this folder → run `scenes/main.tscn`

## AI asset tracking

- Registry: [`assets/ASSETS_MANIFEST.toml`](assets/ASSETS_MANIFEST.toml) — **art + audio only**
- Every entry is `ai` or `human`. In-game watermark stays up until **all** are `human`
- Drop replacements into paths listed in the manifest; labeled stills under `assets/replace_me/` show what to redraw (`tower_idle`, `monster_walk_01`, …)
- Flip `status = "human"` when a human asset overwrites the AI placeholder

## Ownership

| Area | Owner |
|------|--------|
| Repo, reviews, Pages | Lead |
| Combat / economy / wave | Backend |
| Map / HUD / placement | Front End |
| Pixel pack + replace slots | Designer |
| ACCEPTANCE + tests | QA |
| Vision doc | Product |

## Pages

HTML export deploys from `main` via GitHub Actions → GitHub Pages (workflow lands once `workflow` scope is granted).
