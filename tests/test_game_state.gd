extends RefCounted
## GameState acceptance — Supply Siege round 1.


func _make_state() -> Node:
	return load("res://scripts/autoload/game_state.gd").new()


func run_all() -> Dictionary:
	var failures: PackedStringArray = []
	var checks := [
		["constants", test_constants],
		["place_spends_gold", test_place_spends_gold],
		["cannot_place_broke", test_cannot_place_broke],
		["wave_win", test_wave_win],
		["gate_lose", test_gate_lose],
		["game_over_lock", test_game_over_lock],
		["kill_reward", test_kill_reward],
		["reset", test_reset],
	]
	var passed := 0
	for item in checks:
		var err: String = item[1].call()
		if err.is_empty():
			passed += 1
		else:
			failures.append("%s: %s" % [item[0], err])
	return {"passed": passed, "total": checks.size(), "failures": failures}


func test_constants() -> String:
	var s := _make_state()
	if s.START_GOLD != 50 or s.TOWER_COST != 25 or s.GATE_MAX_HP != 100:
		var msg := "bad consts gold=%s cost=%s gate=%s" % [s.START_GOLD, s.TOWER_COST, s.GATE_MAX_HP]
		s.free(); return msg
	if s.WAVE_DURATION_SEC != 60.0:
		s.free(); return "WAVE_DURATION_SEC want 60"
	s.free(); return ""


func test_place_spends_gold() -> String:
	var s := _make_state()
	if not s.try_place_tower() or s.gold != 25:
		var msg := "place failed gold=%s" % s.gold
		s.free(); return msg
	s.free(); return ""


func test_cannot_place_broke() -> String:
	var s := _make_state()
	s.gold = 24
	if s.try_place_tower():
		s.free(); return "placed with 24 gold"
	s.free(); return ""


func test_wave_win() -> String:
	var s := _make_state()
	var won := [false]
	s.won.connect(func() -> void: won[0] = true)
	s.start_wave()
	s._process(60.0)
	if not won[0] or not s.game_over:
		var msg := "expected win after 60s over=%s won=%s left=%s" % [s.game_over, won[0], s.wave_time_left]
		s.free(); return msg
	s.free(); return ""


func test_gate_lose() -> String:
	var s := _make_state()
	var lost := [false]
	s.lost.connect(func() -> void: lost[0] = true)
	s.damage_gate(100)
	if not lost[0] or s.gate_hp != 0:
		var msg := "expected lose hp=%s lost=%s" % [s.gate_hp, lost[0]]
		s.free(); return msg
	s.free(); return ""


func test_game_over_lock() -> String:
	var s := _make_state()
	s.damage_gate(100)
	var g: int = s.gold
	if s.try_place_tower():
		s.free(); return "place after lose"
	s.register_kill()
	s.damage_gate(1)
	if s.gold != g or s.gate_hp != 0:
		s.free(); return "mutated after lose"
	s.free(); return ""


func test_kill_reward() -> String:
	var s := _make_state()
	s.register_kill()
	if s.gold != 60:
		var msg := "want gold 60 got %s" % s.gold
		s.free(); return msg
	s.free(); return ""


func test_reset() -> String:
	var s := _make_state()
	s.try_place_tower()
	s.damage_gate(10)
	s.start_wave()
	s.reset()
	if s.gold != 50 or s.gate_hp != 100 or s.game_over or s.wave_running:
		s.free(); return "reset failed"
	s.free(); return ""
