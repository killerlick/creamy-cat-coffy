class_name Cat
extends Node2D


var drink_wanted : DrinkData

var mouse_inside := false

@export var cat_data : CatResource

var cat_mood : Globals.CAT_MOOD

var cat_sprite : Sprite2D = Sprite2D.new()


@onready var timer : Timer = $patience
@onready var bar_attente : ProgressBar = $Bar_attente
@onready var order_bubble : Node2D =$Order_bubble
@onready var order_text : Label = $Order_bubble/Order_text
@onready var area : Area2D = $Area2D
@onready var animation : AnimationPlayer = $AnimationPlayer
 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cat_sprite.texture = cat_data.body_sprite[0]
	drink_wanted=DrinkData.new()
	await generate_drink()
	set_order_text(drink_wanted.get_all_ingredients())
	timer.wait_time = cat_data.timer
	
	bar_attente.max_value = timer.wait_time
	bar_attente.value = timer.time_left
	animation.play("ready")

func _process(delta: float) -> void:
	if timer.time_left> 0 :
		bar_attente.value = timer.time_left

func receive_drink(drink : DrinkData) -> void:
	var good_command = drink.is_equal(drink_wanted)
	if good_command == true:
		get_good_served()
		quitting()
	else:
		get_bad_command()
	


func get_good_served() -> void : 
	print("bonne command")

func get_bad_command() -> void:
	print("mauvaise commande")
	timer.wait_time -= 4

func quitting()->void:
	animation.play("quit")
	bar_attente.visible = false
	order_bubble.visible = false

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

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "ready"):
		begin_timer() 
	elif(anim_name == "quit"):
		queue_free()

func begin_timer() :
	timer.start()

func _on_patience_timeout() -> void:
	animation.play("done") 
