extends Node2D

@export var maxHealth = 1: set = setMaxHealth
@export var maxMana = 1: set = setMaxMana
@export var gold = 0: set = setGold
var health = maxHealth: set = setHealth
var mana = maxMana: set = setMana

signal noHealth
signal noMana
signal healthChanged(value)
signal maxHealthChanged(value)
signal manaChanged(value)
signal maxManaChanged(value)
signal goldChanged(value)
signal initHealth(value)

func init_health(value):
	self.health = value
	self.maxHealth = value

func setMaxHealth(value):
	maxHealth = value
	self.health = min(health, maxHealth)
	emit_signal("maxHealthChanged", maxHealth)

func setHealth(value):
	health = value
	emit_signal("healthChanged", health)
	if health <= 0:
		emit_signal("noHealth")
		
func setMaxMana(value):
	maxMana = value
	self.mana = min(mana, maxMana)
	emit_signal("maxManaChanged", maxMana)

func setMana(value):
	mana = value
	emit_signal("manaChanged", mana)
	if mana == 0:
		emit_signal("noMana")
		
func setGold(value):
	gold = value
	emit_signal("goldChanged", gold)

func restart():
	self.health = maxHealth
	self.mana = maxMana

func _ready():
	self.health = maxHealth
	self.mana = maxMana
