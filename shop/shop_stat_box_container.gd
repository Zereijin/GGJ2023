extends HBoxContainer
class_name ShopStatContainer

@export var stat_name = "Stat" ## User-facing name of the stat
@export var stat_icon: Texture2D
@export_range(0,10) var stat_level: int = 1 ## Current level of the stat
@export var upgrade_cost_r: Array[int]
@export var upgrade_cost_g: Array[int]
@export var upgrade_cost_b: Array[int]

var _statNameLabel: Label
var _statIcon: TextureRect
var _progressBar: ProgressBar
var _rCostContainer: ShopCostContainer
var _gCostContainer: ShopCostContainer
var _bCostContainer: ShopCostContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	_statNameLabel = $StatNameLabel
	_statIcon = $StatIcon
	_progressBar = $ProgressBar
	_rCostContainer = $CostsContainer/RCostContainer
	_gCostContainer = $CostsContainer/GCostContainer
	_bCostContainer = $CostsContainer/BCostContainer
	
	_statNameLabel.text = stat_name
	_statIcon.texture = stat_icon
	set_level(stat_level)

func set_level(newLevel):
	stat_level = newLevel
	_progressBar.value = stat_level
	update_costs()

func update_costs():
	if (stat_level >= 10):
		_rCostContainer.set_cost("-")
		_gCostContainer.set_cost("-")
		_bCostContainer.set_cost("-")
	else:
		_rCostContainer.set_cost(str(upgrade_cost_r[stat_level]))
		_gCostContainer.set_cost(str(upgrade_cost_g[stat_level]))
		_bCostContainer.set_cost(str(upgrade_cost_b[stat_level]))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
