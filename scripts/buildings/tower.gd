extends Node2D
## Auto-fires nearest enemy in range. Back End owns combat.

@export var range_px: float = 120.0
@export var fire_interval_sec: float = 0.7
@export var damage: int = 1

var _cooldown: float = 0.0

func _ready() -> void:
	add_to_group("towers")
	var spr := Sprite2D.new()
	var tex := load("res://assets/art/characters/tower_idle.png")
	if tex:
		spr.texture = tex
	add_child(spr)

func _process(delta: float) -> void:
	if GameState.game_over:
		return
	_cooldown = maxf(0.0, _cooldown - delta)
	if _cooldown > 0.0:
		return
	var target := _find_nearest()
	if target == null:
		return
	if target.has_method("take_damage"):
		target.take_damage(damage)
	_cooldown = fire_interval_sec

func _find_nearest() -> Node2D:
	var best: Node2D = null
	var best_d2 := range_px * range_px
	for node in get_tree().get_nodes_in_group("enemies"):
		if not node is Node2D:
			continue
		var d2 := global_position.distance_squared_to((node as Node2D).global_position)
		if d2 <= best_d2:
			best_d2 = d2
			best = node as Node2D
	return best
