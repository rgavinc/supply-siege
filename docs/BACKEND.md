# Backend — Supply Siege (round 1)

## Owned

| Path | Role |
|------|------|
| `scripts/autoload/game_state.gd` | Gold, gate HP, 60s wave, win/lose |
| `scripts/enemies/enemy_spawner.gd` | Trickle spawn while wave runs |
| `scripts/enemies/monster.gd` | Path to `gate` group, damage, kill reward |
| `scripts/buildings/tower.gd` | Auto-fire nearest in range |
| `scripts/map/main.gd` | Wires spawn + click-to-place for round 1 |

## Numbers

`START_GOLD=50`, `TOWER_COST=25`, `GATE_MAX_HP=100`, `WAVE_DURATION_SEC=60`

## FE hooks

Bind HUD to `gold_changed`, `gate_hp_changed`, `wave_progress`, `won`, `lost`. Placement can stay click-map or move to mound UX later.
