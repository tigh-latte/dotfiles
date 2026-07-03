hs.audiodevice.watcher.setCallback(function(event)
	if event ~= "dOut" then return end
	local output = hs.audiodevice.defaultOutputDevice()
	if output:name() == "MacBook Pro Speakers" then
		hs.task.new("/opt/homebrew/bin/nowplaying-cli", nil, { "pause" }):start()
		if not output:muted() then output:setMuted(true) end
	end
end)

hs.audiodevice.watcher.start()
