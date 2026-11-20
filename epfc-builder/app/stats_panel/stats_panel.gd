class_name StatsPanel extends MarginContainer

@onready var health_value: Label = %HealthValue
@onready var stamina_value: Label = %StaminaValue
@onready var weight_value: Label = %WeightValue
@onready var walking_value: Label = %WalkingValue
@onready var sprinting_value: Label = %SprintingValue
@onready var crouch_walking_value: Label = %CrouchWalkingValue
@onready var crouch_sprinting_value: Label = %CrouchSprintingValue
@onready var sliding_value: Label = %SlidingValue
@onready var dodge_crouching_value: Label = %DodgeCrouchingValue
@onready var dodge_sprinting_value: Label = %DodgeSprintingValue
@onready var item_lockpicking_value: Label = %ItemLockpickingValue
@onready var item_af_value: Label = %ItemAFValue
@onready var item_rewire_kit_value: Label = %ItemRewireKitValue
@onready var hacking_speed_value: Label = %HackingSpeedValue
@onready var hacking_resource_usage_value: Label = %HackingResourceUsageValue
@onready var detection_base_value: Label = %DetectionBaseValue
@onready var detection_crouched_value: Label = %DetectionCrouchedValue
@onready var detection_criminally_suspicious_value: Label = %DetectionCriminallySuspiciousValue
@onready var detection_armed_value: Label = %DetectionArmedValue
@onready var detection_disguised_value: Label = %DetectionDisguisedValue
@onready var detection_distance_base_value: Label = %DetectionDistanceBaseValue
@onready var detection_distance_crouched_value: Label = %DetectionDistanceCrouchedValue
@onready var detection_distance_disguised_value: Label = %DetectionDistanceDisguisedValue
@onready var detection_distance_pickpocketing_value: Label = %DetectionDistancePickpocketingValue

func _ready() -> void:
	Build.changed.connect(populate)
	
	populate()

func populate() -> void:
	health_value.text = "%dhp" % BuildCalculator.get_health()
	stamina_value.text = "%d" % BuildCalculator.get_stamina()
	weight_value.text = ""
	
	walking_value.text = "%.1f studs/s" % BuildCalculator.get_walking_speed()
	sprinting_value.text = "%.1f studs/s" % BuildCalculator.get_sprinting_speed()
	crouch_walking_value.text = "%.1f studs/s" % BuildCalculator.get_crouch_walking_speed()
	crouch_sprinting_value.text = "%.1f studs/s" % BuildCalculator.get_crouch_sprinting_speed()
	sliding_value.text = "%.1f studs/s" % BuildCalculator.get_sliding_speed()
	
	dodge_crouching_value.text = "%.1f%%" % (BuildCalculator.get_dodge_crouching() * 100)
	dodge_sprinting_value.text = "%.1f%%" % (BuildCalculator.get_dodge_sprinting() * 100)
	
	item_lockpicking_value.text = ""
	item_af_value.text = ""
	item_rewire_kit_value.text = ""
	
	hacking_speed_value.text = ""
	hacking_resource_usage_value.text = ""
	
	detection_base_value.text = ""
	detection_crouched_value.text = ""
	detection_criminally_suspicious_value.text = ""
	detection_armed_value.text = ""
	detection_disguised_value.text = ""
	detection_distance_base_value.text = ""
	detection_distance_crouched_value.text = ""
	detection_distance_disguised_value.text = ""
	detection_distance_pickpocketing_value.text = ""
