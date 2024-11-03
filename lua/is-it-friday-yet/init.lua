local M = {}

local create_popup = require("popup")
local create_menu = require("menu")
local create_layout = require("layout")
local set_content = require("set_content")

M.is_it_friday_yet = function()
	local current_day = os.date("*t").wday

	local popup = create_popup()
	local menu = create_menu(popup, current_day)
	local layout = create_layout(popup, menu)

	layout:mount()
	set_content(popup, current_day)
end

return M
