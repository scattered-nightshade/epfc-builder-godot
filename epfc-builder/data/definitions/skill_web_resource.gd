@tool class_name SkillWebResource extends Resource

@export var nodes: Array[SkillNodeResource] = []:
	set(value):
		nodes = value
		index.clear()

@export_tool_button("Refresh", "Callable") var refresh_button = refresh

var index: Dictionary[int, SkillNodeResource] = {}

func get_skill_node(id: int) -> SkillNodeResource:
	if index.size() != nodes.size():
		index.clear()
		
		for node in nodes:
			index.set(node.id, node)
		
	return index.get(id)

func has_id(id: int) -> bool:
	return get_skill_node(id) != null

func neighbours(id: int) -> Array[SkillNodeResource]:
	var result: Array[SkillNodeResource] = []
	var node: SkillNodeResource = get_skill_node(id)
	
	if node:
		for conn_id in node.connections:
			var conn := get_skill_node(conn_id)
			if conn:
				result.append(conn)
	
	return result

func next_free_id() -> int:
	var highest: int = -1
	for node in nodes:
		if node:
			highest = maxi(highest, node.id)
	
	return highest + 1

func refresh() -> void:
	for skill_node in nodes:
		skill_node.player_class = PlayerClass.calculate_class_from_position(skill_node.position)
		skill_node.refresh_name()
	
	emit_changed()
