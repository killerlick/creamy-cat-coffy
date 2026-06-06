extends CanvasLayer
class_name Ui

@onready var level_money =  $Control/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/BoxContainer2/Money


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_money( money : int):
	level_money.text = str(money) + " $"
