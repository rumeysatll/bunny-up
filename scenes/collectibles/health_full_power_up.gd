extends Area2D

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property($PointLight2D,"energy",0.4,0.7)
	tween.tween_property($PointLight2D,"energy",0.1,0.7)

func _on_body_entered(body: Node2D) -> void:
	if body. is_in_group("player"):
		if body.health < body.max_health:
			body.health = body.max_health
			body.health_changed.emit(body.health)
		queue_free()
