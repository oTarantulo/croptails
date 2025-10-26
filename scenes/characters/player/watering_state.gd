extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0, 0)

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	if animated_sprite_2d.frame == 1:
		hit_component_collision_shape.disabled = false

func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")

func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		hit_component_collision_shape.position = Vector2(0, -20)
		animated_sprite_2d.play("water_back")
	elif player.player_direction == Vector2.DOWN:
		hit_component_collision_shape.position = Vector2(0, 3)
		animated_sprite_2d.play("water_front")
	elif player.player_direction == Vector2.LEFT:
		hit_component_collision_shape.position = Vector2(-9, 0)
		animated_sprite_2d.play("water_left")
	elif player.player_direction == Vector2.RIGHT:
		hit_component_collision_shape.position = Vector2(9, 0)
		animated_sprite_2d.play("water_right")
	else:
		animated_sprite_2d.play("water_front")

func _on_exit() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0, 0)
	animated_sprite_2d.stop()
