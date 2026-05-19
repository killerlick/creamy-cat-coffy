extends Node2D
class_name ElementSpawner

@onready var area : Area2D = $Area2D
@onready var label : Label = $Label

@export var element_scene : PackedScene
@export var element_resource : Food_elements

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if element_resource != null:
		label.text = element_resource.element_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				spawn_element()

func spawn_element():
	var element = element_scene.instantiate()
	element.dragging = true
	get_tree().current_scene.add_child(element)
	element.element = element_resource
	element.global_position = get_global_mouse_position()
