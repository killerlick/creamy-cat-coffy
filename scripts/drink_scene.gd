extends Node2D
class_name Drink

var original_position : Vector2
var drink_data : DrinkData = DrinkData.new()
var is_selected : bool = false
var dragging : bool = false
var is_instantiate : bool = false

@onready var addons_sprite_container : Node2D = $addons
@onready var liquid_sprite : Sprite2D = $liquid
@onready var glass_sprite : Sprite2D = $glasses
@onready var powder_sprite : Sprite2D = $powder
@onready var topping_sprite_container : Node2D = $topping
@onready var area :Area2D = $Area2D
@onready var label : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

		spawning_topping()
		spawning_addon()

func _process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position()

func add_ingredient(drinkElement : Drink_elements):
	if drinkElement is AddonElement:
		drink_data.addons.append(drinkElement)
	elif drinkElement is LiquidElement:
		drink_data.liquid = drinkElement
	elif drinkElement is GlassElement:
		drink_data.glass = drinkElement
	elif drinkElement is PowderElement:
		drink_data.powder = drinkElement
	elif  drinkElement is ToppingElement:
		drink_data.toppings.append(drinkElement)
	else :
		print("ingredient non reconnu")
	put_text(drinkElement.element_name)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and is_selected ==true:
					dragging=true
			else:
				if dragging:
					dragging = false
					on_drop()

func put_text(string : String) :
	label.text += string


func on_drop():
	var overlappings = area.get_overlapping_areas()
	for obj in overlappings:
		var objParent = obj.get_parent()
		print(objParent)
		if objParent is Cat:
			objParent.receive_drink(drink_data)
			queue_free()
			return
		elif obj.is_in_group("drink_spots"):
			print(obj)
			original_position = obj.position
			is_instantiate = true
			position = original_position
			return
	if not is_instantiate:
		queue_free()
		print("dommage")
	else :
		position = original_position

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
	for topping in drink_data.toppings:
		var sprite = Sprite2D.new()
		sprite.texture = topping.element_sprite[0]
		topping_sprite_container.add_child(sprite)

func _on_area_2d_mouse_entered() -> void:
	is_selected = true # Replace with function body.

func _on_area_2d_mouse_exited() -> void:
	is_selected = false # Replace with function body.
