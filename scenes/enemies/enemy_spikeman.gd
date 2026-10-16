extends CharacterBody2D


var speed := 150.0

var direction:= 1.0 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = direction * speed
	move_and_slide()

	if not $GroundRay.is_colliding():
		direction*=-1
		$GroundRay.position.x *=-1 
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D. flip_h 
		


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(1)
		if body.position.x < position.x:
			body.knockback(-1)
		else:
			body.knockback(1)
