extends CharacterBody2D

var speed:=500.0
var direction :=1.0
var left_limit:=200.0
var right_limit:=1300.0
var player_detected:= false

func _physics_process(delta: float) -> void:
	velocity.x = direction*speed
	position.x += direction * speed * delta
	if position.x >= right_limit:
		direction = -1 
	elif position.x <=left_limit:
		direction = 1 
	
func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(1)
