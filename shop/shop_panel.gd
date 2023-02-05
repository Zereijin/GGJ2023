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
		print("ShopPanel: No player found")

func open():
	update_shop_items()
	closeButton.grab_focus()
	visible = true

func close():
	closeButton.release_focus()
	visible = false

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

	maximumHealthStatContainer.set_enabled(player.can_afford(maximumHealthStatContainer.get_cost()))
	defenseStatContainer.set_enabled(player.can_afford(defenseStatContainer.get_cost()))
	movementSpeedStatContainer.set_enabled(player.can_afford(movementSpeedStatContainer.get_cost()))
	dodgeStatContainer.set_enabled(player.can_afford(dodgeStatContainer.get_cost()))
	luckStatContainer.set_enabled(player.can_afford(luckStatContainer.get_cost()))
	projectileDamageStatContainer.set_enabled(player.can_afford(projectileDamageStatContainer.get_cost()))
	projectileAttackSpeedStatContainer.set_enabled(player.can_afford(projectileAttackSpeedStatContainer.get_cost()))
	projectileCritChanceStatContainer.set_enabled(player.can_afford(projectileCritChanceStatContainer.get_cost()))
	projectileCountStatContainer.set_enabled(player.can_afford(projectileCountStatContainer.get_cost()))
	projectileAccuracyStatContainer.set_enabled(player.can_afford(projectileAccuracyStatContainer.get_cost()))
	screamDamageStatContainer.set_enabled(player.can_afford(screamDamageStatContainer.get_cost()))
	screamParalysisDurationStatContainer.set_enabled(player.can_afford(screamParalysisDurationStatContainer.get_cost()))
	screamChargeSpeedStatContainer.set_enabled(player.can_afford(screamChargeSpeedStatContainer.get_cost()))
	screamChargeMaximumStatContainer.set_enabled(player.can_afford(screamChargeMaximumStatContainer.get_cost()))
	healthRegenStatContainer.set_enabled(player.can_afford(healthRegenStatContainer.get_cost()))

func _on_maximum_health_upgrade_button_pressed():
	if (player.try_to_buy(maximumHealthStatContainer.get_cost())):
		player.maximum_health_level += 1
		update_shop_items()


func _on_defense_upgrade_button_pressed():
	if (player.try_to_buy(defenseStatContainer.get_cost())):
		player.defense_level += 1
		update_shop_items()


func _on_movement_speed_upgrade_button_pressed():
	if (player.try_to_buy(movementSpeedStatContainer.get_cost())):
		player.movement_speed_level += 1
		update_shop_items()


func _on_dodge_upgrade_button_pressed():
	if (player.try_to_buy(dodgeStatContainer.get_cost())):
		player.dodge_level += 1
		update_shop_items()


func _on_luck_upgrade_button_pressed():
	if (player.try_to_buy(luckStatContainer.get_cost())):
		player.luck_level += 1
		update_shop_items()


func _on_projectile_damage_upgrade_button_pressed():
	if (player.try_to_buy(projectileDamageStatContainer.get_cost())):
		player.projectile_damage_level += 1
		update_shop_items()


func _on_projectile_attack_speed_upgrade_button_pressed():
	if (player.try_to_buy(projectileAttackSpeedStatContainer.get_cost())):
		player.projectile_attack_speed_level += 1
		update_shop_items()


func _on_projectile_crit_chance_upgrade_button_pressed():
	if (player.try_to_buy(projectileCritChanceStatContainer.get_cost())):
		player.projectile_crit_chance_level += 1
		update_shop_items()


func _on_projectile_count_upgrade_button_pressed():
	if (player.try_to_buy(projectileCountStatContainer.get_cost())):
		player.projectile_count_level += 1
		update_shop_items()


func _on_projectile_accuracy_upgrade_button_pressed():
	if (player.try_to_buy(projectileAccuracyStatContainer.get_cost())):
		player.projectile_accuracy_level += 1
		update_shop_items()


func _on_scream_damage_upgrade_button_pressed():
	if (player.try_to_buy(screamDamageStatContainer.get_cost())):
		player.scream_damage_level += 1
		update_shop_items()


func _on_scream_paralysis_duration_upgrade_button_pressed():
	if (player.try_to_buy(screamParalysisDurationStatContainer.get_cost())):
		player.scream_paralysis_duration_level += 1
		update_shop_items()


func _on_scream_charge_speed_upgrade_button_pressed():
	if (player.try_to_buy(screamChargeSpeedStatContainer.get_cost())):
		player.scream_charge_speed_level += 1
		update_shop_items()


func _on_scream_charge_maximum_upgrade_button_pressed():
	if (player.try_to_buy(screamChargeMaximumStatContainer.get_cost())):
		player.scream_charge_maximum_level += 1
		update_shop_items()


func _on_health_regen_upgrade_button_pressed():
	if (player.try_to_buy(healthRegenStatContainer.get_cost())):
		player.health_regen_level += 1
		update_shop_items()
