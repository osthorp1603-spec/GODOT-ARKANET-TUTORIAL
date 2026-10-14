extends Area2D



func _on_body_entered(body):
	if body.is_in_group("personaje"):
		body.powerup = true
		$AudioStreamPlayer.play()
		$CollisionShape2D.set_deferred("disabled", true)
		$PowerUp.visible = false
		await $AudioStreamPlayer.finished
		queue_free()
	
	
