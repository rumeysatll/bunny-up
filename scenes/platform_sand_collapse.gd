extends AnimatableBody2D

var sinking= false
var sink_speed:= 100
var start_y: float
var distance:=150.0
func _ready() -> void:
	start_y = position.y

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		sinking=true
			
func _physics_process(delta: float) -> void:
	if sinking:
		position.y+= sink_speed*delta
		if distance <= position.y-start_y:
			hide()
			$CollisionShape2D.set_deferred("disabled",true)
			$Area2D/CollisionShape2D.set_deferred("disabled",true)
			sinking=false
			$RespawnTimer.start()
			
func _on_respawn_timer_timeout() -> void:
	position.y = start_y
	$CollisionShape2D.set_deferred("disabled",false)
	$Area2D/CollisionShape2D.set_deferred("disabled",false)
	show()
