--------------------------------------------------------------------- [[ Keymappings ]]
-- See `:help vim.keymap.set()`

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- See `:help mapleader`

-- unmapping bad default mappings
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<space>', '<nop>')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- opens netrw file explorer
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

-- insert mode mappings
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('i', '<C-o>', '<C-o>dw')

-- shifts one or more lines up and down
vim.keymap.set('n', '<M-j>', ':m +1<CR>')
vim.keymap.set('n', '<M-k>', ':m -2<CR>')
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv")

-- pane navigation
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')

-- adds new line after/before current line
-- vim.keymap.set('n', '<M-o>', 'm`o<Esc>``')
-- vim.keymap.set('n', '<M-O>', 'm`O<Esc>``')

-- keeps cursor centered on screen when jumping up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- keeps cursor centered on screen when searching for terms
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- deletes selection without saving it to buffer (deleting to void)
vim.keymap.set('x', '<leader>p', '"_dP')

-- saves selection into system clipboard instead of vim buffer
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')

-- deletes to void
vim.keymap.set({ 'n', 'v' }, '<leader>x', '"_d')

-- replace all instances of term at cursor
vim.keymap.set('n', '<leader>ra', ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>')

--------------------------------------------------------------------- [[ Settings ]]

-- Make insert mode cursor PHAT
vim.opt.guicursor = ''

-- Make realtive line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable line wrap
vim.opt.wrap = false

-- Enable colorcolumn
vim.cmd('highlight colorcolumn guibg=lightgreen')
vim.opt.colorcolumn = '100'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = false

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Add four-space indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Disable linebreak
vim.opt.linebreak = false

-- Enable break indent
vim.opt.breakindent = true

-- disable vim backups and change history, undotree takes care of that
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- Disable highlight on search, but enablt incremental search
-- ...also remove any other highlighting with Esc
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--------------------------------------------------------------------- [[ Basic Autocommands ]]

--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--------------------------------------------------------------------- [[ Diagnostic keymappings ]]

-- functions allows automatic centering after jumping to places
local function centerAfterGotoPrev()
  vim.diagnostic.goto_prev()
  vim.api.nvim_feedkeys('zzzv', 'n', true)
end

local function centerAfterGotoNext()
  vim.diagnostic.goto_next()
  vim.api.nvim_feedkeys('zzzv', 'n', true)
end

-- jump to previous/next error message
vim.keymap.set('n', '[', centerAfterGotoPrev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']', centerAfterGotoNext, { desc = 'Go to next [D]iagnostic message' })

-- open full error message menu and quickfix menu
vim.keymap.set('n', '<leader>[', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>]', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- opens terminal and exits insert mode in terminal emulator
-- vim.keymap.set('n', '<leader>\\', ':split term://bash<CR>i')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--------------------------------------------------------------------- [[ Install `lazy.nvim` plugin manager ]]

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------- [[ Configure and install plugins ]]

--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  { import = 'plugins' }, -- import custom plugins from lua/plugins/

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
