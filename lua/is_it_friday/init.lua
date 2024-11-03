local M = {}

local create_popup = require("is_it_friday.popup")
local create_menu = require("is_it_friday.menu")
local create_layout = require("is_it_friday.layout")
local set_content = require("is_it_friday.set_content")

M.is_it_friday = function()
	local current_day = os.date("*t").wday

	local popup = create_popup()
	local menu = create_menu(popup, current_day)
	local layout = create_layout(popup, menu)

	layout:mount()
	set_content(popup, current_day)
end

return M
