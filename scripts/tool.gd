@tool
extends EditorScript

func _run():
	# 获取当前编辑的场景
	var current_scene = get_scene()
	
	if not current_scene:
		print("请先打开一个场景")
		return
	
	# 递归处理所有节点
	scale_all_nodes(current_scene)
	print("节点属性已永久更新")

func scale_all_nodes(node: Node):
	# 处理有position属性的节点
	if node.has_method("set_position") and node.has_method("get_position"):
		var original_pos = node.get_position()
		node.set_position(original_pos * 2)
	
	# 处理有size属性的节点
	if node.has_method("set_size") and node.has_method("get_size"):
		var original_size = node.get_size()
		node.set_size(original_size * 2)
	
	# 处理子节点
	for child in node.get_children():
		scale_all_nodes(child)
