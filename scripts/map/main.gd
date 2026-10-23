extends Node2D
## Round 1 playable loop. Back End owns spawn/combat; Front End owns HUD polish.

var _towers: Node2D
var _enemies: Node2D
var _gate: Node2D
var _hud_gold: Label
var _hud_gate: Label
var _hud_wave: Label
var _hud_status: Label

func _ready() -> void:
	_towers = $World/Towers
	_enemies = $World/Enemies
	_gate = $World/Gate
	_gate.add_to_group("gate")
	_gate.position = Vector2(640, 360)
	var gate_spr := Sprite2D.new()
	var gate_tex := load("res://assets/art/props/gate_64.png")
	if gate_tex:
		gate_spr.texture = gate_tex
	_gate.add_child(gate_spr)

	var spawner := Node.new()
	spawner.set_script(load("res://scripts/enemies/enemy_spawner.gd"))
	add_child(spawner)
	spawner.call("setup", _enemies, _gate)

	_build_hud()
	GameState.gold_changed.connect(_on_gold)
	GameState.gate_hp_changed.connect(_on_gate)
	GameState.wave_progress.connect(_on_wave)
	GameState.won.connect(func(): _hud_status.text = "WAVE CLEARED — you win")
	GameState.lost.connect(func(): _hud_status.text = "GATE DOWN — you lose")
	_on_gold(GameState.gold)
	_on_gate(GameState.gate_hp)
	GameState.start_wave()

func _build_hud() -> void:
	var ui: CanvasLayer = $UI
	_hud_gold = Label.new()
	_hud_gold.position = Vector2(8, 48)
	_hud_gold.text = "Gold: 50"
	ui.add_child(_hud_gold)
	_hud_gate = Label.new()
	_hud_gate.position = Vector2(8, 72)
	ui.add_child(_hud_gate)
	_hud_wave = Label.new()
	_hud_wave.position = Vector2(8, 96)
	ui.add_child(_hud_wave)
	_hud_status = Label.new()
	_hud_status.position = Vector2(8, 120)
	_hud_status.text = "Click map to place tower (25g) — survive the wave"
	ui.add_child(_hud_status)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if GameState.try_place_tower():
			var tower := Node2D.new()
			tower.set_script(load("res://scripts/buildings/tower.gd"))
			_towers.add_child(tower)
			tower.global_position = get_global_mouse_position()

func _on_gold(v: int) -> void:
	if _hud_gold:
		_hud_gold.text = "Gold: %d" % v

func _on_gate(v: int) -> void:
	if _hud_gate:
		_hud_gate.text = "Gate HP: %d" % v

func _on_wave(remaining: float) -> void:
	if _hud_wave:
		_hud_wave.text = "Wave: %.0fs" % remaining
