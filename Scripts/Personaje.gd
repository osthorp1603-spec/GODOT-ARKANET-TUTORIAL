extends CharacterBody2D

var cooldown = true
var powerup = false
var invulnerable = false

@export var duracion_dano = 3
@export var velocidad_parpadeo = 0.5
@export var velocidad = 600

@onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var Disparo = preload("res://Scenes/Disparo.tscn") 
@onready var DisparoEspecial = preload("res://Scenes/DiparoEspecial.tscn")
@onready var HUD = get_tree().get_nodes_in_group("hud")[0]

func _ready():
	Global.vidas = 3
	Global.LabelPuntos = HUD.get_node("BarraPuntos/Label")

func _physics_process(delta):
	if Global.cinematica:
		return
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * velocidad
	if Input.is_action_pressed("attack"):
			disparar()
	
	if velocity.x > 0:
		playback.travel("mover_right")
	elif velocity.x < 0: 
		playback.travel("mover_left")
	else:
		playback.travel("RESET")
	move_and_slide()
	if is_on_wall():
		take_damage()
	
func take_damage():
	if invulnerable:
		return
	Global.remove_vida()
	var barra_vida = HUD.get_node("BarraVida")
	var vidas = barra_vida.get_children()
	vidas[Global.vidas].visible = false
	invulnerable = true
	var vueltas = int(duracion_dano / (velocidad_parpadeo * 2))
	var tween = create_tween().set_loops(vueltas)
	tween.tween_property(self, "modulate", Color("ff0000"), velocidad_parpadeo)
	tween.tween_property(self, "modulate", Color.WHITE, velocidad_parpadeo)
	await get_tree().create_timer(duracion_dano).timeout
	self.modulate = Color.WHITE
	collision_layer = 1
	collision_mask = 1
	invulnerable = false
	 
func disparar():
	if cooldown:
		cooldown = false
		$Timer.start()
		$AudioStreamPlayer.play()
		var instancia_disparo 
		if powerup:
			instancia_disparo = DisparoEspecial.instantiate()
		else:
			instancia_disparo = Disparo.instantiate() 	
		get_parent().add_child(instancia_disparo)
		instancia_disparo.global_position = $DisparoPos.global_position


func _on_timer_timeout():
	cooldown = true
	


func _on_area_2d_area_entered(area):
	if area.is_in_group("enemigo"):
		take_damage()
		area.set_explosion()
