local commons = require("commons")
local hs = require("hs")
local jira_base = os.getenv("JIRA_BASE")

local function jiraToLink()
	-- Convert current jira id selection to Jira link
	local jira_id = commons.currentSelection()
	hs.pasteboard.setContents(jira_base .. "/browse/" .. jira_id)
	hs.timer.usleep(20000)
	hs.eventtap.keyStroke({ "cmd" }, "v")
end

hs.hotkey.bind({ "cmd", "alt" }, "j", jiraToLink)
