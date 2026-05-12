extends Node2D

var drink_data : DrinkData

@onready var addons_sprite_container : Node2D = $addons
@onready var liquid_sprite : Sprite2D = $liquid
@onready var glass_sprite : Sprite2D = $glasses
@onready var powder_sprite : Sprite2D = $powder
@onready var topping_sprite_container : Node2D = $topping

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawning_topping()
	spawning_addon()

func spawning_addon() -> void:
	for child in addons_sprite_container.get_children():
		child.queue_free()
	for addon in drink_data.addons:
		var sprite = Sprite2D.new()
		sprite.texture = addon.element_sprite[0]
		addons_sprite_container.add_child(sprite)


func spawning_topping() -> void:
	for child in topping_sprite_container.get_children():
		child.queue_free()
	for topping in drink_data.topping:
		var sprite = Sprite2D.new()
		sprite.texture = topping.element_sprite[0]
		topping_sprite_container.add_child(sprite)


func change_water_color(flavor :String) -> void:
	if drink_data.liquid.element_name == "water":
		#un truc pour changer la couler de l'eau
		pass
	pass
