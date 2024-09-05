extends Node2D

# Contar o Score. 
# Criar outro node de interface para fazer display do score,
# sempre que o score é atualizado

var score = 0

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	# Se inscrever no signal de quando o mob morre.
	new_mob.killed.connect(_on_killed.bind())

func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func update_score():
	%ScoreLabel.text = "Score: " + str(score)
	
func _on_killed() -> void:
	score += 10
	update_score()
