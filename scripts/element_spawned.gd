extends Node2D
class_name ElementSpawned

@export var element : Food_elements
var dragging = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
					dragging=true
			else:
				if dragging:
					dragging = false
					on_drop()

func on_drop():
	var area = get
