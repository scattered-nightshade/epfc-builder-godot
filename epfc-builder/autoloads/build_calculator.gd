extends Node

#region Skills
const SKILL_ADVANCED_PROTOCOLS: SkillResource = preload("res://data/skills/advanced_protocols.tres")
const SKILL_AGILITY: SkillResource = preload("res://data/skills/agility.tres")
const SKILL_APPLIED_FORCE: SkillResource = preload("res://data/skills/applied_force.tres")
const SKILL_AWARENESS: SkillResource = preload("res://data/skills/awareness.tres")
const SKILL_BRUTE_STRENGTH: SkillResource = preload("res://data/skills/brute_strength.tres")
const SKILL_CLIMBER: SkillResource = preload("res://data/skills/climber.tres")
const SKILL_CONDITIONING: SkillResource = preload("res://data/skills/conditioning.tres")
const SKILL_CRITICAL_INSIGHTS: SkillResource = preload("res://data/skills/critical_insights.tres")
const SKILL_DISCRETION: SkillResource = preload("res://data/skills/discretion.tres")
const SKILL_EFFICIENT_ALGORITHMS: SkillResource = preload("res://data/skills/efficient_algorithms.tres")
const SKILL_ELECTRICAL_ENGINEERING: SkillResource = preload("res://data/skills/electrical_engineering.tres")
const SKILL_EQUIPMENT_SPECIALIST: SkillResource = preload("res://data/skills/equipment_specialist.tres")
const SKILL_FAST_HANDS: SkillResource = preload("res://data/skills/fast_hands.tres")
const SKILL_INCONSPICUOUS: SkillResource = preload("res://data/skills/inconspicuous.tres")
const SKILL_INTIMIDATION: SkillResource = preload("res://data/skills/intimidation.tres")
const SKILL_LOCK_ARTIST: SkillResource = preload("res://data/skills/lock_artist.tres")
const SKILL_LOW_PROFILE: SkillResource = preload("res://data/skills/low_profile.tres")
const SKILL_MASQUERADE: SkillResource = preload("res://data/skills/masquerade.tres")
const SKILL_PICKPOCKET: SkillResource = preload("res://data/skills/pickpocket.tres")
const SKILL_REMOTE_ACCESS: SkillResource = preload("res://data/skills/remote_access.tres")
const SKILL_SIGNAL_DISRUPTION: SkillResource = preload("res://data/skills/signal_disruption.tres")
const SKILL_SOCIAL_ENGINEERING: SkillResource = preload("res://data/skills/social_engineering.tres")
const SKILL_TECHNICAL_EXPERT: SkillResource = preload("res://data/skills/technical_expert.tres")
const SKILL_TRAVERSAL: SkillResource = preload("res://data/skills/traversal.tres")
const SKILL_TRIANGULATION: SkillResource = preload("res://data/skills/triangulation.tres")
#endregion

#region CombatPerks
const PERK_AMMO_ECONOMY = preload("res://data/combat_perks/ammo_economy.tres")
const PERK_AMMO_RESERVES = preload("res://data/combat_perks/ammo_reserves.tres")
const PERK_ARMOUR_PROFICIENCY = preload("res://data/combat_perks/armour_proficiency.tres")
const PERK_BLAST_RADIUS = preload("res://data/combat_perks/blast_radius.tres")
const PERK_COUP_DE_GRACE = preload("res://data/combat_perks/coup_de_grace.tres")
const PERK_CRITICAL_STRIKE = preload("res://data/combat_perks/critical_strike.tres")
const PERK_EXECUTIONER = preload("res://data/combat_perks/executioner.tres")
const PERK_FIRE_CONTROL = preload("res://data/combat_perks/fire_control.tres")
const PERK_FULL_ARSENAL = preload("res://data/combat_perks/full_arsenal.tres")
const PERK_GUNSMITH = preload("res://data/combat_perks/gunsmith.tres")
const PERK_HANDLING_PROFICIENCY = preload("res://data/combat_perks/handling_proficiency.tres")
const PERK_HARD_TARGET = preload("res://data/combat_perks/hard_target.tres")
const PERK_LUCKY_SHOT = preload("res://data/combat_perks/lucky_shot.tres")
const PERK_MOBILE_ATTACKER = preload("res://data/combat_perks/mobile_attacker.tres")
const PERK_ORDNANCE_SUPPLY = preload("res://data/combat_perks/ordnance_supply.tres")
const PERK_REAPER = preload("res://data/combat_perks/reaper.tres")
const PERK_REFINED_COMPOSITION = preload("res://data/combat_perks/refined_composition.tres")
const PERK_REINFORCEMENT = preload("res://data/combat_perks/reinforcement.tres")
const PERK_SCAVENGER = preload("res://data/combat_perks/scavenger.tres")
const PERK_TACTICAL_COORDINATION = preload("res://data/combat_perks/tactical_coordination.tres")
const PERK_UNDERTAKER = preload("res://data/combat_perks/undertaker.tres")
const PERK_VITALITY = preload("res://data/combat_perks/vitality.tres")
const PERK_VITAL_TARGETS = preload("res://data/combat_perks/vital_targets.tres")
const PERK_WEAPON_OF_CHOICE = preload("res://data/combat_perks/weapon_of_choice.tres")
#endregion

