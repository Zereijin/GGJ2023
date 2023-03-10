extends HBoxContainer
class_name ShopStatContainer

@export var stat_name = "Stat" ## User-facing name of the stat
@export var stat_icon: Texture2D
@export_range(0,10) var stat_level: int = 1 ## Current level of the stat
@export var upgrade_cost_r: Array[int]
@export var upgrade_cost_g: Array[int]
@export var upgrade_cost_b: Array[int]

@onready var _upgradeButton: Button = $UpgradeButton
@onready var _statNameLabel: Label = $StatNameLabel
@onready var _statIcon: TextureRect = $StatIcon
@onready var _progressBar: ProgressBar = $ProgressBar
@onready var _rCostContainer: ShopCostContainer = $CostsContainer/RCostContainer
@onready var _gCostContainer: ShopCostContainer = $CostsContainer/GCostContainer
@onready var _bCostContainer: ShopCostContainer = $CostsContainer/BCostContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	_statNameLabel.text = stat_name
	_statIcon.texture = stat_icon
	set_level(stat_level)
	set_enabled(false)

func set_level(newLevel):
	stat_level = newLevel
	_progressBar.value = stat_level
	update_costs()

func set_enabled(enabled):
	_upgradeButton.disabled = not enabled

func update_costs():
	if (stat_level >= 10):
		_rCostContainer.set_cost("-")
		_gCostContainer.set_cost("-")
		_bCostContainer.set_cost("-")
	else:
		_rCostContainer.set_cost(str(upgrade_cost_r[stat_level]))
		_gCostContainer.set_cost(str(upgrade_cost_g[stat_level]))
		_bCostContainer.set_cost(str(upgrade_cost_b[stat_level]))

func get_cost() -> Array[int]:
	if stat_level < upgrade_cost_r.size():
		return [upgrade_cost_r[stat_level], upgrade_cost_g[stat_level], upgrade_cost_b[stat_level]]
	else:
		return [2000000000, 2000000000, 2000000000]
