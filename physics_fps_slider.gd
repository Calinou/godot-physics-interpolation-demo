# Copyright © 2019 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends HSlider

onready var label := $"../Label" as Label

func _ready():
	_on_value_changed(value)

func _on_value_changed(value: float) -> void:
	Engine.iterations_per_second = int(value)
	label.text = "Physics FPS: " + str(value)
