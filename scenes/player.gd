extends CharacterBody2D

signal health_changed(health : int)
signal player_died
var speed:=350.0
var jump_strength := -850.0
var gravity:= 1200.0
var health := 3 
var vulnerable_to_damage = true 
var can_move := true 
var max_health=3 
var on_ice := false 
var ice_accelaration:=300.0 
var wind_force:= 0.0 
var has_jetpack:= false 
var jetpack_speed=-650.0
var jetpack_warning_started:=false
var game_finished:=false

func _physics_process(delta: float) -> void:
	if game_finished:
		velocity= Vector2.ZERO
		return
		
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_strength
	if has_jetpack and Input.is_action_pressed("jump"):
		velocity.y = jetpack_speed
		$JetpackVisual/RightFlame.emitting=true
		$JetpackVisual/LeftFlame.emitting=true
	else:
		$JetpackVisual/RightFlame.emitting=false
		$JetpackVisual/LeftFlame.emitting=false
	if has_jetpack and $JetpackTimer.time_left<=3.0 and not jetpack_warning_started:
		jetpack_warning_started=true
		var tween = create_tween()
		tween.tween_property($JetpackVisual,"modulate:a",0.0,0.2)
		tween.tween_property($JetpackVisual,"modulate:a",1.0,0.2)
		tween.set_loops()

	var direction_x =Input.get_axis("left","right")
	if can_move:
		if not on_ice:
			velocity.x = direction_x*speed+wind_force
		elif on_ice:
			velocity.x =move_toward(velocity.x,direction_x*speed + wind_force,ice_accelaration*delta)
	move_and_slide()

	
	if direction_x > 0:
		$AnimatedSprite2D.flip_h=false
	elif direction_x < 0:
		$AnimatedSprite2D.flip_h = true
	
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif direction_x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	
func take_damage(amount:int) -> void:
	if vulnerable_to_damage:
		health -= amount
		print ("Health: ", health)
		health_changed.emit(health)
		if health<=0:
			game_finished=true
			player_died.emit()
		else:
			vulnerable_to_damage=false
			$Timer.start()
			var tween = create_tween()
			tween.tween_property($AnimatedSprite2D,"modulate:a",0.0,0.3)
			tween.tween_property($AnimatedSprite2D,"modulate:a",1.0,0.3)
			tween.tween_property($AnimatedSprite2D,"modulate:a",0.0,0.3)
			tween.tween_property($AnimatedSprite2D,"modulate:a",1.0,0.3)

func _on_timer_timeout() -> void:
	vulnerable_to_damage=true

func knockback(direction):
	can_move=false
	$KnockbackTimer.start()
	velocity.x= direction*600
	velocity.y=-400


func _on_knockback_timer_timeout() -> void:
	can_move=true


func _on_jetpack_timer_timeout() -> void:
	has_jetpack=false
	$JetpackVisual.hide()
	
