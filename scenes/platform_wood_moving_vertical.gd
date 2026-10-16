extends AnimatableBody2D

@export var speed:=500.0
var direction:=-1.0
@export var move_distance:= 500.0
var start_y: float
var detection_area = false 
var returning:=false

func _ready() -> void:
	start_y = position.y

func _physics_process(delta: float) -> void:
	if detection_area:
		position.y += direction*speed*delta 
		if position.y <= start_y- move_distance:
			direction=1.0
		elif position.y >=start_y:
			direction=-1.0 
	if returning and not detection_area:
		position.y= move_toward(position.y,start_y,speed*delta)
		if position.y == start_y:
			returning=false 
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body. is_in_group("player"):
		detection_area =true
		$ActiveTimer.start()
		returning=false

func _on_active_timer_timeout() -> void:
	returning=true
	detection_area=false
	
