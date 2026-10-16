extends Area2D
signal collected 


func _ready() -> void:
	$AnimatedSprite2D.play("spin")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		queue_free()
