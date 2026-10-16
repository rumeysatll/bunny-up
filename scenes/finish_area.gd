extends Area2D
signal game_finished



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("You Win ")
		body.game_finished=true
		game_finished.emit()
