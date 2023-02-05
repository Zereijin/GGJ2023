extends Container
class_name ShopCostContainer

@export var cost_icon:Texture2D
@export var cost_color:Color
@export var cost_value:int

var _costTextureRect
var _costLabel

func _ready():
	_costTextureRect = $CostTextureRect
	_costLabel = $CostLabelMarginContainer/CostLabel

	_costTextureRect.texture = cost_icon
	_costLabel.set("theme_override_colors/font_color", cost_color)
	_costLabel.text = str(cost_value)

func set_cost(newCost:String):
	_costLabel.text = newCost

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
