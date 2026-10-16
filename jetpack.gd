extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.has_jetpack = true
		body.get_node("JetpackTimer").start()
		body.get_node("JetpackVisual").show()
		queue_free()
