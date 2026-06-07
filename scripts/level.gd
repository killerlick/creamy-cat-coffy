extends Node2D

var in_kitchen : bool = false
var posX : float = 0.0
var cat_structure : PackedScene
var money_level : int  = 0 

@onready var camera2d : Camera2D = $Camera2D
@onready var comptoir : Comptoir = $Comptoir
@onready var cuisine : Cuisine = $Cuisine
@onready var ui : Ui = $UI

@export var level : int = 0
@export var goal : float = 0.0
@export var client_number : int = 0 



var slot_available : int = Globals.level_slot #le nombre des espaces disponibles
var slots_state : Array #letat des differents espace disponible

func _ready() -> void:
	cat_structure = preload("res://scenes/objects/Cat.tscn")
	var nodes = get_tree().get_nodes_in_group("chats_"+str(slot_available))
	for node in nodes:
		slots_state.append({
			"marker" : node,
			"available" : true ,
			"cat" : null
		})


func _process(delta: float) -> void:
	#print(cuisine.plateau_de_verre.position)
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
		cuisine.in_kitchen = true
		posX = 1920
	elif(in_kitchen == true):
		in_kitchen = false
		cuisine.in_kitchen = false
		posX = 0.0

func spawn_cat()-> void:
	var cat = cat_structure.instantiate()
	for i in range(slots_state.size()):
		if slots_state[i].available == true:
			cat.position = slots_state[i].marker.position
			slots_state[i].available = false
			slots_state[i].cat = cat
			cat.tree_exited.connect(func():
				cat_removed(cat)
			)
			add_child(cat)
			break

func cat_removed(cat : Cat) -> void:
	add_money(cat.get_money())
	for slot in slots_state:
		if slot.cat == cat:
			slot.cat = null
			slot.available = true
			break

func add_money(money : int):
	money_level += money
	ui.update_money(money_level)
	
