class_name Main extends HBoxContainer

@onready var skill_web: SkillWeb = %SkillWeb
@onready var combat_tree: CombatTree = %CombatTree
@onready var inventory: Inventory = %Inventory

@onready var reset_skill_web_button: Button = %ResetSkillWebButton
@onready var reset_combat_tree_button: Button = %ResetCombatTreeButton
@onready var reset_inventory_button: Button = %ResetInventoryButton
@onready var reset_all_button: Button = %ResetAllButton

func _ready() -> void:
	reset_skill_web_button.pressed.connect(reset_skill_web)
	reset_combat_tree_button.pressed.connect(reset_combat_tree)
	reset_inventory_button.pressed.connect(reset_inventory)
	reset_all_button.pressed.connect(reset_all)

func reset_skill_web() -> void:
	skill_web.reset()

func reset_combat_tree() -> void:
	combat_tree.reset()

func reset_inventory() -> void:
	inventory.reset()

func reset_all() -> void:
	reset_skill_web()
	reset_combat_tree()
	reset_inventory()
