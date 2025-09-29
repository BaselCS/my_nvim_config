-- keymaps for vim
vim.g.mapleader = " "

-- stop Space from working in n and v
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Paste in visual mode without yanking replaced text
vim.keymap.set("x", "p", [["_dP]])

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without yanking
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- move the line
vim.keymap.set("v","J",":m '>+1<CR>gv=gv")
vim.keymap.set("v","K",":m '<-2<CR>gv=gv")

--move half but with zz
vim.keymap.set("n","<C-d>","<C-d>zz")
vim.keymap.set("n","<C-u>","<C-u>zz")

-- end of file with zz
vim.keymap.set("n","G","Gzz")

--search with center foucs
vim.keymap.set("n","n","nzzzv")
vim.keymap.set("n","N","nzzzv")

--fast saving
vim.keymap.set("n", "<leader>w", ":w<CR>")

--close file
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- add new line by enter in normll mode
vim.keymap.set("n","<Enter>","o<Esc>")

-- Helper function to check if we're in a uv project
local function is_uv_project()
    local current_dir = vim.fn.getcwd()
    local pyproject_path = current_dir .. "/pyproject.toml"
    local uv_lock_path = current_dir .. "/.uv.lock"

    -- Check if pyproject.toml or .uv.lock exists
    return vim.fn.filereadable(pyproject_path) == 1 or vim.fn.filereadable(uv_lock_path) == 1
end

-- Python runner with uv support and file validation
local function run_python()
    local current_file = vim.fn.expand('%')
    local file_type = vim.bo.filetype

    -- Check if we have a valid file and it's a Python file
    if current_file == '' then
        vim.notify("No file is currently open", vim.log.levels.WARN)
        return
    end

    if file_type ~= 'python' then
        vim.notify("Current file is not a Python file", vim.log.levels.WARN)
        return
    end

    -- Check if file exists on disk
    if vim.fn.filereadable(current_file) == 0 then
        vim.notify("File doesn't exist on disk. Save it first.", vim.log.levels.WARN)
        return
    end

    -- Save file first
    vim.cmd('w')

    -- Determine the command to use
    local command
    if is_uv_project() then
        command = 'uv run ' .. vim.fn.shellescape(current_file)
        vim.notify("Running with uv: " .. current_file, vim.log.levels.INFO)
    else
        command = 'python3 ' .. vim.fn.shellescape(current_file)
        vim.notify("Running with system Python: " .. current_file, vim.log.levels.INFO)
    end

    -- Open terminal and run
    vim.cmd('vnew')
    vim.cmd('terminal ' .. command)
end

-- Alternative function to always use uv run (even outside uv projects)
local function run_python_uv_always()
    local current_file = vim.fn.expand('%')
    local file_type = vim.bo.filetype

    -- Check if we have a valid file and it's a Python file
    if current_file == '' then
        vim.notify("No file is currently open", vim.log.levels.WARN)
        return
    end

    if file_type ~= 'python' then
        vim.notify("Current file is not a Python file", vim.log.levels.WARN)
        return
    end

    -- Check if file exists on disk
    if vim.fn.filereadable(current_file) == 0 then
        vim.notify("File doesn't exist on disk. Save it first.", vim.log.levels.WARN)
        return
    end

    -- Save and run with uv
    vim.cmd('w')
    vim.cmd('vnew')
    vim.cmd('terminal uv run ' .. vim.fn.shellescape(current_file))
    vim.notify("Running with uv: " .. current_file, vim.log.levels.INFO)
end

-- For normal mode - auto-detect uv project
vim.keymap.set('n', '<F5>', run_python, { noremap = true, silent = true, desc = "Run Python file (auto-detect uv)" })

-- For normal mode - always use uv
vim.keymap.set('n', '<leader><F5>', run_python_uv_always, { noremap = true, silent = true, desc = "Run Python file with uv (always)" })

-- For insert mode - auto-detect
vim.keymap.set('i', '<F5>', function()
    vim.cmd('stopinsert')
    run_python()
end, { noremap = true, silent = true, desc = "Run Python file (auto-detect uv)" })

-- For insert mode - always uv
vim.keymap.set('i', '<leader><F5>', function()
    vim.cmd('stopinsert')
    run_python_uv_always()
end, { noremap = true, silent = true, desc = "Run Python file with uv (always)" })

-- For visual mode - auto-detect
vim.keymap.set('v', '<F5>', function()
    vim.cmd('normal! <Esc>')
    run_python()
end, { noremap = true, silent = true, desc = "Run Python file (auto-detect uv)" })

-- For visual mode - always uv
vim.keymap.set('v', '<leader><F5>', function()
    vim.cmd('normal! <Esc>')
    run_python_uv_always()
end, { noremap = true, silent = true, desc = "Run Python file with uv (always)" })

-- Additional uv-specific keymaps
vim.keymap.set('n', '<leader>ui', ':terminal uv init<CR>', { noremap = true, silent = true, desc = "Initialize uv project" })
vim.keymap.set('n', '<leader>ua', ':terminal uv add ', { noremap = true, desc = "Add package with uv" })
vim.keymap.set('n', '<leader>ur', ':terminal uv remove ', { noremap = true, desc = "Remove package with uv" })
vim.keymap.set('n', '<leader>us', ':terminal uv sync<CR>', { noremap = true, silent = true, desc = "Sync uv project" })
vim.keymap.set('n', '<leader>ul', ':terminal uv lock<CR>', { noremap = true, silent = true, desc = "Update uv lock file" })
vim.keymap.set('n', '<leader>uc', ':terminal uv run python<CR>', { noremap = true, silent = true, desc = "Open uv Python REPL" })














-- إضافة للـ keymaps.lua - نسخة مُصححة من جميع الأخطاء

-- تطبيق التخطيطات العربية الكاملة (محدث مع Shift)
vim.keymap.set("n", "<leader>ar", function()
    vim.notify("🔄 تطبيق التخطيط العربي الكامل مع Shift...", vim.log.levels.INFO)
    
    -- التخطيطات الأساسية (بدون Shift)
    local arabic_mappings_basic = {
        -- الصف الأول
        ["ض"] = "q", ["ص"] = "w", ["ث"] = "e", ["ق"] = "r", ["ف"] = "t",
        ["غ"] = "y", ["ع"] = "u", ["ه"] = "i", ["خ"] = "o", ["ح"] = "p",
        ["ج"] = "[", ["د"] = "]",
        
        -- الصف الثاني  
        ["ش"] = "a", ["س"] = "s", ["ي"] = "d", ["ب"] = "f", ["ل"] = "g",
        ["ا"] = "h", ["ت"] = "j", ["ن"] = "k", ["م"] = "l", ["ك"] = ";",
        ["ط"] = "'",
        
        -- الصف الثالث
        ["ئ"] = "z", ["ء"] = "x", ["ؤ"] = "c", ["ر"] = "v", ["لا"] = "b",
        ["ى"] = "n", ["ة"] = "m", ["و"] = ",", ["ز"] = ".", ["ظ"] = "/",
        
        -- أرقام عربية
        ["١"] = "1", ["٢"] = "2", ["٣"] = "3", ["٤"] = "4", ["٥"] = "5",
        ["٦"] = "6", ["٧"] = "7", ["٨"] = "8", ["٩"] = "9", ["٠"] = "0",
    }
    
    -- التخطيطات مع Shift
    local arabic_mappings_shift = {
        -- الصف الأول مع Shift
        ["َ"] = "Q",   -- Fatha
        ["ً"] = "W",   -- Tanween Fath
        ["ُ"] = "E",   -- Damma
        ["ٌ"] = "R",   -- Tanween Damm
        ["لإ"] = "T",  -- Lam-Alef with Hamza below
        ["إ"] = "Y",   -- Alef with Hamza below
        ["'"] = "U",   -- Right single quotation
        ["÷"] = "I",   -- Division sign
        ["×"] = "O",   -- Multiplication sign
        ["؛"] = "P",   -- Arabic semicolon
        
        -- الصف الثاني مع Shift
        ["ِ"] = "A",   -- Kasra
        ["ٍ"] = "S",   -- Tanween Kasr
        ["أ"] = "H",   -- Alef with Hamza above
        ["ـ"] = "J",   -- Tatweel (kashida)
        ["،"] = "K",   -- Arabic comma
        
        -- الصف الثالث مع Shift  
        ["ْ"] = "X",   -- Sukun
        ["آ"] = "N",   -- Alef with Madda
        ["؟"] = "?",   -- Arabic question mark
        
        -- رموز إضافية
        ["!"] = "!", ["@"] = "@", ["#"] = "#", ["$"] = "$", ["%"] = "%",
        ["^"] = "^", ["&"] = "&", ["*"] = "*", ["("] = "(", [")"] = ")",
        ["_"] = "_", ["+"] = "+", ["~"] = "~",
    }
    
    -- دمج جميع التخطيطات
    local all_mappings = {}
    
    -- إضافة التخطيطات الأساسية
    for arabic, english in pairs(arabic_mappings_basic) do
        all_mappings[arabic] = english
    end
    
    -- إضافة تخطيطات Shift
    for arabic, english in pairs(arabic_mappings_shift) do
        all_mappings[arabic] = english
    end
    
    -- أولاً، جرب langmapper إذا كان متوفراً
    local ok, langmapper = pcall(require, "langmapper")
    if ok then
        pcall(function()
            if langmapper.automapping then
                langmapper.automapping()
                vim.notify("✅ تم تطبيق langmapper.automapping()", vim.log.levels.INFO)
            end
        end)
    end
    
    -- تطبيق جميع التخطيطات يدوياً
    local count = 0
    for arabic, english in pairs(all_mappings) do
        -- تطبيق في Normal mode
        vim.keymap.set("n", arabic, english, { 
            noremap = true, 
            silent = true,
            desc = "Arabic: " .. arabic .. " → " .. english
        })
        -- تطبيق في Visual mode  
        vim.keymap.set("v", arabic, english, { 
            noremap = true, 
            silent = true,
            desc = "Arabic: " .. arabic .. " → " .. english
        })
        -- تطبيق في Operator-pending mode
        vim.keymap.set("o", arabic, english, { 
            noremap = true, 
            silent = true,
            desc = "Arabic: " .. arabic .. " → " .. english
        })
        count = count + 1
    end
    
    vim.notify("✅ تم تطبيق " .. count .. " تخطيط عربي كامل (مع Shift)!", vim.log.levels.INFO)
    vim.notify("💡 جرب: ض→q، ش→a، َ→Q، ِ→A", vim.log.levels.INFO)
    
end, { desc = "Apply complete Arabic keyboard mappings with Shift" })

-- اختبار شامل للتخطيطات (مُصحح)
vim.keymap.set("n", "<leader>test", function()
    vim.notify("🧪 اختبار التخطيط العربي الكامل:", vim.log.levels.INFO)
    
    -- اختبار الأحرف الأساسية
    local basic_test = {
        ["ض"] = "q", ["ص"] = "w", ["ث"] = "e", ["ق"] = "r", ["ف"] = "t",
        ["ش"] = "a", ["س"] = "s", ["ي"] = "d", ["ب"] = "f", ["ل"] = "g"
    }
    
    -- اختبار أحرف Shift
    local shift_test = {
        ["َ"] = "Q", ["ً"] = "W", ["ُ"] = "E", ["ِ"] = "A", ["ٍ"] = "S"
    }
    
    vim.notify("🔍 اختبار الأحرف الأساسية:", vim.log.levels.INFO)
    local mappings = vim.api.nvim_get_keymap("n")
    local basic_found = 0
    
    for arabic, expected in pairs(basic_test) do
        local found = false
        for _, mapping in ipairs(mappings) do
            if mapping.lhs == arabic then
                found = true
                basic_found = basic_found + 1
                break
            end
        end
        
        if found then
            vim.notify("✅ " .. arabic .. " → " .. expected, vim.log.levels.INFO)
        else
            vim.notify("❌ " .. arabic .. " → غير موجود", vim.log.levels.WARN)
        end
    end
    
    vim.notify("🔍 اختبار أحرف Shift:", vim.log.levels.INFO)
    local shift_found = 0
    
    for arabic, expected in pairs(shift_test) do
        local found = false
        for _, mapping in ipairs(mappings) do
            if mapping.lhs == arabic then
                found = true
                shift_found = shift_found + 1
                break
            end
        end
        
        if found then
            vim.notify("✅ " .. arabic .. " → " .. expected, vim.log.levels.INFO)
        else
            vim.notify("❌ " .. arabic .. " → غير موجود", vim.log.levels.WARN)
        end
    end
    
    -- النتيجة النهائية (مُصحح)
    local total_found = basic_found + shift_found
    
    -- عد العناصر يدوياً بدلاً من استخدام vim.tbl_keys
    local basic_count = 0
    for _ in pairs(basic_test) do basic_count = basic_count + 1 end
    
    local shift_count = 0  
    for _ in pairs(shift_test) do shift_count = shift_count + 1 end
    
    local total_tested = basic_count + shift_count
    
    if total_found == total_tested then
        vim.notify("🎉 جميع التخطيطات تعمل! (" .. total_found .. "/" .. total_tested .. ")", vim.log.levels.INFO)
    elseif total_found > 0 then
        vim.notify("⚠️  بعض التخطيطات تعمل (" .. total_found .. "/" .. total_tested .. ")", vim.log.levels.WARN)
        vim.notify("💡 استخدم <leader>ar لإعادة التطبيق", vim.log.levels.INFO)
    else
        vim.notify("❌ لا توجد تخطيطات - استخدم <leader>ar", vim.log.levels.ERROR)
    end
    
end, { desc = "Test complete Arabic mappings" })

-- إزالة التخطيطات العربية
vim.keymap.set("n", "<leader>ard", function()
    vim.notify("🗑️  إزالة التخطيطات العربية...", vim.log.levels.INFO)
    
    local arabic_chars = {
        "ض", "ص", "ث", "ق", "ف", "غ", "ع", "ه", "خ", "ح", 
        "ج", "د", "ش", "س", "ي", "ب", "ل", "ا", "ت", "ن", 
        "م", "ك", "ط", "ذ", "ز", "ر", "و", "ة", "ى", "لا",
        "ؤ", "ء", "ئ", "ظ", "َ", "ً", "ُ", "ٌ", "ِ", "ٍ", "ْ",
        "أ", "إ", "آ", "؛", "،", "؟", "÷", "×", "ـ"
    }
    
    local removed_count = 0
    for _, arabic_char in ipairs(arabic_chars) do
        -- حذف من Normal mode
        pcall(vim.keymap.del, "n", arabic_char)
        -- حذف من Visual mode
        pcall(vim.keymap.del, "v", arabic_char)
        -- حذف من Operator-pending mode
        pcall(vim.keymap.del, "o", arabic_char)
        removed_count = removed_count + 1
    end
    
    vim.notify("✅ تم حذف " .. removed_count .. " تخطيط عربي", vim.log.levels.INFO)
    
end, { desc = "Remove Arabic keyboard mappings" })

-- عرض حالة التخطيطات
vim.keymap.set("n", "<leader>ars", function()
    vim.notify("📊 حالة التخطيطات العربية:", vim.log.levels.INFO)
    
    local test_chars = {"ض", "ص", "ث", "ق", "ف"}
    local mappings = vim.api.nvim_get_keymap("n")
    local found_count = 0
    
    for _, test_char in ipairs(test_chars) do
        local found = false
        for _, mapping in ipairs(mappings) do
            if mapping.lhs == test_char then
                found = true
                found_count = found_count + 1
                vim.notify("✅ " .. test_char .. " → " .. (mapping.rhs or "mapped"), vim.log.levels.INFO)
                break
            end
        end
        
        if not found then
            vim.notify("❌ " .. test_char .. " → غير مفعل", vim.log.levels.WARN)
        end
    end
    
    if found_count == 0 then
        vim.notify("💡 استخدم <leader>ar لتفعيل التخطيطات", vim.log.levels.INFO)
    else
        vim.notify("🎉 " .. found_count .. " من 5 تخطيطات مفعلة", vim.log.levels.INFO)
    end
    
end, { desc = "Show Arabic mappings status" })

-- عرض دليل التخطيطات
vim.keymap.set("n", "<leader>guide", function()
    vim.notify("📖 دليل التخطيط العربي:", vim.log.levels.INFO)
    
    local guide_lines = {
        "🔤 الأحرف الأساسية:",
        "  ض→q ص→w ث→e ق→r ف→t غ→y ع→u ه→i خ→o ح→p",
        "  ش→a س→s ي→d ب→f ل→g ا→h ت→j ن→k م→l ك→;",
        "  ئ→z ء→x ؤ→c ر→v لا→b ى→n ة→m و→, ز→. ظ→/",
        "",
        "⬆️  مع Shift:",
        "  َ→Q ً→W ُ→E ٌ→R إ→Y أ→H ـ→J ،→K ؟→?",
        "  ِ→A ٍ→S ْ→X آ→N",
        "",
        "💡 الاستخدام:",
        "  - Normal mode: استخدم الأحرف العربية كاختصارات vim",
        "  - Insert mode: اكتب بالعربية عادياً", 
        "  - <leader>ar: تفعيل التخطيطات",
        "  - <leader>ard: حذف التخطيطات"
    }
    
    for _, line in ipairs(guide_lines) do
        vim.notify(line, vim.log.levels.INFO)
    end
    
end, { desc = "Show Arabic mapping guide" })

-- اختصارات سريعة لاختبار تخطيطات معينة
vim.keymap.set("n", "<leader>q", function()
    vim.notify("🧪 اختبار سريع: اضغط الأحرف التالية في Normal mode:", vim.log.levels.INFO)
    vim.notify("ض (يجب أن تعمل مثل q) - ص (يجب أن تعمل مثل w) - ش (يجب أن تعمل مثل a)", vim.log.levels.INFO)
    vim.notify("جرب أيضاً: َ (فتحة = Q) - ِ (كسرة = A)", vim.log.levels.INFO)
end, { desc = "Quick mapping test instructions" })
