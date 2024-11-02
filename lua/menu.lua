local Menu = require("nui.menu")

local create_menu = function(popup, current_day)
	local menuLines
	if current_day == 6 then
		menuLines = { Menu.item("lets go!") }
	else
		menuLines = { Menu.item("then when?") }
	end

	return Menu({
		size = {
			width = 25,
			height = 5,
		},
		border = {
			style = "single",
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = menuLines,
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			popup:unmount()
		end,
		on_submit = function(item)
			popup:unmount()
			if item.text == "then when?" then
				local days_until_friday = 6 - current_day
				if current_day > 6 then
					days_until_friday = days_until_friday + 7
				end
				print("There are " .. days_until_friday .. " days left until Friday.")
			elseif item.text == "lets go!" then
				print("It's Friday! Let's go!")
			end
		end,
	})
end

return create_menu
