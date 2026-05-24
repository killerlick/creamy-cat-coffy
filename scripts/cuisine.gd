class_name Cuisine
extends Node2D

var in_kitchen : bool = false

var central_spot 
@onready var central_marker : Marker2D = $Drink_Spot/Marker2D


@export var cuisine_position : Marker2D
@export var comptoir_position : Marker2D
@onready var plateau_de_verre : Node2D = $"plateau de service"
var plateau_slot_state : Array = []

func _ready() -> void:
	central_spot = {
		"marker" = central_marker,
		"drink" = null
	}
	var nodes = get_tree().get_nodes_in_group("drinks_plateau_spots")
	for node in nodes:
		plateau_slot_state.append(
			{
				"marker" : node,
				"drink" : null
			}
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_x
	if(in_kitchen == true):
		target_x = cuisine_position.global_position.x
	else:
		target_x = comptoir_position.global_position.x
	plateau_de_verre.global_position.x = lerp(plateau_de_verre.global_position.x, target_x ,10.0*delta)

func put_drink_in_central(drink : Drink):
	if central_spot.drink == null:
		central_spot.drink = drink
		drink.current_spot = central_spot
		drink.reparent(central_spot.marker)
		drink.position = Vector2.ZERO

func remove_from_central(drink : Drink):
	if central_spot.drink == drink:
		drink.current_spot.drink =null
		drink.current_spot = null

func put_drink_in_spot(drink : Drink):
	for spot in plateau_slot_state:
		if spot.drink==null:
			spot.drink = drink
			drink.current_spot = spot
			drink.reparent(spot.marker)
			drink.position = Vector2.ZERO
			break

func remove_from_spot(drink:Drink):
	if drink.current_spot != null:
		drink.current_spot.drink = null
		drink.current_spot = null

func plateau_free_spot() -> bool:
	for node in plateau_slot_state:
		if node.drink == null:
			return true
	return false
