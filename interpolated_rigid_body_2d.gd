# Copyright © 2019 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends RigidBody2D

const SPEED := 50

onready var sprite := $Sprite as Sprite

export var use_interpolation := true

# The accumulated motion
var motion := Vector2()

# Interpolation timer (set to 0.0 on every physics step)
var interp_timer := 0.0

# Recent transforms
var transforms := [transform, transform]

func _ready() -> void:
	sprite.set_as_toplevel(true)

func _process(delta: float) -> void:
	interp_timer += delta

	var old_transform: Transform2D = transforms[transforms.size() - 2]
	var new_transform: Transform2D = transforms[transforms.size() - 1]

	if use_interpolation:
		sprite.transform = old_transform.interpolate_with(new_transform, interp_timer * Engine.iterations_per_second)
	else:
		sprite.transform = transform

func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	interp_timer = 0.0
	transforms.push_back(transform)
	transforms.pop_front()

	# Acceleration
	motion.x += Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y += Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# Friction
	motion *= 0.85

	linear_velocity = motion * SPEED

func _on_interpolation_button_toggled(button_pressed: bool) -> void:
	use_interpolation = button_pressed
