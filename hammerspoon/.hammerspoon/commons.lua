local hs = require("hs")

M = {}

M.currentSelection = function()
	local element = hs.uielement.focusedElement()
	local selection = nil
	if element then
		selection = element:selectedText()
	end

	if (not selection) or (selection == "") then
		hs.eventtap.keyStroke({ "cmd" }, "c")
		hs.timer.usleep(20000)
		selection = hs.pasteboard.getContents()
	end

	return selection or ""
end

return M
