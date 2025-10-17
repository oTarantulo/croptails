extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var shake_timer: Timer = $ShakeTimer

var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	shake_timer.timeout.connect(_on_timer_timeout)

func on_hurt(hit_damage: int) -> void:
	shake_timer.stop()
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 1.0)
	#await get_tree().create_timer(1.0).timeout
	#material.set_shader_parameter("shake_intensity", 0.5)
	shake_timer.start()

func _on_timer_timeout() -> void:
	material.set_shader_parameter("shake_intensity", 0.5)
	print("Shake timeout!")
func on_max_damage_reached() -> void:
	print("Max damage reached!")
	call_deferred("add_log_scene")
	queue_free()

func add_log_scene() -> void:
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)
