extends StaticBody2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$BreakTimer.start() 


func _on_break_timer_timeout() -> void:
	$GroundGrassBroken.hide()
	$CollisionShape2D. set_deferred("disabled",true)
	$RespawnTimer.start()
	


func _on_respawn_timer_timeout() -> void:
	$GroundGrassBroken.show()
	$CollisionShape2D.set_deferred("disabled",false)
	
	
