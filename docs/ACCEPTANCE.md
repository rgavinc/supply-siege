# Acceptance — Supply Siege round 1

> **Owner:** QA. Release gate for round 1. Numbers mirror `docs/PRODUCT.md` + `GameState`.

Nothing ships (Pages showcase included) until this bar is green. AI art/audio may ship under watermark; **going live without watermark** requires the manifest gate below.

---

## Locked numbers

| Rule | Value |
|------|------:|
| Start gold | 50 |
| Tower cost | 25 |
| Gate max HP | 100 |
| Round 1 | **1 wave**, 60s |
| Win | Survive until wave timer hits 0 |
| Lose | Gate HP reaches 0 |
| Manifest | **art + audio only** (`assets/ASSETS_MANIFEST.toml`) |

---

## Shippable checklist

### Gameplay
- [ ] Round 1 is a single wave; win when the wave timer completes
- [ ] Lose when gate HP hits 0
- [ ] Player can place a tower when gold ≥ 25; cost deducted
- [ ] Kills grant gold (default +10)

### Provenance / watermark
- [ ] Every art + audio path used in round 1 is listed in `assets/ASSETS_MANIFEST.toml`
- [ ] Boot shows **“AI assets in use”** watermark while any entry is `status = "ai"`
- [ ] Watermark clears only when **every** entry is `human` (fonts/VFX not required in manifest)
- [ ] `assets/replace_me/` stills match slot names for human handoff

### Repo / tests
- [ ] Decisions live in-repo (PRODUCT + this file), not chat-only
- [ ] Headless suite under `tests/` passes on Godot **4.7.2**

---

## Automated bar

1. GameState constants match the table  
2. Place spends 25; cannot place when broke or game over  
3. Wave timer win path (`start_wave` → time out → `won`)  
4. Gate damage to 0 → `lost`  
5. Game over blocks further place / damage / kills  
6. AssetProvenance reports `ai_remaining > 0` on current scaffold (AI placeholders)  
7. AssetProvenance `uses_ai_assets()` is true while AI remains  

**Run:** `godot --headless --path . -s res://tests/run_tests.gd`

**Status:** Automated suite landed by QA. Play smoke + Lead review still required before QA signs round 1.