#region Base Values

const BASE_HEALTH: int = 100
const BASE_STAMINA: int = 100

#region Speed
const BASE_SPEED_WALKING: float = 14
const BASE_SPEED_SPRINTING: float = 22
const BASE_SPEED_CROUCH_WALK: float = 9.5
const BASE_SPEED_CROUCH_SPRINTING: float = 14.7
const BASE_SPEED_SLIDING: float = 22
#endregion

#region Detection
const BASE_DETECTION_TIME: float = 1.56

const BASE_DETECTION_MULT_CRIMINALLY_SUSPICIOUS: float = 1.25
const BASE_DETECTION_MULT_ARMED: float = 1.5
const BASE_DETECTION_MULT_DISGUISED: float = 0.55

const BASE_DETECTION_RANGE: float = 50
const BASE_DETECTION_RANGE_DISGUISED: float = 22.5
const BASE_DETECTION_RANGE_PICKPOCKETING: float = 20
const BASE_DETECTION_RANGE_PICKPOCKETING_3: float = 10
const BASE_DETECTION_RANGE_ENFORCER_PICKPOCKETING: float = 50

#endregion

const BASE_LOCKPICKING_SPEED: float = 100
const BASE_APPLIED_FORCE_SPEED: float = 100
const BASE_REWIRE_SPEED: float = 100
const BASE_HACKING_SPEED: float = 1.0
const BASE_HACKING_RESOURCE_USAGE: float = 1.0

#endregion

#region Effects
const BRUTE_STRENGTH_1_SPEED_MULT_PENALTY_REDUCTION: float = 0.75
const AGILITY_1_SPRINT_SPEED: float = 24
const AGILITY_1_SLIDING_SPEED: float = 24
const AGILITY_1_CROUCH_WALK_SPEED: float = 10.5

const CONDITIONING_STAMINA_INCREASE: int = 6

#These are set to 5 instead of 0.05 because of the loss of precision surrounding floats
const FAST_HANDS_LOCKPICKING_SPEED_INCREASE: float = 5
const APPLIED_FORCE_SPEED_INCREASE: float = 5
const TECHNICAL_EXPERT_REWIRE_SPEED_INCREASE: float = 5

const HARD_TARGET_DODGE_VALUE: float = 0.20
const LOW_PROFILE_DODGE_INCREASE: float = 0.03

const BACKPACK_WEIGHT_REDUCTION: float = 0.8
const TACTICAL_PACK_WEIGHT_REDUCTION: float = 0.8

const ENCUMBRANCE_DODGE_REDUCTION: float = 0.0208
const ENCUMBRANCE_SPEED_LOW_REDUCTION: float = 0.01
const ENCUMBRANCE_SPEED_HIGH_REDUCTION: float = 0.02375
const ENCUMBRANCE_BRUTE_STRENGTH_1_PENALTY_REDUCTION: float = 0.25

#region Detection
const DETECTION_SPEED_RECRUIT: float = 0.5
const DETECTION_SPEED_OPERATIVE: float = 0.75
const DETECTION_SPEED_LEGEND: float = 1.0
const DETECTION_SPEED_TACTICAL_1: float = 1.1
const DETECTION_SPEED_TACTICAL_2: float = 1.2
const DETECTION_SPEED_TACTICAL_3: float = 1.3

