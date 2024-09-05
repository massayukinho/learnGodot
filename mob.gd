extends CharacterBody2D

var score = 0
var health = 3

@onready var player = get_node("/root/Game/Player")

# Criar Signal e Emitir quando o Mob Morrer.

func _ready() -> void:
	%Slime.play_walk()


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()


func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		score += 10
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
