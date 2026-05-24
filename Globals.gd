#globals.gd
extends Node

@export var t : Array[int]

enum CAT_PART_CUSTOMIZE {HEAD , EARS , MOUSE , NOSE , CLOTHES}
enum CAT_MOOD {GOOD , MID , BAD}

enum DRINK_COMPOSANT {ADDON , GLASS , LIQUID , POWDER , TOPPING} #De quoi est composé la boisson

enum ADDONS {BOBA , SEED}  #L'interieur de la boisson qui soit solide ou semi
enum GLASSES {SMALL , MEDIUM , LARGE} #Le verre dans le quel est bu la boisson
enum LIQUID { COFFEE , TEA , WATER , SPARKLINGWATER } #Le liquide utilisé
enum POWDER {MATCHA , MILK , STARBERRY} #La poudre , comme celui du cacao pour du chocolat chaud
enum TOPPING { CACAO , MILKCREAM , SPARKLES} #Un truc qui se mets par dessus la boisson

enum FOOD_TYPE{DRINK , FOOD}

#tout les ressources a utilisés pour le jeu

var ALL_ADDONS : Array[AddonElement]   
var ALL_GLASSES : Array[GlassElement]  
var ALL_LIQUID : Array[LiquidElement]   
var ALL_POWDER : Array[PowderElement]   
var ALL_TOPPING : Array[ToppingElement]  

#nombre de place au comptoir
var level_slot = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_ressource_from_folder("res://assets/ressources/addon/",ALL_ADDONS)
	load_ressource_from_folder("res://assets/ressources/glass/",ALL_GLASSES)
	load_ressource_from_folder("res://assets/ressources/liquid/",ALL_LIQUID)
	load_ressource_from_folder("res://assets/ressources/powder/",ALL_POWDER)
	load_ressource_from_folder("res://assets/ressources/toppings/",ALL_TOPPING)


func load_ressource_from_folder(path:String ,array_resource : Array) -> void :
	var dir = DirAccess.open(path)
	
	if (dir == null):
		print("impossible d'ouvrir le dossier")
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		
		if file_name.ends_with(".tres"):
			var ressource_path = path + "/" + file_name
			var res = load(ressource_path)
			array_resource.append(res)
		file_name = dir.get_next()
	dir.list_dir_end()
