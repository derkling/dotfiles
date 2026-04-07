-- Enable folding via markers {{{
-- Neovim supports code folding. We configure it to use markers `{{{` and `}}}`
-- just like your old .vimrc file.
vim.opt.foldmethod = "marker"
-- }}}

-- UI Customization Toggle {{{
-- Set this to true if you install a Nerd Font (e.g. JetBrainsMono Nerd Font)
-- Set to false if you see boxes/broken icons in the statusline or menus.
vim.g.have_nerd_font = false
-- }}}

-- Set Leader Key {{{
-- The <Leader> key is the prefix for many custom commands. Space is the modern standard.
-- This MUST happen before plugins are loaded so that plugins register the correct key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Prevent Space from moving the cursor one character to the right (its default behavior)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- }}}

-- Bootstrap lazy.nvim Package Manager {{{
-- This section automatically downloads and installs lazy.nvim (the engine behind LazyVim)
-- if it is not already installed on your system.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

-- Plugins Configuration {{{
-- Here we tell lazy.nvim which plugins to install.
-- It reads this table and automatically installs, lazy-loads, and configures them.
require("lazy").setup({

  -- 1. Themes (Gruvbox, Tokyonight, Catppuccin)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      -- vim.cmd("colorscheme gruvbox")
      vim.cmd("colorscheme carbonfox")
    end,
  },
  { "folke/tokyonight.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },

  -- 2. Statusline: Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto", -- 'auto' makes lualine match whatever colorscheme you pick!
          icons_enabled = vim.g.have_nerd_font,
          component_separators = vim.g.have_nerd_font and { left = '', right = ''} or { left = '|', right = '|'},
          section_separators = vim.g.have_nerd_font and { left = '', right = ''} or { left = '', right = ''},
        }
      })
    end,
  },

  -- 3. Telescope (Fuzzy Finder for previewing themes, files, etc.)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    -- We define ALL telescope-related keys here so lazy.nvim knows when to load it.
    keys = {
      { "<leader><space>", "<cmd>Telescope commands<CR>", desc = "Commands" },
      {
        "<leader>/",
        function()
          -- Search from git root if in a repo, otherwise current directory.
          -- We explicitly ignore the global gitignore which caused issues in massive repos.
          local root = vim.fs.find({ ".git" }, { upward = true })[1]
          require("telescope.builtin").live_grep({
            cwd = root and vim.fs.dirname(root) or vim.fn.getcwd()
          })
        end,
        desc = "Search string in project"
      },
      { "<leader>?", "<cmd>Telescope keymaps<CR>", desc = "Search keybindings" },
      { "<leader>bb", "<cmd>Telescope buffers<CR>", desc = "Show all buffers" },
      {
        "<leader>ff",
        function()
          -- Use git_files if in a repo for better performance and root-awareness.
          local root = vim.fs.find({ ".git" }, { upward = true })[1]
          if root then
            require("telescope.builtin").git_files({ cwd = vim.fs.dirname(root) })
          else
            require("telescope.builtin").find_files()
          end
        end,
        desc = "Fuzzy search files"
      },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Open recent" },
      { "<leader>hk", "<cmd>Telescope keymaps<CR>", desc = "Open global key bindings" },
      { "<leader>ji", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Jump to symbol in buffer" },
      { "<leader>jI", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Jump to symbol in project" },
      { "<leader>pf", "<cmd>Telescope find_files<CR>", desc = "Find file in project" },
      { "<leader>rb", "<cmd>Telescope oldfiles<CR>", desc = "Recent buffers" },
      { "<leader>rs", "<cmd>Telescope live_grep<CR>", desc = "Search in project" },
      { "<leader>sj", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Jump to symbol in buffer" },
      {
        "<leader>sp",
        function()
          local root = vim.fs.find({ ".git" }, { upward = true })[1]
          require("telescope.builtin").live_grep({
            cwd = root and vim.fs.dirname(root) or vim.fn.getcwd()
          })
        end,
        desc = "Search string in project"
      },
      { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy search in current buffer" },
      { "<leader>sJ", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Jump to symbol in project" },
      { "<leader>tc", "<cmd>Telescope colorscheme enable_preview=true<CR>", desc = "Preview Themes" },
    },
    config = function()
      -- Use 'fd' or 'fdfind' (standard on Ubuntu) for file finding.
      local find_command
      if vim.fn.executable("fd") == 1 then
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--no-ignore-global", "--exclude", ".git" }
      elseif vim.fn.executable("fdfind") == 1 then
        find_command = { "fdfind", "--type", "f", "--strip-cwd-prefix", "--hidden", "--no-ignore-global", "--exclude", ".git" }
      end

      require("telescope").setup({
        defaults = {
          find_command = find_command,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--no-ignore-global", -- Essential to avoid issues with aggressive global gitignores
            "--glob",
            "!**/.git/*",
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })
      -- Load the fzf extension (C-implementation for speed)
      require('telescope').load_extension('fzf')
    end,
  },

  -- 4. Which-Key (The famous Spacemacs popup menu)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      icons = {
        -- If you have a Nerd Font, set this to true
        enabled = vim.g.have_nerd_font,
      },
      spec = {
        -- Mappings follow the VSpaceCode / Spacemacs structure
        { "<leader><tab>", "<cmd>b#<CR>", desc = "Last buffer" },
        { "<leader>!", "<cmd>terminal<CR>", desc = "Show terminal" },
        { "<leader>0", "<cmd>Lexplore<CR>", desc = "Focus files explorer" },
        { "<leader>;", "gcc", desc = "Toggle comment", remap = true },

        { "<leader>b", group = "+Buffers" },
        { "<leader>bb", "<cmd>Telescope buffers<CR>", desc = "Show all buffers" },
        { "<leader>bd", "<cmd>bdelete<CR>", desc = "Close active buffer" },
        { "<leader>bn", "<cmd>bnext<CR>", desc = "Next buffer" },
        { "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous buffer" },
        { "<leader>bs", "<cmd>enew<CR>", desc = "Scratch buffer" },

        { "<leader>c", group = "+Compile/Comments" },
        { "<leader>cc", "<cmd>make<CR>", desc = "Compile project" },
        { "<leader>cl", "gcc", desc = "Toggle line comment", remap = true },

        { "<leader>d", group = "+Debug" },

        { "<leader>e", group = "+Errors" },
        { "<leader>ee", function() vim.diagnostic.open_float() end, desc = "Show error" },
        { "<leader>en", function() vim.diagnostic.goto_next() end, desc = "Next error" },
        { "<leader>ep", function() vim.diagnostic.goto_prev() end, desc = "Previous error" },
        { "<leader>el", "<cmd>Telescope diagnostics<CR>", desc = "List errors" },

        { "<leader>f", group = "+File" },
        { "<leader>fn", "<cmd>enew<CR>", desc = "New file" },
        { "<leader>fs", "<cmd>w<CR>", desc = "Save file" },
        { "<leader>ft", "<cmd>Lexplore<CR>", desc = "Toggle tree/explorer view" },
        { "<leader>fS", "<cmd>wa<CR>", desc = "Save all files" },

        { "<leader>g", group = "+Git" },
        { "<leader>gs", "<cmd>Git<CR>", desc = "Status" },
        { "<leader>gb", "<cmd>Git blame<CR>", desc = "Blame file" },

        { "<leader>h", group = "+Help" },

        { "<leader>i", group = "+Insert" },
        { "<leader>ij", "o<Esc>", desc = "Insert line below" },
        { "<leader>ik", "O<Esc>", desc = "Insert line above" },

        { "<leader>j", group = "+Jump/Join/Split" },
        { "<leader>j+", "gg=G", desc = "Format buffer" },

        { "<leader>l", group = "+Layouts" },

        { "<leader>p", group = "+Project" },
        { "<leader>pc", "<cmd>make<CR>", desc = "Compile project" },
        { "<leader>pt", "<cmd>Lexplore<CR>", desc = "Show tree/explorer view" },

        { "<leader>q", group = "+Quit" },
        { "<leader>qq", "<cmd>qa<CR>", desc = "Close frame" },
        { "<leader>qQ", "<cmd>qa!<CR>", desc = "Quit application" },
        { "<leader>qs", "<cmd>wqa<CR>", desc = "Save all and close frame" },

        { "<leader>r", group = "+Resume/Repeat" },

        { "<leader>s", group = "+Search/Symbol" },
        { "<leader>sc", "<cmd>nohlsearch<CR>", desc = "Clear highlight" },

        { "<leader>t", group = "+Toggles" },
        { "<leader>tm", "<cmd>Glow<CR>", desc = "Glow Preview (Markdown)" },
        { "<leader>tl", "<cmd>set wrap!<CR>", desc = "Toggle word wrap" },
        { "<leader>ts", "<cmd>lua _G.ToggleSpell()<CR>", desc = "Toggle spell checking" },
        { "<leader>tw", "<cmd>set list!<CR>", desc = "Toggle render whitespace" },

        { "<leader>w", group = "+Window" },
        { "<leader>w-", "<cmd>split<CR>", desc = "Split window below" },
        { "<leader>w/", "<cmd>vsplit<CR>", desc = "Split window right" },
        { "<leader>w=", "<C-w>=", desc = "Reset window sizes" },
        { "<leader>wd", "<cmd>q<CR>", desc = "Close window" },
        { "<leader>wh", "<C-w>h", desc = "Focus window left" },
        { "<leader>wj", "<C-w>j", desc = "Focus window down" },
        { "<leader>wk", "<C-w>k", desc = "Focus window up" },
        { "<leader>wl", "<C-w>l", desc = "Focus window right" },
        { "<leader>ww", "<C-w>w", desc = "Focus next window" },
        { "<leader>wx", "<cmd>on<CR>", desc = "Close all other windows" },

        { "<leader>x", group = "+Text" },
        { "<leader>xc", "<cmd>CleanupBuffer<CR>", desc = "Cleanup (strip space & reflow)" },
        { "<leader>xf", "<cmd>ReflowBuffer<CR>", desc = "Reflow and word-wrap buffer" },
        { "<leader>xs", "<cmd>StripTrailingWhitespace<CR>", desc = "Strip trailing whitespace" },

        { "<leader>z", group = "+Zoom/Fold" },
        { "<leader>z.", group = "+Fold" },
        { "<leader>z.a", "za", desc = "Toggle: around a point" },
        { "<leader>z.c", "zc", desc = "Close: at a point" },
        { "<leader>z.m", "zM", desc = "Close: all" },
        { "<leader>z.o", "zo", desc = "Open: at a point" },
        { "<leader>z.r", "zR", desc = "Open: all" },
      }
    }
  },

})
-- }}}

-- General Neovim Settings {{{
-- These are the standard global configuration flags replacing your old `set nocompatible` etc.
vim.opt.shell = "/bin/bash"     -- Ensure shell is bash
vim.opt.number = true           -- Show absolute line numbers
vim.opt.relativenumber = true   -- Show relative line numbers (great for jumping)
vim.opt.mouse = "a"             -- Enable full mouse support in terminal
vim.opt.ignorecase = true       -- Ignore case when searching
vim.opt.smartcase = true        -- ... unless you type a capital letter
vim.opt.termguicolors = true    -- Enable 24-bit RGB colors (required for modern themes)
vim.opt.laststatus = 3          -- Show a single global statusline at the bottom
vim.opt.splitbelow = true       -- Natural split opening (horizontal)
vim.opt.splitright = true       -- Natural split opening (vertical)
vim.opt.undofile = true         -- Persistent undo history even after closing Neovim
vim.opt.showcmd = true          -- Show (partial) command in status line
vim.opt.showmatch = true        -- Show matching brackets
vim.opt.autowrite = true        -- Automatically save before commands like :next and :make
vim.opt.hidden = true           -- Hide buffers when they are abandoned
vim.opt.backup = false          -- Disable creation of backup (*.ext~) files
vim.opt.encoding = "utf-8"      -- Necessary to show Unicode glyphs
vim.opt.backspace = { "start", "indent", "eol" } -- Smart backspace
-- }}}

-- Custom Keymaps & Window Management {{{
-- Basic mappings
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Easier split navigation
vim.keymap.set("n", "<C-J>", "<C-W>j", { desc = "Navigate down" })
vim.keymap.set("n", "<C-K>", "<C-W>k", { desc = "Navigate up" })
vim.keymap.set("n", "<C-L>", "<C-W>l", { desc = "Navigate right" })
vim.keymap.set("n", "<C-H>", "<C-W>h", { desc = "Navigate left" })

-- Resize vsplit panes on VIM window resize events
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
  desc = "Resize panes evenly on window resize"
})
-- }}}

