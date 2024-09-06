extends Area2D

func _physics_process(_delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		if %ShootTimer.is_stopped() == true:
			%ShootTimer.start()
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
	else:
		%ShootTimer.stop()
	if (global_rotation_degrees > 90 and global_rotation_degrees < 270) or (global_rotation_degrees < -90 and global_rotation_degrees > -270):
		%Pistol.flip_v = true
		%ShootingPoint.position = Vector2(25, 11)
	else:
		%Pistol.flip_v = false
		%ShootingPoint.position = Vector2(25, -11)


func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot()
