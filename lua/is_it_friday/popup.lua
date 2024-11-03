local Popup = require("nui.popup")

local create_popup = function()
	return Popup({
		enter = true,
		focusable = true,
		border = {
			style = "rounded",
		},
	})
end

return create_popup
