extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var shake_timer: Timer = $ShakeTimer

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	shake_timer.timeout.connect(_on_timer_timeout)

func on_hurt(hit_damage: int) -> void:
	shake_timer.stop()
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 0.6)
	shake_timer.start()

func _on_timer_timeout() -> void:
	material.set_shader_parameter("shake_intensity", 0.0)
	print("Shake timeout!")
func on_max_damage_reached() -> void:
	print("Max damage reached!")
	call_deferred("add_stone_scene")
	queue_free()

func add_stone_scene() -> void:
	var stone_instance = stone_scene.instantiate() as Node2D
	stone_instance.global_position = global_position
	get_parent().add_child(stone_instance)
