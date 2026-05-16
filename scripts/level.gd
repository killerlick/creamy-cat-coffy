extends Node2D

var in_kitchen : bool = false
var posX : float = 0.0
var cat_structure : PackedScene

@onready var camera2d : Camera2D = $Camera2D
@onready var comptoir : Comptoir = $Comptoir
@onready var cuisine : Cuisine = $Cuisine

var slot_available : int = Globals.level_slot
var slots_state : Array

func _ready() -> void:
	cat_structure = preload("res://scenes/Cat.tscn")
	var nodes = get_tree().get_nodes_in_group("chats_"+str(slot_available))
	for node in nodes:
		slots_state.append({
			"position" : node.position,
			"available" : true
		})


func _process(delta: float) -> void:
	camera2d.position.x = lerp(camera2d.position.x, posX, 5.0*delta) #change de scene de facon fluide

func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("Right"):
		if in_kitchen == false:
			change_scene()
	elif(event.is_action_pressed("Left")):
		if in_kitchen == true:
			change_scene()
	if event.is_action_pressed("spawn_cat"):
		spawn_cat()


#comptoir to cuisine , cuisine to comptoir
func change_scene() -> void :
	if(in_kitchen == false):
		in_kitchen = true
		posX = 1920
	elif(in_kitchen == true):
		in_kitchen = false
		posX = 0.0

func spawn_cat()-> void:
	var cat = cat_structure.instantiate()
	for i in slots_state:
		if i.available == true:
			cat.position = i.position
			i.available = false
			add_child(cat)
			break
	