-- Clipboard CopyAndPaste {{{
-- PRIMARY: Copy-on-select, and can be pasted with the middle mouse button.
vim.keymap.set({"n", "v"}, "<Leader>y", '"*y', { desc = "Copy to primary clipboard" })
vim.keymap.set({"n", "v"}, "<Leader>p", '"*p', { desc = "Paste from primary clipboard" })
-- CLIPBOARD: Copy-on-^C, and pasted with ^V
vim.keymap.set({"n", "v"}, "<Leader>Y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({"n", "v"}, "<Leader>P", '"+p', { desc = "Paste from system clipboard" })
-- }}}

-- Moving selected lines {{{
-- Move current/selected line/s up/down and re-indents line(s) to suit its new position
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "Move line down" })
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "Move line up" })
-- }}}

-- Function Keys Mapping {{{
-- F2 - Paste mode is native in Neovim (bracketed paste). Toggle removed.
vim.opt.showmode = true

-- F3 - Toggle text wrapping
vim.keymap.set("n", "<F3>", "<cmd>set wrap!<CR>", { desc = "Toggle text wrapping" })

-- F4 - Toggle line numbering
vim.keymap.set("n", "<F4>", "<cmd>set nonumber!<CR>", { desc = "Toggle line numbering entirely" })

-- Dynamic Relative Numbering (similar to your BufEnter/BufLeave logic)
local number_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
vim.api.nvim_create_autocmd({"BufLeave", "InsertEnter"}, {
  group = number_group,
  pattern = "*",
  command = "if &number | set norelativenumber | endif",
})
vim.api.nvim_create_autocmd({"BufEnter", "InsertLeave"}, {
  group = number_group,
  pattern = "*",
  command = "if &number | set relativenumber | endif",
})

-- F6 - Highlight all instances of word under cursor, when idle
_G.auto_highlight = false
function _G.AutoHighlightToggle()
  _G.auto_highlight = not _G.auto_highlight
  if not _G.auto_highlight then
    vim.cmd("augroup auto_highlight | au! | augroup END")
    vim.opt.updatetime = 4000
    print("Highlight current word: off")
  else
    vim.cmd([[
      augroup auto_highlight
        au!
        au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
      augroup end
    ]])
    vim.opt.updatetime = 500
    print("Highlight current word: ON")
  end
end
vim.keymap.set("n", "<F6>", function()
  _G.AutoHighlightToggle()
  vim.opt.hlsearch = true
end, { desc = "Toggle auto-highlight word under cursor" })

-- F7 - Spell Checking with multi-language support
_G.myLang = 1
_G.myLangList = {"nospell", "en_us", "en_gb", "it"}
function _G.ToggleSpell()
  _G.myLang = _G.myLang + 1
  if _G.myLang > #_G.myLangList then _G.myLang = 1 end
  local lang = _G.myLangList[_G.myLang]
  if lang == "nospell" then
    vim.opt_local.spell = false
    print("Spell checking: OFF")
  else
    vim.opt_local.spell = true
    vim.opt_local.spelllang = lang
    print("Spell checking: ON (" .. lang .. ")")
  end
end
vim.keymap.set("n", "<F7>", "<cmd>lua _G.ToggleSpell()<CR>", { silent = true, desc = "Toggle spell checking language" })

-- Set global dictionary files safely
local spellfile_en = vim.fn.expand("~/dotfiles/vim/spell_en.utf-8.add")
if vim.fn.filereadable(spellfile_en) == 1 then
  vim.opt.spellfile:append(spellfile_en)
end
vim.opt.spellfile:append("oneoff.utf-8.add")
-- }}}

