class_name Cat
extends Node2D


var drink_wanted : DrinkData

var mouse_inside := false

@onready var cat_sprite : Sprite2D = $"Cat sprite"
@onready var bar_attente : ProgressBar = $Bar_attente
@onready var order_bubble : Node2D =$Order_bubble
@onready var order_text : Label = $Order_bubble/Order_text
@onready var area : Area2D = $Area2D

 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drink_wanted=DrinkData.new()
	await generate_drink()
	print(drink_wanted.to_string())
	set_order_text(drink_wanted.get_all_ingredients())

func receive_drink(drink : DrinkData) -> void:
	var good_command = drink.is_equal(drink_wanted)
	if good_command == true:
		print("bonne command")
	else:
		print("mauvaise commande")


func set_order_text(orders:Array[String]):
	var text = ""
	for ingredient in orders:
		text+= "-"+ingredient+"\n"
	order_text.text = text


func generate_drink() -> void :
	drink_wanted.random_drink()


func _on_area_2d_mouse_entered() -> void:
	mouse_inside = true


func _on_area_2d_mouse_exited() -> void:
	mouse_inside = false
