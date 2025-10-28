extends Control

@onready var once: Node = $Once
@onready var each_time: Node = $EachTime
@onready var each_round_begin: Node = $EachRoundBegin
@onready var each_round_over: Node = $EachRoundOver
@onready var each_project_delivery: Node = $EachProjectDelivery



func get_all_buffs() -> Array[Buff]:
	var buffs : Array[Buff]
	for i in get_children():
		for j in i.get_children():
			if j is Buff:
				buffs.append(j)
	return buffs

func buff_name_to_buff(buff_name : String) -> Buff:
	var bs = get_all_buffs()
	for b in bs:
		if b.name == buff_name:
			return b
	return null


@export var buff_icon: Node
@export var buff_icons: Node
var buff_and_icon_list := []
func add_buff_icon(node: Node):
	if node is Buff:
		var icon_node = buff_icon.duplicate()
		buff_icons.add_child(icon_node)
		icon_node.set_icon(node)
		
		var buff_and_icon = [node, icon_node]
		buff_and_icon_list.append(buff_and_icon)
func erase_buff_icon(node: Node):
	if node is Buff:
		for BAI in buff_and_icon_list:
			if BAI[0] == node:
				#if is_instance_valid(BAI[1]):
					#if is_instance_valid(BAI[1].buff_description):
						#BAI[1].buff_description.queue_free()
					#if is_instance_valid(BAI[1]):
				BAI[1].buff_description.queue_free()
				BAI[1].queue_free()
				buff_and_icon_list.erase(BAI)
				return
		print("can not find buff icon that should be queue_free() in BuffManager _on_child_ex")
