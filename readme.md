تخصيص Vim لكي يعمل مع بايثون و  uv بأفضل شكل ممكن

قائمة الاختصارات المخصصة (الترجمة آلية ) : 
# ملخص شامل لاختصارات Neovim

**مفتاح القائد:** `<Space>` (مسطرة المسافة)

## العمليات الأساسية في Vim

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<Space>` | عادي/مرئي | `<Nop>` | مفتاح القائد (معطل السلوك الافتراضي) |
| `p` | مرئي | `"_dP` | لصق بدون نسخ النص المستبدل |
| `<leader>y` | عادي/مرئي | `"+y` | نسخ إلى الحافظة |
| `<leader>Y` | عادي | `"+Y` | نسخ السطر إلى الحافظة |
| `<leader>d` | عادي/مرئي | `"_d` | حذف بدون نسخ |
| `<leader>w` | عادي | `:w<CR>` | حفظ سريع |
| `<leader>q` | عادي | `:q<CR>` | إغلاق الملف |
| `<Enter>` | عادي | `o<Esc>` | إضافة سطر جديد والعودة للوضع العادي |

## الحركة والتنقل

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `J` | مرئي | `:m '>+1<CR>gv=gv` | تحريك الأسطر المحددة للأسفل |
| `K` | مرئي | `:m '<-2<CR>gv=gv` | تحريك الأسطر المحددة للأعلى |
| `<C-d>` | عادي | `<C-d>zz` | نصف صفحة للأسفل مع التوسيط |
| `<C-u>` | عادي | `<C-u>zz` | نصف صفحة للأعلى مع التوسيط |
| `G` | عادي | `Gzz` | الذهاب لنهاية الملف مع التوسيط |
| `n` | عادي | `nzzzv` | البحث التالي مع التركيز في المنتصف |
| `N` | عادي | `Nzzzv` | البحث السابق مع التركيز في المنتصف |

## تشغيل Python

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<F5>` | عادي/إدراج/مرئي | `run_python()` | تشغيل ملف Python (كشف تلقائي لـ uv) |
| `<leader><F5>` | عادي/إدراج/مرئي | `run_python_uv_always()` | تشغيل ملف Python مع uv (دائماً) |

## مدير الحزم UV

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>ui` | عادي | `:terminal uv init<CR>` | إنشاء مشروع uv جديد |
| `<leader>ua` | عادي | `:terminal uv add` | إضافة حزمة مع uv |
| `<leader>ur` | عادي | `:terminal uv remove` | إزالة حزمة مع uv |
| `<leader>us` | عادي | `:terminal uv sync<CR>` | مزامنة مشروع uv |
| `<leader>ul` | عادي | `:terminal uv lock<CR>` | تحديث ملف القفل uv |
| `<leader>uc` | عادي | `:terminal uv run python<CR>` | فتح Python REPL مع uv |

## إدارة الملفات والبحث (Telescope)

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>ff` | عادي | `:Telescope find_files<cr>` | البحث عن الملفات |
| `<leader>fp` | عادي | `:Telescope git_files<cr>` | البحث في ملفات git |
| `<leader>e` | عادي | `:NvimTreeFindFileToggle<cr>` | تبديل شجرة الملفات |

## تحرير الكود والتعليقات

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>/` | عادي/مرئي | `:CommentToggle<cr>` | تبديل التعليق |
| `<leader>u` | عادي | `:UndotreeToggle<cr>` | تبديل شجرة التراجع |

## LSP (بروتوكول خادم اللغة)

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `gd` | عادي | `vim.lsp.buf.definition` | الذهاب للتعريف |
| `K` | عادي | `vim.lsp.buf.hover` | إظهار التوثيق المنبثق |
| `<leader>rn` | عادي | `vim.lsp.buf.rename` | إعادة تسمية الرمز |
| `<leader>ca` | عادي | `vim.lsp.buf.code_action` | إجراءات الكود |

## تصحيح الأخطاء والتشخيص

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>l` | عادي | `require("lsp_lines").toggle` | تبديل خطوط LSP |
| `<leader>xx` | عادي | `Trouble diagnostics toggle` | تبديل التشخيص (Trouble) |
| `<leader>xt` | عادي | `Trouble diagnostics toggle filter.buf=0` | تشخيص المخزن المؤقت (Trouble) |
| `<leader>cs` | عادي | `Trouble symbols toggle focus=false` | الرموز (Trouble) |
| `<leader>cl` | عادي | `Trouble lsp toggle focus=false win.position=right` | تعريفات/مراجع LSP (Trouble) |
| `<leader>xL` | عادي | `Trouble loclist toggle` | قائمة المواقع (Trouble) |
| `<leader>xQ` | عادي | `Trouble qflist toggle` | قائمة الإصلاح السريع (Trouble) |

## DAP (بروتوكول محول التصحيح)

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>d` | عادي | `DapToggleBreakpoint` | تبديل نقطة التوقف |
| `<leader><F1>` | عادي | `DapContinue` | متابعة التصحيح |
| `<leader><F2>` | عادي | `DapStepInto` | الدخول خطوة |
| `<leader><F3>` | عادي | `DapStepOver` | تخطي خطوة |
| `<leader><F4>` | عادي | `DapStepOut` | الخروج من خطوة |
| `<leader><F6>` | عادي | `DapRestart` | إعادة تشغيل التصحيح |
| `<leader><F7>` | عادي | `DapShowLog` | إظهار سجل التصحيح |
| `<leader><F8>` | عادي | `DapTerminate` | إنهاء التصحيح |
| `<leader><F9>` | عادي | `require('dapui').toggle()` | تبديل واجهة التصحيح |
| `<leader><F10>` | عادي | `require('dapui').eval()` | تقييم التعبير |
| `<leader><F11>` | عادي | `require('dap-python').test_method()` | اختبار دالة Python |
| `<leader><F12>` | عادي | `require('dap-python').test_class()` | اختبار فئة Python |

## الأوامر المخصصة

| الأمر | الوصف |
|------|-------|
| `:PyRightRefresh` | تحديث Pyright LSP مع كشف uv |

