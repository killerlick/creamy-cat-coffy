extends Node2D
class_name ElementSpawned

@export var element : Food_elements
var dragging = true
@onready var area : Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position()

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
	var arrea = area.get_overlapping_areas()
	for obj in arrea:
		var objPar = obj.get_parent()
		if objPar is Drink:
			objPar.add_ingredient(element)
			print("ajouter a la boisson")
			queue_free()
			return
	queue_free()
