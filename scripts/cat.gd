
class_name Cat
extends Node2D


var drink_wanted : DrinkData

@onready var cat_sprite : Sprite2D = $"Cat sprite"
@onready var bar_attente : ProgressBar = $Bar_attente
@onready var order_bubble : Node2D =$Order_bubble
@onready var order_text : Label = $Order_text

 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drink_wanted=DrinkData.new()
	await generate_drink()
	print(drink_wanted.to_string())
	set_order_text(drink_wanted.get_all_ingredients())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_order_text(orders:Array[String]):
	var text = ""
	for ingredient in orders:
		text+= "-"+ingredient+"\n"
	order_text.text = text
	


func generate_drink() -> void :
	drink_wanted.random_drink()
