extends Area2D
@export var jump_strength := -1400.0



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.velocity.y = jump_strength
		$AnimatedSprite2D.play("spring")
		
