extends Node
## Round 1: survive one wave. Lose if gate HP hits 0.

signal gold_changed(value: int)
signal gate_hp_changed(value: int)
signal wave_progress(remaining: float)
signal won
signal lost

const START_GOLD := 50
const TOWER_COST := 25
const GATE_MAX_HP := 100
const WAVE_DURATION_SEC := 60.0

var gold: int = START_GOLD:
	set(v):
		gold = v
		gold_changed.emit(gold)

var gate_hp: int = GATE_MAX_HP:
	set(v):
		gate_hp = v
		gate_hp_changed.emit(gate_hp)

var wave_time_left: float = WAVE_DURATION_SEC
var game_over: bool = false
var wave_running: bool = false

func start_wave() -> void:
	if game_over:
		return
	wave_running = true
	wave_time_left = WAVE_DURATION_SEC

func _process(delta: float) -> void:
	if not wave_running or game_over:
		return
	wave_time_left = maxf(wave_time_left - delta, 0.0)
	wave_progress.emit(wave_time_left)
	if wave_time_left <= 0.0:
		_win()

func can_place_tower() -> bool:
	return gold >= TOWER_COST and not game_over

func try_place_tower() -> bool:
	if not can_place_tower():
		return false
	gold -= TOWER_COST
	return true

func damage_gate(amount: int) -> void:
	if game_over:
		return
	gate_hp = maxi(gate_hp - amount, 0)
	if gate_hp <= 0:
		_lose()

func register_kill(reward: int = 10) -> void:
	if game_over:
		return
	gold += reward

func _win() -> void:
	game_over = true
	wave_running = false
	won.emit()

func _lose() -> void:
	game_over = true
	wave_running = false
	lost.emit()

func reset() -> void:
	game_over = false
	wave_running = false
	gold = START_GOLD
	gate_hp = GATE_MAX_HP
	wave_time_left = WAVE_DURATION_SEC
