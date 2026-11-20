extends Node

signal changed()

const SKILL_WEB = preload("res://data/skill_web/skill_web.tres")
const COMBAT_TREE = preload("res://data/combat_tree/combat_tree.tres")
var skills: Dictionary[int, bool] = {}
var combat_perks: Dictionary[int, bool] = {}

var level: int = 50
var skill_point_cap: int = 50
var combat_point_cap: int = 8
var skill_points_allocated: int = 0
var combat_points_allocated: int = 0

#region Level
func get_level() -> int:
	return level

func set_level(value: int) -> void:
	level = value
	
	skill_point_cap = clampi(level, 0, 50)
	combat_point_cap = clampi(floori(level/6), 0, 8)
	
	values_changed()
#endregion

#region Skill Web

func is_skill_allocated(id: int) -> bool:
	return skills.get(id, false)

func set_skill_allocated(id: int, state: bool) -> bool:
	if !SKILL_WEB.has_id(id):
		return false
	
	if state && !can_allocate_skill(id):
		return false
	
	skills.set(id, state)
	
	values_changed()
	return true

func get_allocated_skill_ids() -> Array[int]:
	var active: Array[int] = []
	for skill in skills:
		if skills.get(skill):
			active.append(skill)
	
	return active

func get_skill_points_allocated() -> int:
	return skill_points_allocated

func can_allocate_skill(id: int) -> bool:
	var skill_node: SkillNodeResource = SKILL_WEB.get_skill_node(id)
	var connections: Array[int] = skill_node.connections.duplicate()
	
	if skill_points_allocated >= skill_point_cap:
		return false
	
	for conn_id in connections:
		if is_skill_allocated(conn_id):
			return true
		else:
			continue
	
	if skill_node.core && skill_points_allocated == 0:
		return true
	
	return false

func get_allocated_skill_nodes() -> Array[SkillNodeResource]:
	var result: Array[SkillNodeResource] = []
	
	for id in get_allocated_skill_ids():
		result.append(SKILL_WEB.get_skill_node(id))
	
	return result

func get_allocated_skills() -> Array[SkillResource]:
	var result: Array[SkillResource] = []
	
	for node in get_allocated_skill_nodes():
		if node.skill:
			result.append(node.skill)
	
	return result
#endregion

#region Combat Perks
func is_perk_allocated(id: int) -> bool:
	return combat_perks.get(id, false)

func set_perk_allocated(id: int, state: bool) -> bool:
	if !COMBAT_TREE.has_id(id):
		return false
	
	if state && !can_allocate_perk(id):
		return false
	
	combat_perks.set(id, state)
	
	values_changed()
	return true

func get_allocated_perk_ids() -> Array[int]:
	var active: Array[int] = []
	
	for skill in combat_perks:
		if combat_perks.get(skill):
			active.append(skill)
	
	return active

func get_allocated_combat_nodes() -> Array[CombatNodeResource]:
	var result: Array[CombatNodeResource] = []
	
	for id in get_allocated_perk_ids():
		result.append(COMBAT_TREE.get_perk_node(id))
	
	return result

func get_allocated_perks() -> Array[CombatPerkResource]:
	var result: Array[CombatPerkResource] = []
	
	for node in get_allocated_combat_nodes():
		if node.skill:
			result.append(node.skill)
	
	return result

func can_allocate_perk(id: int) -> bool:
	var node: CombatNodeResource = COMBAT_TREE.get_perk_node(id)
	if node == null:
		return false
	
	if is_perk_allocated(id):
		return true
	
	if combat_points_allocated >= combat_point_cap:
		return false
	
	return get_perk_points_below_tier(node.tier) >= (node.tier - 1) * 2

func get_perk_points_below_tier(tier: int) -> int:
	var count: int = 0
	
	for node in get_allocated_combat_nodes():
		if node.tier < tier:
			count += 1
	
	return count

#endregion

#region Helper Stuff
func apply_build(skill_ids: Array, perk_ids: Array, new_level: int) -> void:
	skills.clear()
	combat_perks.clear()
	
	for id in skill_ids:
		if SKILL_WEB.has_id(int(id)):
			skills.set(int(id), true)
	
	for id in perk_ids:
		if COMBAT_TREE.has_id(int(id)):
			combat_perks.set(int(id), true)
	
	level = new_level
	values_changed()

func clear() -> void:
	skills.clear()
	combat_perks.clear()
	values_changed()

func values_changed() -> void:
	var allocated_skill_count = 0
	var allocated_perk_count = 0
	
	for state in skills.values():
		if state:
			allocated_skill_count += 1
	
	for state in combat_perks.values():
		if state:
			allocated_perk_count += 1
	
	skill_points_allocated = allocated_skill_count
	combat_points_allocated = allocated_perk_count
	
	changed.emit()

func has_skill(skill: SkillResource) -> bool:
	if skill is CombatPerkResource:
		return skill in get_allocated_perks()
	
	return skill in get_allocated_skills()

func count_group(skill: SkillResource) -> int:
	if skill is CombatPerkResource:
		return get_allocated_perks().count(skill)
	
	return get_allocated_skills().count(skill)
#endregion
