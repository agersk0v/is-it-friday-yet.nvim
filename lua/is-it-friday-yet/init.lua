local M = {}

local Popup = require("nui.popup")
local Layout = require("nui.layout")
local Menu = require("nui.menu")

M.is_it_friday = function()
    local current_day = os.date("*t").wday

    local popup = Popup({
        enter = true,
        focusable = true,
        border = {
            style = "rounded",
        },
    })

    local menuLines
    if current_day == 6 then
        menuLines = { Menu.item("lets go!") }
    else
        menuLines = { Menu.item("then when?") }
    end

    local menu = Menu({
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
                local days_until_friday
                if current_day <= 6 then
                    days_until_friday = 6 - current_day
                else
                    days_until_friday = 6 + (7 - current_day)
                end
                print("There are " .. days_until_friday .. " days left until Friday.")
            elseif item.text == "lets go!" then
                print("It's Friday! Let's go!")
            end
        end,
    })

    local layout = Layout(
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

    local setContent = function()
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

        local text
        if current_day == 6 then
            text = yes_ascii
        else
            text = no_ascii
        end

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

        vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
    end

    layout:mount()
    setContent()
end

return M

