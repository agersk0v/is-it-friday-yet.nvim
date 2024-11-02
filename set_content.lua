local set_content = function(popup, current_day)
	local width = popup._.size.width
	local height = popup._.size.height

	local no_ascii = [[
               __                   __
  ____   _____/  |_   ___.__. _____/  |_
 /    \ /  _ \   __\ <   |  |/ __ \   __\
|   |  (  <_> )  |    \___  \  ___/|  |
|___|  /\____/|__|    / ____|\___  >__|
     \/               \/         \/
    ]]

	local yes_ascii = [[
                            .__       ._.
 ___.__. ____   ______ _____|__|______| |
<   |  |/ __ \ /  ___//  ___/  \_  __ \ |
 \___  \  ___/ \___ \ \___ \|  ||  | \/\|
 / ____|\___  >____  >____  >__||__|   __
 \/         \/     \/     \/           \/
    ]]

	local text = current_day == 6 and yes_ascii or no_ascii

	local text_lines = {}
	for line in text:gmatch("[^\r\n]+") do
		table.insert(text_lines, line)
	end

	local max_line_length = 0
	for _, line in ipairs(text_lines) do
		if #line > max_line_length then
			max_line_length = #line
		end
	end

	local padding_width = math.floor((width - max_line_length) / 2)

	local padded_text_lines = {}
	for _, line in ipairs(text_lines) do
		table.insert(padded_text_lines, string.rep(" ", padding_width) .. line)
	end

	local padding_height = math.floor((height - #padded_text_lines) / 2)

	local lines = {}
	for _ = 1, padding_height do
		table.insert(lines, "")
	end
	for _, line in ipairs(padded_text_lines) do
		table.insert(lines, line)
	end

	if popup.bufnr and vim.api.nvim_buf_is_valid(popup.bufnr) then
		vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
	else
		print("Error: popup buffer is not valid.")
	end
end

return set_content
