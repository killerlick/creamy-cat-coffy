extends Node2D

var in_kitchen : bool = false
var posX : float = 0.0

@onready var camera2d : Camera2D = $Camera2D

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera2d.position.x = lerp(camera2d.position.x, posX, 5.0*delta) #change de scene de facon fluide

func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("Right"):
		if in_kitchen == false:
			change_scene()
	elif(event.is_action_pressed("Left")):
		if in_kitchen == true:
			change_scene()

#comptoir to cuisine , cuisine to comptoir
func change_scene() -> void :
	if(in_kitchen == false):
		in_kitchen = true
		posX = 1920
	elif(in_kitchen == true):
		in_kitchen = false
		posX = 0.0
