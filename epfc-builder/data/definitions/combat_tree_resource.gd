@tool class_name CombatTreeResource extends Resource
# Honestly, this could've extended SkillWebResource but you can only override functions in Godot, not variables :/

@export var nodes: Array[CombatNodeResource] = []:
	set(value):
		nodes = value
		index.clear()

var index: Dictionary[int, CombatNodeResource] = {}

func get_perk_node(id: int) -> CombatNodeResource:
	if index.size() != nodes.size():
		index.clear()
		
		for _node in nodes:
			index.set(_node.id, _node)
		
	return index.get(id)

func has_id(id: int) -> bool:
	return get_perk_node(id) != null

func next_free_id() -> int:
	var highest: int = -1
	
	for node in nodes:
		if node:
			highest = maxi(highest, node.id)
	
	return highest + 1
