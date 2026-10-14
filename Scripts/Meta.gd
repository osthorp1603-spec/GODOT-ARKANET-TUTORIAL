extends AnimatedSprite2D

@export_file var NextLevel: String

@onready var personaje = get_tree().get_nodes_in_group("personaje")[0]

func cinematica():
	Global.cinematica = true
	var personaje_position = personaje.global_position
	var posicion_antena = $PosicionAntena.global_position
	var posicion_salida = $PosicionSalida.global_position
	
	var tween = create_tween()
	tween.tween_property(personaje,"global_position",posicion_antena,2)
	await tween.finished
	
	$AnimationPlayer.play("meta")
	await $AnimationPlayer.animation_finished
	
	var tween2 = create_tween()
	tween2.tween_property(personaje,"global_position",posicion_salida,2)
	await tween2.finished
	
	Global.cinematica = false
	
	get_tree().change_scene_to_file(NextLevel)

func _on_visible_on_screen_notifier_2d_screen_entered():
	cinematica()
