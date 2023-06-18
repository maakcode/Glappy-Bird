extends Area2D


@export var jump_speed: float = 500

var v = Vector2()
var is_jump_pressed: bool = false

func _physics_process(delta: float) -> void:
	v.y += gravity * delta
	if $'Jump Timer'.is_stopped() and is_jump_pressed:
		jump(delta)
		is_jump_pressed = false

	position.y += v.y * delta


func _unhandled_input(event: InputEvent) -> void:
	if !is_jump_pressed and event is InputEventScreenTouch and event.pressed:
		is_jump_pressed = true


func _unhandled_key_input(event: InputEvent) -> void:
	if !is_jump_pressed and event is InputEventKey and (event.keycode == KEY_SPACE or event.keycode == KEY_ENTER):
		if !event.pressed or event.echo: return

		is_jump_pressed = true


func jump(delta: float) -> void:
	$'Jump Sound'.play()
	v.y = -jump_speed
	$'Jump Timer'.start()


func crash() -> void:
	$'Crash Sound'.play()


func cry() -> void:
	$'Cry Sound'.play()
