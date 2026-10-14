extends Control


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Scenes/Nivel1.tscn")


func _on_controles_pressed():
	get_tree().change_scene_to_file("res://Scenes/VerControles.tscn")


func _on_volver_pressed():
	get_tree().change_scene_to_file("res://Scenes/PantallaPrincipal.tscn")
