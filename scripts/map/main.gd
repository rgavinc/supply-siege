extends Node2D
## Round 1 map stub — Front End owns polish; Backend owns spawn/combat children.

func _ready() -> void:
	GameState.start_wave()
	print("Supply Siege round 1 — wave started, gold=%s" % GameState.gold)
