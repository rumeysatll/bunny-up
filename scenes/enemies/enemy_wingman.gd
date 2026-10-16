extends CharacterBody2D

var speed:=300.0
var direction:=1.0
var left_limit:=100.0
var right_limit:=1800.0
var start_y: float
var time :=0.0
var wave_height:= 60.0 
var wave_speed := 0.5 

func _ready() -> void:
	start_y=position.y
	$AnimatedSprite2D.play("fly")
	
func _physics_process(delta: float) -> void:
	position.x += speed*direction*delta
	if position.x >= right_limit:
		direction= -1.0
	elif position.x <=left_limit:
		direction=1.0 
	time += delta
	position.y = start_y+ sin(time* wave_speed) * wave_height


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(1)
