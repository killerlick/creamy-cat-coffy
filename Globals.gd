#globals.gd
extends Node

@export var t : Array[int]

enum CAT_PART_CUSTOMIZE {HEAD , EARS , MOUTH , NOSE , CLOTHES}
enum CAT_MOOD {GOOD , MID , BAD}

enum DRINK_COMPOSANT {ADDON , GLASS , LIQUID , POWDER , TOPPING} #De quoi est composé la boisson

enum ADDONS {BOBA , SEED}  #L'interieur de la boisson qui soit solide ou semi
enum GLASSES {SMALL , MEDIUM , LARGE} #Le verre dans le quel est bu la boisson
enum LIQUID { COFFEE , TEA , WATER , SPARKLINGWATER } #Le liquide utilisé
enum POWDER {MATCHA , MILK , STARBERRY} #La poudre , comme celui du cacao pour du chocolat chaud
enum TOPPING { CACAO , MILKCREAM , SPARKLES} #Un truc qui se mets par dessus la boisson

enum FOOD_TYPE{DRINK , FOOD}

var sound : int = 100
var money : int = 0
var upgrades : Array = []
var day : int = 0

var head : CustomizeItem
var ears : CustomizeItem
var mouth : CustomizeItem
var nose : CustomizeItem
var clothes : CustomizeItem


#nombre de place au comptoir
var level_slot = 4
