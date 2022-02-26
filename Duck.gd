extends Area2D


export var jump_speed: float = 500

var v = Vector2()


func _physics_process(delta: float) -> void:
	v.y += gravity * delta
	if $'Jump Timer'.is_stopped() and Input.is_action_just_pressed('ui_accept'): jump(delta)

	position.y += v.y * delta


func jump(delta: float) -> void:
	$'Jump Sound'.play()
	v.y = -jump_speed
	$'Jump Timer'.start()


func crash() -> void:
	$'Crash Sound'.play()

func cry() -> void:
	$'Cry Sound'.play()
