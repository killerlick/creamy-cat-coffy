class_name Cuisine
extends Node2D

@export var destination_position : Marker2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_to_comptoir(object : Node2D) -> Vector2:
	object.position = destination_position.position
	return destination_position.position 
