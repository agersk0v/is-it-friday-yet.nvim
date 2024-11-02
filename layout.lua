local Layout = require("nui.layout")

local create_layout = function(popup, menu)
	return Layout(
		{
			position = "50%",
			size = {
				width = "100%",
				height = "60%",
			},
		},
		Layout.Box({
			Layout.Box(popup, { size = "80%" }),
			Layout.Box(menu, { size = "20%" }),
		}, { dir = "row" })
	)
end

return create_layout
