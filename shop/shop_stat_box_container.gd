extends HBoxContainer

@export var stat_name = "Stat" ## User-facing name of the stat
@export var stat_icon: Texture2D
@export_range(0,10) var stat_level: int = 1 ## Current level of the stat
@export var upgrade_cost_r: Array[int]
@export var upgrade_cost_g: Array[int]
@export var upgrade_cost_b: Array[int]

var _statNameLabel: Label
var _statIcon: TextureRect
var _progressBar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	_statNameLabel = $StatNameLabel
	_statIcon = $StatIcon
	_progressBar = $ProgressBar
	
	_statNameLabel.text = stat_name
	_statIcon.texture = stat_icon
	_progressBar.value = stat_level
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
