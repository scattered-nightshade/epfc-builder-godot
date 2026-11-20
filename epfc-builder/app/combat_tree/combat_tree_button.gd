@tool class_name CombatTreeButton extends TextureButton

@export var combat_node: CombatNodeResource

func setup(_combat_node: CombatNodeResource) -> void:
	combat_node = _combat_node
	name = "%d %s" % [combat_node.id, combat_node.get_display_name()]
	
	tooltip_text = "%s\n%s" % [combat_node.get_display_name(), combat_node.get_description()]
	
	texture_normal = combat_node.skill.unselected_icon
	texture_pressed = combat_node.skill.selected_icon
	texture_disabled = combat_node.skill.unselected_icon

func get_centre() -> Vector2:
	return get_global_rect().get_center()

func get_centre_in(canvas: CanvasItem) -> Vector2:
	return canvas.get_global_transform().affine_inverse() * get_global_rect().get_center()
