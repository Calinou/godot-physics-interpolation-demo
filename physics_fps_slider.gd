extends HSlider

onready var label := $"../Label" as Label

func _ready():
	_on_value_changed(value)

func _on_value_changed(value: float) -> void:
	Engine.iterations_per_second = int(value)
	label.text = "Physics FPS: " + str(value)
