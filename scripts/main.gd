extends Node2D
 

func _ready() -> void:
	print("cat café - jour ",Globals.day)


func _on_start_day_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_cozy_mode_button_up() -> void:
	pass # Replace with function body.


func _on_customize_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/customize.tscn") # Replace with function body.
