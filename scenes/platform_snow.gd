extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_ice_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.on_ice = true


func _on_ice_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.on_ice = false 
