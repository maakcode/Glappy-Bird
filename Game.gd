extends Node2D

export(PackedScene) var wall_scene

const duck_initial_position = Vector2(256, 300)
const initial_wall_x: float = 1239.0
const initial_wall_velocity = Vector2(-200.0, 0)

var wall_velocity: Vector2 = initial_wall_velocity
var score: int = 0


func _ready() -> void:
	reset_duck(false)
	$'Wall Timer'.start()


func _on_Duck_area_entered(area: Area2D) -> void:
	match area.get_parent().name:
		"Wall":
			print('Duck Crashed!')
			reset_duck()
			reset_walls()
			reset_score()

		"Score":
			print('Duck Scored')
			scored()


func _on_Duck_area_exited(area: Area2D) -> void:
	if area != $'Screen Area': return

	print('Duck out of box')
	reset_duck()
	reset_walls()
	reset_score()


func reset_duck(is_crashed: bool = true) -> void:
	if is_crashed: $'Duck'.crash()

	$'Duck'.position = duck_initial_position
	$'Duck'.v = Vector2(0, -1) * $'Duck'.jump_speed
	$'Duck/Jump Timer'.start()
	score = 0


func reset_walls() -> void:
	wall_velocity = initial_wall_velocity

	for n in $'Walls'.get_children():
		$'Walls'.remove_child(n)
		n.queue_free()


func scored() -> void:
	score += 1
	$'Label'.text = str(score)
	wall_velocity.x -= 5
	set_walls_speed(wall_velocity)


func reset_score() -> void:
	score = 0
	$'Label'.text = str(score)


func set_walls_speed(value: Vector2):
	for w in $'Walls'.get_children():
		w.velocity = value


func create_wall() -> void:
	var wall = wall_scene.instance()
	wall.position = Vector2(initial_wall_x, rand_range(150, 450))
	wall.velocity = wall_velocity
	$'Walls'.add_child(wall)


func _on_Wall_Timer_timeout() -> void:
	create_wall()
