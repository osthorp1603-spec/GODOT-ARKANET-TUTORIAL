extends Node

var puntos = 0
var vidas = 3
var LabelPuntos  
var cinematica = false

func remove_vida():
	if vidas > 1:
		vidas -= 1
	else:
		get_tree().call_deferred("reload_current_scene")
		

func add_puntos(valor):
	puntos += valor	
	LabelPuntos.text = str(puntos)
		
	
