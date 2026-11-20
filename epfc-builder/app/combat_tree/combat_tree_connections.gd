class_name CombatTreeConnections extends Control

@onready var combat_tree: CombatTree = $".."

@export var line_color_locked: Color = Color("c0c0c0")
@export var line_color_unlocked: Color = Color("ffffff")
@export var line_width: float = 6.0
@export var cross_size: float = 20.0

func _draw() -> void:
	for id in combat_tree.buttons:
		var butt: CombatTreeButton = combat_tree.buttons.get(id)
		for conn_butt_id in butt.combat_node.mutual_exclusivity:
			var connection_butt: CombatTreeButton = combat_tree.buttons.get(conn_butt_id)
			
			if connection_butt == null:
				continue
			
			# This here prevents redraws
			if conn_butt_id < id && id in connection_butt.combat_node.mutual_exclusivity:
				continue
			
			var butt_centre: Vector2 = butt.get_centre() - global_position
			var connection_butt_centre: Vector2 = connection_butt.get_centre() - global_position
			
			draw_line(butt_centre, connection_butt_centre, line_color_locked, line_width, true)
			
			var direction: Vector2 = (connection_butt_centre - butt_centre).normalized()
			var cross_centre = (butt_centre + connection_butt_centre) / 2
			
			var cross_top_left_bottom_right: Vector2 = direction.rotated(PI / 4) * cross_size
			var cross_bottom_left_top_right: Vector2 = direction.rotated(-PI / 4) * cross_size
			
			draw_line(cross_centre - cross_top_left_bottom_right, cross_centre + cross_top_left_bottom_right, line_color_locked, line_width, true)
			draw_line(cross_centre - cross_bottom_left_top_right, cross_centre + cross_bottom_left_top_right, line_color_locked, line_width, true)
	
	#draw_line(Vector2(100, 100), Vector2(200, 200), line_color_locked, line_width, true)