const DETECTION_SPEED_ARMED_STATUS_MULT: float = 1.5
const DETECTION_SPEED_CRIMINAL_ACTIONS_MULT: float = 1.25 ## Active when the player is: Armored, Majorly Trespassing, doing Criminally Suspicious actions or holding a Dangerous Item
const DETECTION_SPEED_BAG_EQUIPPED_MULT: float = 1.20
const DETECTION_SPEED_CALM_MULT: float = 0.8
const DETECTION_SPEED_NORMAL_MULT: float = 0.9
const DETECTION_SPEED_DISGUISED_MULT: float = 0.55

const DETECTION_RANGE_BAG_MULT: float = 1.20
const DETECTION_RANGE_SATCHEL_MULT: float = 1.10
const DETECTION_RANGE_INCONSPICUOUS_2_MULT: float = 0.88

const LOW_PROFILE_DETECTION_REDUCTION: float = 0.04
const DISCRETION_DETECTION_REDUCTION: float = 0.05
const MASQUERADE_DETECTION_REDUCTION: float = 0.03
const SIGNAL_DISRUPTION_DETECTION_REDUCTION: float = 0.04
#endregion

#endregion

#region Breakpoints
const BREAKPOINT_ENCUMBRANCE_DODGE_MULT: int = 12
const BREAKPOINT_ENCUMBRANCE_STAMINA_USAGE_LOW: int = 14
const BREAKPOINT_ENCUMBRANCE_STAMINA_USAGE_HIGH: int = 22
const BREAKPOINT_ENCUMBRANCE_SPEED_MULT_LOW: int = 22
const BREAKPOINT_ENCUMBRANCE_SPEED_MULT_HIGH: int = 38


#endregion

#region

func get_health() -> int:
	return BASE_HEALTH

func get_stamina() -> int:
	return BASE_STAMINA + (Build.count_group(SKILL_CONDITIONING) * CONDITIONING_STAMINA_INCREASE)

func get_weight() -> float:
	return 0

func get_raw_weight() -> float:
	return 0

#region encumbrance
func get_encumbrance_dodge_mult() -> float:
	var excess_weight: float = maxf(get_raw_weight() - BREAKPOINT_ENCUMBRANCE_DODGE_MULT, 0.0)
	return maxf(1.0 - excess_weight * ENCUMBRANCE_DODGE_REDUCTION, 0.0)

func get_encumbrance_speed_mult() -> float:
	var weight: float = get_weight()
	
	var excess_weight_low: float = clampf(weight - BREAKPOINT_ENCUMBRANCE_SPEED_MULT_LOW, 0.0, BREAKPOINT_ENCUMBRANCE_SPEED_MULT_HIGH - BREAKPOINT_ENCUMBRANCE_SPEED_MULT_LOW)
	var excess_weight_high: float = clampf(weight - BREAKPOINT_ENCUMBRANCE_SPEED_MULT_HIGH, 0.0, 8)
	
	var penalty_low: float = excess_weight_low * ENCUMBRANCE_SPEED_LOW_REDUCTION
	var penalty_high: float = excess_weight_high * ENCUMBRANCE_SPEED_HIGH_REDUCTION
	
	var penalty: float = penalty_low + penalty_high
	
	if Build.count_group(SKILL_BRUTE_STRENGTH) >= 1:
		penalty *= 1.0 - ENCUMBRANCE_BRUTE_STRENGTH_1_PENALTY_REDUCTION
	
	return 1.0 - penalty
#endregion

#region movement speed
func get_walking_speed() -> float:
	return BASE_SPEED_WALKING * get_encumbrance_speed_mult()

func get_sprinting_speed() -> float:
	if Build.count_group(SKILL_AGILITY) >= 1:
		return AGILITY_1_SPRINT_SPEED * get_encumbrance_speed_mult()
	
	return BASE_SPEED_SPRINTING * get_encumbrance_speed_mult()

func get_crouch_walking_speed() -> float:
	if Build.count_group(SKILL_AGILITY) >= 1:
		return AGILITY_1_CROUCH_WALK_SPEED * get_encumbrance_speed_mult()
	
	return BASE_SPEED_CROUCH_WALK * get_encumbrance_speed_mult()

