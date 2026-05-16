class_name DrinkData
extends Resource

var addons : Array[AddonElement]
var liquid : LiquidElement
var glass : GlassElement
var powder : PowderElement
var toppings : Array[ToppingElement]

#retourne le coup de la boisson normalement
func cost()-> int:
	var drink_cost : int = 0
	drink_cost += liquid.element_cost
	drink_cost += glass.element_cost
	drink_cost += powder.element_cost
	for a in addons:
		drink_cost += a.element_cost
	for t in toppings:
		drink_cost += t.element_cost
	return drink_cost

#verifie si 2 boisson sont les memes
func is_equal(drink : DrinkData) -> bool:

	if liquid != drink.liquid:
		return false

	if glass != drink.glass:
		return false

	if powder != drink.powder:
		return false

	if addons != drink.addons:
		return false

	if toppings != drink.toppings:
		return false

	return true

func get_all_ingredients() -> Array[String]:
	var ingredients:Array[String] = []
	
	ingredients.append(liquid.element_name)
	ingredients.append(glass.element_name)
	if powder != null:
		ingredients.append(powder.element_name)
	for addon in addons:
		ingredients.append(addon.element_name)
	for topping in toppings:
		ingredients.append(topping.element_name)
	return ingredients

func random_drink()->void:
	
	addons.clear()
	toppings.clear()
	
	for i in range(randi_range(0,1)):
			addons.append(Globals.ALL_ADDONS.pick_random())
	
	for i in range(randi_range(0,1)):
		toppings.append(Globals.ALL_TOPPING.pick_random())
	
	liquid = Globals.ALL_LIQUID.pick_random()
	glass = Globals.ALL_GLASSES.pick_random()
	if liquid.allow_powder:
		powder = Globals.ALL_POWDER.pick_random()

func _to_string() -> String:

	var text = ""
	text += "Glass : " + str(glass.element_name) + "\n"
	text += "Liquid : " + str(liquid.element_name) + "\n"
	if powder != null:
		text += "Powder : " + str(powder.element_name) + "\n"

	text += "Addons : "
	for addon in addons:
		text += addon.element_name + ", "

	text += "\nToppings : "
	for topping in toppings:
		text += topping.element_name + ", "

	return text
