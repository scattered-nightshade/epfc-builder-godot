@tool class_name PlayerClass extends Node

enum CLASS_NAMES {
	FREELANCER = -1,
	BURGLAR = 1,
	HACKER = 2,
	TECH = 3,
	MERCENARY = 4,
	CONARTIST = 5,
	GHOST = 12,
	SABOTEUR = 13,
	COMMANDO = 14,
	THIEF = 15,
	SPECIALIST = 23,
	BREACHER = 24,
	INFILTRATOR = 25,
	ENGINEER = 34,
	SPY = 35,
	ASSASSIN = 45,
}

static func calculate_class_from_position(pos: Vector2) -> Array[PlayerClass.CLASS_NAMES]:
	var precise: float = fmod((atan2(pos.x, pos.y) / PI) * 2.5 + 5.5, 5.0)
	var floored: int = floori(precise)
	var diff: float = precise - floored
	
	var area: Array[PlayerClass.CLASS_NAMES] = [floored + 1 as PlayerClass.CLASS_NAMES]
	if diff <= 0.15:
		area.append((posmod(floored - 1, 5) + 1) as PlayerClass.CLASS_NAMES)
	elif diff >= 0.85:
		area.append((posmod(floored + 1, 5) + 1) as PlayerClass.CLASS_NAMES)
	
	return area
