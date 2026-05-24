class_name Food_elements
extends Resource

@export var element_name : String # nom de l'element

#exemple : [0]=small cup , [1]=medium , [2]=big
#ou [0] peut etre l'element de base dans le cas des glass(cest lui qui donne la forme donc normal)
@export var element_sprite : Array[Texture2D] 
@export var element_cost : int # 3 dollard par exemple
