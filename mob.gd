extends CharacterBody2D

var health = 3

signal killed
signal lastmobkilled
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
		killed.emit()
		queue_free()
		
		if get_node("/root/Game").find_children("Slime", "" , true, false).size() < 2:
			lastmobkilled.emit()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
