extends Node

@onready var once: Node = $Once
@onready var each_time: Node = $EachTime
@onready var each_round_begin: Node = $EachRoundBegin
@onready var each_round_over: Node = $EachRoundOver
@onready var each_project_delivery: Node = $EachProjectDelivery
@onready var each_debug_card_use: Node = $EachDebugCardUse
@onready var each_activity_card_use: Node = $EachActivityCardUse



func get_all_buffs() -> Array[Buff]:
	var buffs : Array[Buff]
	for buff_type in get_children():
		for buff : Buff in buff_type.get_children():
			buffs.append(buff)
	return buffs

func buff_name_to_buff(buff_name : String) -> Buff:
	var bs = get_all_buffs()
	for b in bs:
		if b.name == buff_name:
			return b
	return null
