class_name Cat
extends Node2D


var drink_wanted : DrinkData

var mouse_inside := false

@export var cat_data : CatResource

var cat_mood : Globals.CAT_MOOD

@onready var timer : Timer = $patience

var cat_sprite : Sprite2D = Sprite2D.new()
@onready var bar_attente : ProgressBar = $Bar_attente
@onready var order_bubble : Node2D =$Order_bubble
@onready var order_text : Label = $Order_bubble/Order_text
@onready var area : Area2D = $Area2D
@onready var animation : AnimationPlayer = $AnimationPlayer
 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cat_sprite.texture = cat_data.body_sprite[0]
	animation.play("ready")
	drink_wanted=DrinkData.new()
	await generate_drink()
	print(drink_wanted.to_string())
	set_order_text(drink_wanted.get_all_ingredients())

func receive_drink(drink : DrinkData) -> void:
	var good_command = drink.is_equal(drink_wanted)
	if good_command == true:
		get_good_served()
	else:
		print("mauvaise commande")

func get_good_served() -> void : 
	print("bonne command")
	queue_free()

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
