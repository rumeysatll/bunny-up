extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.wind_force = -150.0
		print("Rüzgara girdi: ", body.wind_force)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.wind_force = 0.0
		print("Rüzgardan çıktı: ", body.wind_force)
