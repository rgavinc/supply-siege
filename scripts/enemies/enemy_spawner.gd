extends Node
## Trickle-spawns monsters while the wave runs. Back End owns.

@export var spawn_interval_sec: float = 2.0
@export var spawn_margin: float = 40.0

var _timer: float = 0.0
var _host: Node2D
var _gate: Node2D

func setup(host: Node2D, gate: Node2D) -> void:
	_host = host
	_gate = gate

func _process(delta: float) -> void:
	if GameState.game_over or not GameState.wave_running:
		return
	if _host == null:
		return
	_timer += delta
	if _timer >= spawn_interval_sec:
		_timer = 0.0
		_spawn()

func _spawn() -> void:
	var monster_script: GDScript = load("res://scripts/enemies/monster.gd")
	var m := CharacterBody2D.new()
	m.set_script(monster_script)
	# Spawn from a random edge, path toward gate
	var side := randi() % 4
	var pos := Vector2.ZERO
	match side:
		0:
			pos = Vector2(randf_range(80, 1200), spawn_margin)
		1:
			pos = Vector2(randf_range(80, 1200), 720.0 - spawn_margin)
		2:
			pos = Vector2(spawn_margin, randf_range(80, 640))
		_:
			pos = Vector2(1280.0 - spawn_margin, randf_range(80, 640))
	_host.add_child(m)
	m.global_position = pos
