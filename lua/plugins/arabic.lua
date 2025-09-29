-- Arabic language support configuration
local M = {}

-- Arabic keyboard layout mapping
M.arabic_layout = {
    -- First row
    ["ض"] = "q", ["ص"] = "w", ["ث"] = "e", ["ق"] = "r", ["ف"] = "t",
    ["غ"] = "y", ["ع"] = "u", ["ه"] = "i", ["خ"] = "o", ["ح"] = "p",
    ["ج"] = "[", ["چ"] = "]",

    -- Second row
    ["ش"] = "a", ["س"] = "s", ["ي"] = "d", ["ب"] = "f", ["ل"] = "g",
    ["ا"] = "h", ["ت"] = "j", ["ن"] = "k", ["م"] = "l", ["ك"] = ";",
    ["ط"] = "'",

    -- Third row
    ["ذ"] = "z", ["د"] = "x", ["ز"] = "c", ["ر"] = "v", ["و"] = "b",
    -- Add more mappings as needed
}

-- Function to setup Arabic keymaps
M.setup_arabic_keymaps = function()
    -- Example: Map Arabic keys to English equivalents for normal mode
    for arabic, english in pairs(M.arabic_layout) do
        vim.keymap.set("n", arabic, english, { noremap = true, silent = true })
    end
end

return M
