extends Node2D
class_name Drink

var drink_data : DrinkData = DrinkData.new()
var is_selected : bool = false
var dragging : bool = false
var is_instantiate : bool = false
var is_in_plateau = false
var is_in_central = false
var current_spot = null

@onready var addons_sprite_container : Node2D = $addons
@onready var liquid_sprite : Sprite2D = $liquid
@onready var glass_sprite : Sprite2D = $glasses
@onready var powder_sprite : Sprite2D = $powder
@onready var topping_sprite_container : Node2D = $topping
@onready var area :Area2D = $Area2D
@onready var label : Label = $Label


func _ready() -> void:
		spawning_topping()
		spawning_addon()

func _process(delta: float) -> void:
	if dragging :
		global_position = get_global_mouse_position()
	#print(global_position)

func _exit_tree() -> void:
	if is_queued_for_deletion():
		print("bye")
	else:
		print("juste reparent")


#ajoute element dans le drink, aussi affiche le bon sprite
func add_ingredient(drinkElement : Drink_elements):
	if(have_ingredient(drinkElement)):
		return
	if drinkElement is AddonElement:
		drink_data.addons.append(drinkElement)
	elif drinkElement is LiquidElement:
		drink_data.liquid = drinkElement
		#liquid_sprite.texture = drinkElement.element_sprite[glass_number()]
	elif drinkElement is GlassElement:
		drink_data.glass = drinkElement
		#glass_sprite.texture = drinkElement.element_sprite[0]
	elif drinkElement is PowderElement:
		drink_data.powder = drinkElement
		#powder_sprite.texture = drinkElement.element_sprite[glass_number()]
	elif  drinkElement is ToppingElement:
		drink_data.toppings.append(drinkElement)
	else :
		print("ingredient non reconnu")
	put_text(drinkElement.element_name)
	#refresh_sprite()

#retourne le numero du verre
func glass_number() ->int :
	var nb =null
	match drink_data.glass.type:
		Globals.GLASSES.SMALL:
			nb=0
		Globals.GLASSES.MEDIUM:
			nb =1
		Globals.GLASSES.LARGE:
			nb=2
	return nb

#verifie si le drink a deja le DrinkElement
func have_ingredient(foodElement : Drink_elements) -> bool:
	if foodElement is LiquidElement:
		return drink_data.liquid == foodElement
	if foodElement is AddonElement:
		return drink_data.addons.has(foodElement)
	if foodElement is ToppingElement:
		return drink_data.toppings.has(foodElement)
	if foodElement is PowderElement:
		return drink_data.powder == foodElement
	return false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and is_selected ==true:
					dragging=true
			else:
				if dragging:
					dragging = false
					on_drop()

#insert du text dan le label
func put_text(string : String) :
	if label.text == "":
		label.text += string
	else:
		label.text += "\n" + string

#action quand tu lache le verre quelque part
#enlever la boucle if pour un "match"
#raccourcie la fonction , trop longue pour rien
func on_drop():
	dragging = false
	var overlappings = area.get_overlapping_areas()
	
	for obj in overlappings:
		var objParent = obj.get_parent()
		
		if objParent is Cat:#quand donner au chat
			objParent.receive_drink(drink_data)
			queue_free()
			return
			
		elif obj.is_in_group("drink_spots") and objParent is Cuisine and is_in_central == false:#quand deposer sur lassiette de creation
			var cuisine : Cuisine = objParent
			if cuisine.central_spot.drink != null:
				break
			if is_in_plateau:
				is_in_plateau = false
				cuisine.remove_from_spot(self)
			is_instantiate = true
			is_in_central = true
			objParent.put_drink_in_central(self)
			return
				
		elif obj.is_in_group("plateau") and objParent is Cuisine and is_in_plateau==false:#quand deposer sur le plateau
			var cuisine : Cuisine = objParent
			if cuisine.plateau_free_spot() == false:
				break
			if is_in_central:
				is_in_central =false
				cuisine.remove_from_central(self)
			is_instantiate = true
			is_in_plateau = true
			objParent.put_drink_in_spot(self)
			return
				
		elif obj.is_in_group("poubelle") and is_instantiate:#quand deposer sur la poubelle
			print("jeter dans poubelle ")
			queue_free()
			return
			
	if not is_instantiate:
		queue_free()
		print("dommage")
	elif current_spot != null:
		global_position = current_spot.marker.global_position

#refresh les sprite des addons et topping (car plusieurs)
func refresh_sprite():
	spawning_addon()
	spawning_topping()

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
