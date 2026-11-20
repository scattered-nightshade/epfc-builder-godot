class_name CombatTree extends Control

const COMBAT_TREE = preload("res://data/combat_tree/combat_tree.tres")
const COMBAT_TREE_BUTTON = preload("res://app/combat_tree/combat_tree_button.tscn")

@export var line_color_locked: Color = Color("c0c0c0")
@export var line_width: float = 6.0

var buttons: Dictionary[int, CombatTreeButton] = {}

@onready var connections: CombatTreeConnections = %Connections

@onready var tier_4_container: HBoxContainer = %Tier4Container
@onready var tier_3_container: HBoxContainer = %Tier3Container
@onready var tier_2_container: HBoxContainer = %Tier2Container
@onready var tier_1_container: HBoxContainer = %Tier1Container

@onready var tier_4_lock: TextureRect = %Tier4Lock
@onready var tier_3_lock: TextureRect = %Tier3Lock
@onready var tier_2_lock: TextureRect = %Tier2Lock

@onready var TIERS: Dictionary[int, HBoxContainer] = {
	4: tier_4_container,
	3: tier_3_container,
	2: tier_2_container,
	1: tier_1_container
}

@onready var TIER_LOCKS: Dictionary[int, TextureRect] = {
	4: tier_4_lock,
	3: tier_3_lock,
	2: tier_2_lock
}

const TIER_REQUIREMENTS: Dictionary[int, int] = {
	4: 6,
	3: 4,
	2: 2,
	1: 0
}

func _ready() -> void:
	populate()
	
	Build.changed.connect(on_build_changed)
	on_build_changed()

func populate() -> void:
	for butt in buttons.values():
		butt.queue_free()
	
	buttons.clear()
	
	if COMBAT_TREE == null:
		return
	
	for node in COMBAT_TREE.nodes:
		if node == null:
			continue
		
		var butt: CombatTreeButton = COMBAT_TREE_BUTTON.instantiate()
		
		butt.setup(node)
		
		
		var butt_tier: int = node.tier
		(TIERS.get(butt_tier, tier_1_container) as HBoxContainer).add_child(butt)
		
		buttons.set(node.id, butt)
		
		butt.toggled.connect(on_button_toggled.bind(node))
		butt.item_rect_changed.connect(connections.queue_redraw)

func on_button_toggled(state: bool, node: CombatNodeResource) -> void:
	if state:
		for mutually_exclusive_node_id in get_mutual_exclusivity(node):
			if Build.is_perk_allocated(mutually_exclusive_node_id):
				Build.set_perk_allocated(mutually_exclusive_node_id, false)
				
				sync_button(mutually_exclusive_node_id)
	
	Build.set_perk_allocated(node.id, state)
	
	sync_button(node.id)
	

func sync_button(id: int) -> void:
	var butt: CombatTreeButton = buttons.get(id)
	
	if butt:
		butt.set_pressed_no_signal(Build.is_perk_allocated(id))

func get_mutual_exclusivity(node: CombatNodeResource) -> Array[int]:
	var ids: Array[int] = node.mutual_exclusivity.duplicate()
	
	for butt: CombatTreeButton in buttons.values():
		var _node: CombatNodeResource = butt.combat_node
		
		if _node.id != node.id && node.id in _node.mutual_exclusivity && _node.id not in ids:
			ids.append(_node.id)
	
	return ids

func on_build_changed() -> void:
	for tier in TIERS:
		var lock: TextureRect = TIER_LOCKS.get(tier)
		if lock:
			lock.visible = !is_tier_unlocked(tier)
	
	for id in buttons:
		var butt: CombatTreeButton = buttons.get(id)
		var allocated: bool = Build.is_perk_allocated(id)
		
		butt.set_pressed_no_signal(allocated)
		butt.disabled = !allocated && !can_select(butt.combat_node)
	
	connections.queue_redraw()

func is_tier_unlocked(tier: int) -> bool:
	return Build.get_perk_points_below_tier(tier) >= TIER_REQUIREMENTS.get(tier, 0)

func can_select(node: CombatNodeResource) -> bool:
	if !is_tier_unlocked(node.tier):
		return false
	
	if Build.combat_points_allocated < Build.combat_point_cap:
		return true
	
	for other_id in get_mutual_exclusivity(node):
		if Build.is_perk_allocated(other_id):
			return true
	
	return false
