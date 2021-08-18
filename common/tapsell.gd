extends Node

# ----- Tapsell plugin signels ---
#"on_rewarded_done"
#"on_opened"
#"on_closed"
#"on_expiring"
#"on_no_ad_available"
#"on_error"
#"on_no_network"
#"native_ad_filled"

var tapsellPlugin
var tapsell_plugin_name = "GodotTapsellPlugin"


func _ready():
	if Engine.has_singleton(tapsell_plugin_name):
		tapsellPlugin = Engine.get_singleton(tapsell_plugin_name)
		tapsellPlugin.initPlugin()
	else:
		print("Could not load plugin: ", tapsell_plugin_name)
	

