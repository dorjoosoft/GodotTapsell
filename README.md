<p><strong><span style="font-size:18px">GodotTapsell</span>:</strong></p>
<p> Godot Tapsell plugin implemented based on <span style="font-size:16px"><strong>Godot 3.2.2+</strong></span> android plugin standards.<br />
This plugin uses <a href="https://docs.tapsell.ir/tapsell-sdk/android/initialize/">Tapsell sdk</a>.</p>
<p><span style="font-size:18px"><strong>Tapsell &quot;reward video&quot; and &quot;native banner&quot; are supported in godotTapsell plugin.</strong></span></p>

<p><strong><span style="font-size:18px">prerequisite</span>:</strong></p>

<p>Install&nbsp;<a href="https://docs.godotengine.org/en/stable/getting_started/workflow/export/android_custom_build.html">Custom builds for Android</a> using official godot engine documention.</p>

<p><span style="font-size:18px"><strong>Installation:</strong></span></p>

<p>Download latest release from <a href="https://github.com/dorjoosoft/GodotTapsell/releases">release page</a>&nbsp;and extract content&nbsp;to<strong> [your_project_path]/android/plugins </strong>folder.</p>

<p>Enable plugin on export dialog.</p>
<img src="https://github.com/dorjoosoft/GodotCafebazaar/blob/main/docs/tempsnip.png" alt="Enable plugin"/>

<p>From "Project>Project settings" dialog do steps 1 and 2 as you see in below image: </p>
<img src="https://github.com/dorjoosoft/GodotTapsell/blob/main/docs/Screenshot%20from%202021-08-19%2000-10-55.png" alt="Enable plugin"/>

<p>In <strong>[your_project_path]/android/build/config.gradle </strong>file change kotlin version to <strong>kotlinVersion : &#39;1.4.0&#39; .</strong></p>

<p><strong>Note:</strong> You have to activate your&nbsp;VPN before build after this settings by now!</p>

<p><strong>Note: </strong>This plugin just works on your build on device.</p>

<p><strong><span style="font-size:18px">Connect to plugin in Godot:</span></strong><br />
Download&nbsp;<a href="https://github.com/dorjoosoft/GodotTapsell/blob/main/common/tapsell.gd">tapsell.gd</a>&nbsp;&nbsp;file and add it to your games common folder and add it to your Autoload.</p>
<img src="https://github.com/dorjoosoft/GodotTapsell/blob/main/docs/Screenshot%20from%202021-08-18%2021-48-28.png" alt="Enable plugin"/>
 
<p><span style="font-size:20px"><strong>1- How to implement &quot;Reward Video&quot;:</strong></span></p>

<pre>
<code class="language-python">
#connecting events
func _ready():
	if Engine.has_singleton(Tapsell.tapsell_plugin_name):
		Tapsell.tapsellPlugin.connect("on_rewarded_done", self, "on_rewarded_done")
		Tapsell.tapsellPlugin.connect("on_no_network", self, "on_no_network")
		Tapsell.tapsellPlugin.connect("on_no_ad_available", self, "on_no_ad_available")
		Tapsell.tapsellPlugin.connect("on_error", self, "on_error")


#request a reward video 
func on_checknet_success():
    #call this method with your ad zone_id
	Tapsell.tapsellPlugin.requestAd("5sdf15s551f5a15sdf4465") 


#runs after your reward video finished successful
func on_rewarded_done(result):
	if str(result) == "true":
		#give the reward to user


#runs if no video available that is reported from tapsell
func on_no_ad_available():
	# run your decision if no video available from tapsell</code></pre>
	

<p><span style="font-size:20px"><strong>1- How to implement &quot;native banner&quot;:</strong></span></p>

<pre>
<code class="language-python">
#connecting events
func request_ad(zoneId):
	if Engine.has_singleton(Tapsell.tapsell_plugin_name):
        #connect to banner load event
		Tapsell.tapsellPlugin.connect("native_ad_filled", self, "native_ad_filled")
        #call for a native banner from tapsell
		Tapsell.tapsellPlugin.getNativeAdd(zoneId)


# calls when your native banner is available
func native_ad_filled(adParams):
	adFilled = adParams	
    #adParams filles with parts of your native banner.
    adParams["iconUrl"],           #iconUrl of native banner
    adParams["callToActionText"]   #call to action text
	adParams["landscapeImageUrl"], #url of landscape image of banner
    adParams["description"],       #description of native banner
    adParams["zoneId"],
    adParams["adId"]


#you can use this function for loading images of native banner from tapsell
func load_image(imgUrl):
	var http_error = $HTTPRequest.request(str(imgUrl))

#runs after image is loaded
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var image = Image.new()
	print_debug("response_code", body)
	var image_error = image.load_jpg_from_buffer(body)
	if image_error != OK:
		image_error = image.load_png_from_buffer(body)
		if image_error != OK:
			print(image_error)
	var texture = ImageTexture.new()
	texture.create_from_image(image, 4)
	# Assign to the child TextureRect node to display image
	$TexImage.texture = texture
	


</code></pre>

