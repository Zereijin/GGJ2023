extends Control

@export var player : Player

@onready var maximumHealthStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/BodyVBoxContainer/HealthStatContainer
@onready var defenseStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/BodyVBoxContainer/DefenseStatContainer
@onready var movementSpeedStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/BodyVBoxContainer/MovementSpeedStatContainer
@onready var dodgeStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/BodyVBoxContainer/DodgeStatContainer
@onready var luckStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/BodyVBoxContainer/LuckStatContainer
@onready var projectileDamageStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/GunVBoxContainer/ProjectileDamageStatContainer
@onready var projectileAttackSpeedStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/GunVBoxContainer/AttackSpeedStatContainer
@onready var projectileCritChanceStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/GunVBoxContainer/CritStatContainer
@onready var projectileCountStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/GunVBoxContainer/ProjectileCountStatContainer
@onready var projectileAccuracyStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/GunVBoxContainer/AccuracyStatContainer
@onready var screamDamageStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/ScreamVBoxContainer/ScreamDamageStatContainer
@onready var screamParalysisDurationStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/ScreamVBoxContainer/ParalysisDurationStatContainer
@onready var screamChargeSpeedStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/ScreamVBoxContainer/ChargeSpeedStatContainer
@onready var screamChargeMaximumStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/ScreamVBoxContainer/ChargeMaxStatContainer
@onready var healthRegenStatContainer : ShopStatContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer/ScreamVBoxContainer/HealthRegenStatContainer

@onready var closeButton : Button = $PanelContainer/MarginContainer/VBoxContainer/CloseButtonMarginContainer/CloseButton

# Called when the node enters the scene tree for the first time.
func _ready():
	if (player):
		update_shop_items()
	else:
		print("No player found :(")
	closeButton.grab_focus()

func update_shop_items():
	maximumHealthStatContainer.set_level(player.maximum_health_level)
	defenseStatContainer.set_level(player.defense_level)
	movementSpeedStatContainer.set_level(player.movement_speed_level)
	dodgeStatContainer.set_level(player.dodge_level)
	luckStatContainer.set_level(player.luck_level)
	projectileDamageStatContainer.set_level(player.projectile_damage_level)
	projectileAttackSpeedStatContainer.set_level(player.projectile_attack_speed_level)
	projectileCritChanceStatContainer.set_level(player.projectile_crit_chance_level)
	projectileCountStatContainer.set_level(player.projectile_count_level)
	projectileAccuracyStatContainer.set_level(player.projectile_accuracy_level)
	screamDamageStatContainer.set_level(player.scream_damage_level)
	screamParalysisDurationStatContainer.set_level(player.scream_paralysis_duration_level)
	screamChargeSpeedStatContainer.set_level(player.scream_charge_speed_level)
	screamChargeMaximumStatContainer.set_level(player.scream_charge_maximum_level)
	healthRegenStatContainer.set_level(player.health_regen_level)
