extends Node2D

var is_selected := false

@export var drink_scene : PackedScene
@export var drink_resource : Food_elements

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index ==  MOUSE_BUTTON_LEFT:
			if event.pressed and is_selected==true:
				spawn_drink()


func spawn_drink():
	var drink : Drink = drink_scene.instantiate()
	drink.dragging = true
	get_tree().current_scene.add_child(drink)
	drink.add_ingredient(drink_resource)	
	drink.global_position = get_global_mouse_position()



func _on_area_2d_mouse_entered() -> void:
	is_selected = true # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	is_selected = false # Replace with function body.
