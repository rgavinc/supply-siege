# Product — Supply Siege (round 1)

> **Owner:** Product Director  
> **Repo:** https://github.com/rgavinc/supply-siege  
> **Engine:** Godot 4.7.2 · 2D · public `main` · GitHub Pages showcase  
> **Source of truth for vision.** Release bar: `docs/ACCEPTANCE.md`.

## Vision

Roguelite tower defense with a Dead Cells / fancy modern-SNES sprite look (~64×64 heroes, ~32×32 props). Each run gets harder and grants more supplies; later unlocks include Brotato-style specials, weapons, and new towers. **This milestone is round 1 only** — get the first wave right before expanding.

## Round 1 loop

Defend the gate through **one wave**. Place towers with starting supplies. Survive until the wave timer ends → win. Gate HP hits **0** → lose.

## Locked rules

| Rule | Value |
|------|------:|
| View / art | 2D pixel, Dead Cells / fancy-SNES |
| Hero / prop scale | ~64×64 / ~32×32 |
| Round 1 win | Survive to end of **1 wave** |
| Round 1 lose | Gate HP reaches 0 |
| Starting supplies | Tunable; enough for at least one tower |
| Buildings (r1) | Core tower type(s) only — no unlock tree yet |
| AI bootstrap | Art + audio may start as AI; fonts/VFX not tracked |

## Out of scope (round 1)

- Multi-wave runs, meta unlocks, Brotato shop between runs  
- Extra maps / endless mode  
- Online / multiplayer  

## AI provenance

- Registry: `assets/ASSETS_MANIFEST.toml` (art + audio only)  
- Labeled stills: `assets/replace_me/` (e.g. `tower_idle`, `monster_walk_01`, `gate_front`)  
- In-game watermark **“AI assets in use”** until every manifest entry is `human`  
- Live bar: watermark must clear before calling the game free of AI art/audio  

## Ownership

| Area | Owner |
|------|--------|
| Vision + this doc | Product Director |
| Repo, reviews, Pages | Lead Full Stack Programmer |
| Combat / economy / wave | Back End Programmer |
| Map / HUD / placement | Front End Programer |
| Pixel pack + replace slots | Designer |
| ACCEPTANCE + tests | Quality Assurance And Testing |

## Success for this milestone

1. Playable round 1 in Godot and (once workflow lands) on Pages.  
2. Win and lose paths work; HUD readable.  
3. Manifest + watermark behave correctly.  
4. Replace guide is obvious enough for human art drop-in.  

## Change control

Tune numbers and UX in this file first, then implement. Do not silently diverge from PRODUCT.
