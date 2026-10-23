extends CharacterBody2D
## Walks toward the gate; damages it on contact. Back End owns.

@export var max_hp: int = 3
@export var move_speed: float = 55.0
@export var gate_damage: int = 8
@export var kill_reward: int = 10

var hp: int = 3
var _gate: Node2D

func _ready() -> void:
	hp = max_hp
	add_to_group("enemies")
	_gate = get_tree().get_first_node_in_group("gate") as Node2D
	_ensure_visual()

func _ensure_visual() -> void:
	if has_node("Sprite"):
		return
	var spr := Sprite2D.new()
	spr.name = "Sprite"
	var tex := load("res://assets/art/characters/monster_walk_01.png")
	if tex:
		spr.texture = tex
	else:
		var placeholder := ColorRect.new()
		placeholder.size = Vector2(16, 16)
		placeholder.color = Color(0.8, 0.2, 0.2)
		placeholder.position = Vector2(-8, -8)
		add_child(placeholder)
		return
	add_child(spr)

func _physics_process(_delta: float) -> void:
	if GameState.game_over:
		velocity = Vector2.ZERO
		return
	if _gate == null:
		_gate = get_tree().get_first_node_in_group("gate") as Node2D
		if _gate == null:
			return
	var dir := (_gate.global_position - global_position).normalized()
	velocity = dir * move_speed
	move_and_slide()
	if global_position.distance_to(_gate.global_position) < 20.0:
		GameState.damage_gate(gate_damage)
		queue_free()

func take_damage(amount: int) -> void:
	hp -= amount
	if hp <= 0:
		GameState.register_kill(kill_reward)
		queue_free()
