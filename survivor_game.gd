extends Node2D

# Contar o Score. 
# Criar outro node de interface para fazer display do score,
# sempre que o score é atualizado

var score = 0
var kill_points = 100
var round_count = 0

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	# Se inscrever no signal de quando o mob morre.
	new_mob.killed.connect(_on_killed.bind())
	new_mob.lastmobkilled.connect(_on_lastmobkilled.bind())

func _on_spawn_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func update_score():
	%ScoreLabel.text = "Score: " + str(score)
	
func _on_killed() -> void:
	score += kill_points
	update_score()

func _on_round_timer_timeout() -> void:
	%SpawnTimer.stop()
	%SpawnTimer.wait_time = %SpawnTimer.wait_time * 0.95
	%RoundTimer.wait_time = %RoundTimer.wait_time * 1.05
	%StartButton.text = "Start round " + str(round_count + 1)
	%StartButton.visible = true
	%StartButton.disabled = false

func _on_start_button_button_down() -> void:
	round_count += 1
	%RoundCounter.text = "Round: " + str(round_count)
	if %RoundCounter.visible == false:
		%RoundCounter.visible = true
	if round_count > 1:
		kill_points += 5
	%StartButton.visible = false
	%StartButton.disabled = true
	%SpawnTimer.start()
	%RoundTimer.start()

func _on_lastmobkilled() -> void:
	%StartButton.visible = true
	%StartButton.disabled = false
