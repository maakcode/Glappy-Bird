extends Node2D

@export var velocity = Vector2.ZERO


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited() -> void:
	print('freed')
	queue_free()