-- Jump to the last position when reopening a file {{{
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Jump to the last position when reopening a file"
})
-- }}}

-- Set GVim configuration (for Neovide and other GUIs) {{{
if vim.fn.has("gui_running") == 1 or vim.g.neovide then
  vim.opt.guifont = "Monospace:h8"
  vim.opt.lines = 75
  vim.opt.columns = 180
end
-- }}}

-- Filetype Specific Configurations {{{
-- Makefiles
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  command = "setlocal noexpandtab",
})

-- C/C++
vim.api.nvim_create_autocmd("BufRead", {
  pattern = {"*.c", "*.h", "*.cc", "*.hh", "*.cpp", "*.hpp", "*.S"},
  callback = function()
    local c_plugin_path = vim.fn.expand("~/dotfiles/vim/plugins/c.vim")
    if vim.fn.filereadable(c_plugin_path) == 1 then
      vim.cmd("source " .. c_plugin_path)
    end
    vim.cmd("normal zR")
  end,
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.dox",
  command = "set filetype=cpp.doxygen",
})

-- Python
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.py",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.textwidth = 79
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.fileformat = "unix"
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.py",
  command = "setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr",
})
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*.py",
  command = "setlocal foldexpr< foldmethod<",
})

-- Markdown: Glow Preview
vim.api.nvim_create_user_command("Glow", function()
  local file = vim.fn.expand("%")
  -- Open glow in a new terminal buffer in a split
  vim.cmd("vsplit | terminal glow -p " .. vim.fn.shellescape(file))
  -- Enter insert mode automatically to interact with glow (pager)
  vim.cmd("startinsert")
end, { desc = "Render current Markdown file with glow" })
-- }}}

-- Custom Commands {{{
vim.api.nvim_create_user_command("CleanupBuffer", function()
  vim.cmd("StripTrailingWhitespace")
  vim.cmd("ReflowBuffer")
end, { desc = "Strip trailing whitespace and reflow buffer" })

vim.api.nvim_create_user_command("ReflowBuffer", function()
  local save_cursor = vim.fn.getpos(".")
  vim.cmd([[normal! gggqG]])
  vim.fn.setpos(".", save_cursor)
end, { desc = "Reflow and word-wrap all text in buffer" })

vim.api.nvim_create_user_command("StripTrailingWhitespace", function()
  local save_cursor = vim.fn.getpos(".")
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
end, { desc = "Remove trailing whitespace from current buffer" })
-- }}}
