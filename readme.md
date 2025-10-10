تخصيص Vim لكي يعمل مع بايقون و  uv بأفشل شكل ممكن

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
| `<leader>F` | عادي | `:Telescope live_grep<cr>` | البحث النصي المباشر |
| `<leader>gd` | عادي | `:Telescope lsp_definitions<cr>` | البحث عن التعريفات باستخدام LSP |
| `<leader>e` | عادي | `:NvimTreeFindFileToggle<cr>` | تبديل شجرة الملفات |

## تحرير الكود والتعليقات

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>/` | عادي/مرئي | `:CommentToggle<cr>` | تبديل التعليق |
| `<leader>u` | عادي | `:UndotreeToggle<cr>` | تبديل شجرة التراجع |

## LSP (بروتوكول خادم اللغة)

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
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

## DAP (بروتوكول محول التصحيح) - التصحيح العام

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>d` | عادي | `DapToggleBreakpoint` | تبديل نقطة التوقف |
| `<F1>` | عادي | `DapContinue` | متابعة التصحيح |
| `<F2>` | عادي | `DapStepInto` | الدخول خطوة |
| `<F3>` | عادي | `DapStepOver` | تخطي خطوة |
| `<F4>` | عادي | `DapStepOut` | الخروج من خطوة |
| `<F6>` | عادي | `DapRestart` | إعادة تشغيل التصحيح |
| `<F7>` | عادي | `DapShowLog` | إظهار سجل التصحيح |
| `<F8>` | عادي | `DapTerminate` | إنهاء التصحيح |
| `<F9>` | عادي | `require('dapui').toggle()` | تبديل واجهة التصحيح |
| `<F10>` | عادي | `require('dapui').eval()` | تقييم التعبير |

## DAP - التصحيح الخاص بـ Python

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<F11>` | عادي | `require('dap-python').test_method()` | اختبار الدالة الحالية |
| `<F12>` | عادي | `require('dap-python').test_class()` | اختبار الفئة الحالية |

## GitHub Copilot - مساعد الذكاء الاصطناعي للبرمجة

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>ce` | عادي | `:Copilot enable<CR>` | تفعيل Copilot |
| `<leader>cd` | عادي | `:Copilot disable<CR>` | تعطيل Copilot |
| `<leader>cl` | عادي | `:Copilot log<CR>` | سجل Copilot |
| `<C-l>` | إدراج | `copilot#Accept("<CR>")` | قبول اقتراح Copilot |
| `<C-]>` | إدراج | `<Plug>(copilot-dismiss)` | رفض اقتراح Copilot |

## REPL/Jupyter (Iron.nvim)

| الاختصار | الوضع | الإجراء | الوصف |
|---------|------|--------|-------|
| `<leader>js` | عادي | `IronRepl` | بدء REPL |
| `<leader>jr` | عادي | `IronRestart` | إعادة تشغيل REPL |
| `<leader>jh` | عادي | `IronHide` | إخفاء نافذة REPL |
| `<leader>jc` | عادي | `iron.core.send_motion()` | إرسال الحركة إلى REPL |
| `<leader>jc` | مرئي | `iron.core.visual_send()` | إرسال التحديد إلى REPL |
| `<leader>jl` | عادي | `iron.core.send_line()` | إرسال السطر الحالي إلى REPL |
| `<leader>jf` | عادي | `iron.core.send_file()` | إرسال الملف الحالي إلى REPL |
| `<leader>jd` | عادي | `iron.core.send("%clear")` | مسح مخرجات REPL (Python) |
| `<leader>jb` | عادي | `search_and_run_cell()` | البحث وتشغيل الخلية الحالية |
| `<leader>jp` | عادي | `convert_py_to_ipynb()` | تحويل ملف Python الحالي إلى .ipynb |
| `<leader>C` | عادي | `insert_ipython_cell()` | إدراج علامة خلية IPython (`# %%`) |

### ملاحظة حول `<leader>jc`:
- في الوضع العادي: إرسال الحركة إلى REPL
- في الوضع المرئي: إرسال التحديد إلى REPL
- يوجد أيضاً دالة منفصلة لمسح IPython REPL

## الأوامر المخصصة

| الأمر | الوصف |
|------|-------|
| `:PyRightRefresh` | تحديث Pyright LSP مع كشف uv |