func get_crouch_sprinting_speed() -> float:
	return BASE_SPEED_CROUCH_SPRINTING * get_encumbrance_speed_mult()

func get_sliding_speed() -> float:
	if Build.count_group(SKILL_AGILITY) >= 1:
		return AGILITY_1_SLIDING_SPEED * get_encumbrance_speed_mult()
	
	return BASE_SPEED_SLIDING * get_encumbrance_speed_mult()
#endregion

#region dodge
func get_dodge_crouching() -> float:
	var lp_dodge: float = Build.count_group(SKILL_LOW_PROFILE) * 0.03
	var ht_dodge: float = 0.0
	
	if Build.has_skill(PERK_HARD_TARGET):
		ht_dodge = 0.20
	
	return (lp_dodge + ht_dodge) * get_encumbrance_dodge_mult()

func get_dodge_sprinting() -> float:
	if Build.has_skill(PERK_HARD_TARGET):
		return 0.20
	
	return 0.0
#endregion

#region items
func get_lockpicking_speed() -> float:
	return BASE_LOCKPICKING_SPEED + (Build.count_group(SKILL_FAST_HANDS) * FAST_HANDS_LOCKPICKING_SPEED_INCREASE)

func get_af_speed() -> float:
	return BASE_APPLIED_FORCE_SPEED + (Build.count_group(SKILL_APPLIED_FORCE) * APPLIED_FORCE_SPEED_INCREASE)

func get_rewire_speed() -> float:
	return BASE_REWIRE_SPEED + (Build.count_group(SKILL_TECHNICAL_EXPERT) * TECHNICAL_EXPERT_REWIRE_SPEED_INCREASE)
#endregion

#region hacking

func get_hacking_speed() -> float:
	return BASE_HACKING_SPEED + (Build.count_group(SKILL_EFFICIENT_ALGORITHMS) * 0.05)

func get_hacking_resource_usage() -> float:
	return BASE_HACKING_RESOURCE_USAGE * (1 - (Build.count_group(SKILL_CRITICAL_INSIGHTS) * 0.05))

#endregion

#region detection times
func get_base_detection_time() -> float:
	return BASE_DETECTION_TIME

func get_crouched_detection_time() -> float:
	return get_base_detection_time() / (1 - (Build.count_group(SKILL_LOW_PROFILE) * LOW_PROFILE_DETECTION_REDUCTION))

func get_criminally_suspicious_detection_time() -> float:
	return get_base_detection_time() / (BASE_DETECTION_MULT_CRIMINALLY_SUSPICIOUS * (1 - (Build.count_group(SKILL_DISCRETION) * DISCRETION_DETECTION_REDUCTION)))

func get_armed_detection_time() -> float:
	return get_base_detection_time() / BASE_DETECTION_MULT_ARMED

func get_disguised_detection_time() -> float:
	return get_base_detection_time() / (BASE_DETECTION_MULT_DISGUISED * (1 - (Build.count_group(SKILL_MASQUERADE) * MASQUERADE_DETECTION_REDUCTION)))

func get_camera_detection_time() -> float:
	return get_base_detection_time() / (1 - (Build.count_group(SKILL_SIGNAL_DISRUPTION) * SIGNAL_DISRUPTION_DETECTION_REDUCTION))
#endregion

#region detection distances

func get_detection_range_mult() -> float:
	var detection_mult: float = 1.0
	
	if Build.count_group(SKILL_INCONSPICUOUS) >= 2:
		detection_mult = DETECTION_RANGE_INCONSPICUOUS_2_MULT
	
	return detection_mult

func get_base_detection_range() -> float:
	return BASE_DETECTION_RANGE * get_detection_range_mult()

func get_disguised_detection_range() -> float:
	return BASE_DETECTION_RANGE_DISGUISED * get_detection_range_mult()

func get_pickpocketing_detection_range() -> float:
	var detection_range: float = BASE_DETECTION_RANGE_PICKPOCKETING
	
	if Build.count_group(SKILL_PICKPOCKET) >= 3:
		detection_range = BASE_DETECTION_RANGE_PICKPOCKETING_3
	
	return detection_range * get_detection_range_mult()

#endregion

#endregion
