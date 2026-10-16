extends AnimatableBody2D

var speed:=500.0
var direction:=1.0
var left_limit := 300.0 
var right_limit:= 1200.0
var detection_area = false 
var start_x : float
var returning:= false


func _ready() -> void:
	start_x= position.x

func _physics_process(delta: float) -> void:
	if detection_area:
		position.x += direction*speed*delta 
		if position.x >= right_limit:
			direction=-1.0
		elif position.x <=left_limit:
			direction=1.0 
	if returning and not detection_area:
		position.x= move_toward(position.x,start_x,speed*delta)
		if position.x == start_x:
			returning=false 
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body. is_in_group("player"):
		detection_area =true
		returning=false
		$ActiveTimer.start()


func _on_active_timer_timeout() -> void:
	detection_area =false
	returning=true
