-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Make all keymaps silent by default.

local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

-- panel control
local function print_current_window_name()
  local current_window = vim.api.nvim_get_current_win()
  local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(current_window))
  print("Current window name: " .. buf_name)
end
vim.api.nvim_create_user_command("PrintCurrentWindowName", print_current_window_name, {})
vim.api.nvim_set_keymap("n", "<leader>nb", ":lua print_current_window_name()<CR>", { noremap = true, silent = true })

local function toggle_copilot_pane()
  local copilot_pane = vim.fn.bufwinnr("copilot-chat")
  if copilot_pane ~= -1 then
    if vim.fn.winnr() == copilot_pane then
      vim.cmd("close")
    else
      vim.cmd(copilot_pane .. "wincmd w")
    end
  else
    vim.cmd("CopilotChatOpen")
  end
end
local function toggle_neotree_pane()
  local neotree_pane = vim.fn.bufwinnr("neo-tree filesystem")
  if neotree_pane ~= -1 then
    if vim.fn.winnr() == neotree_pane then
      vim.cmd("Neotree close")
    else
      vim.cmd(neotree_pane .. "wincmd w")
    end
  else
    vim.cmd("Neotree toggle")
  end
end
vim.keymap.set("n", "<M-1>", toggle_neotree_pane)
vim.keymap.set("n", "<M-4>", "<cmd>CompilerToggleResults<cr>")
vim.keymap.set("n", "<M-5>", "<cmd>:lua require('avante').toggle()<CR>")
vim.keymap.set("n", "<M-7>", toggle_copilot_pane)

-- gotos
-- afct taken
vim.keymap.set("n", "<M-e>", vim.diagnostic.goto_next)
vim.keymap.set("n", "<M-e>", vim.diagnostic.goto_prev)

-- Make the leader a noop when not followed by something.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- Remap for dealing with word wrap.
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk$' : 'k$'", { expr = true })
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj$' : 'j$'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Keeping the cursor centered.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous result" })

-- Add undo break-points.
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

--insert shit
vim.keymap.set("n", "<leader>id", function()
  vim.cmd("normal! i" .. os.date("%Y-%m-%d "))
end)
-- Indent while remaining in visual mode.
-- vim.keymap.set('v', '<', '<gv')
-- vim.keymap.set('v', '>', '>gv')

-- Open the package manager.
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Quitting.
-- vim.keymap.set('n', '<leader>Q', '<cmd>qa<cr>', { desc = 'Quit all' })

-- fast folding
vim.keymap.set("n", "-", "za", { desc = "Toggle fold" })
-- Switch between windows.
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to the left window', remap = true })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to the bottom window', remap = true })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to the top window', remap = true })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to the right window', remap = true })

-- Clear search with <esc>
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Escape and save changes.
vim.keymap.set({ "s", "i", "n", "v" }, "<C-s>", "<esc>:w<cr>", { desc = "Exit insert mode and save changes." })

-- Execute macro over visual region.
-- vim.keymap.set("x", "@", function()
--   return ":norm @" .. vim.fn.getcharstr() .. "<cr>"
-- end, { expr = true })

-- HACK: <C-c> doesn't trigger the insert leave event, so remap it to escape so that it does.
vim.keymap.set("i", "<C-c>", "<esc>")
vim.keymap.set("i", "jk", [[<C-\><C-n>]], { desc = "Back to normal mode" })
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Back to normal mode" })
vim.keymap.set("x", "jk", [[<C-\><C-n>]], { desc = "Back to normal mode" })
vim.keymap.set("i", "<C-w>", "<esc><C-w>", { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Floating Terminal
vim.keymap.set("n", "<M-t>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open Floating Terminal" })
vim.keymap.set("n", "ŧ", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open Floating Terminal" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open Floating Terminal" })
vim.keymap.set("t", "<M-t>", "<cmd>close<cr>", { desc = "Close terminal" })
vim.keymap.set("t", "ŧ", "<cmd>close<cr>", { desc = "Close terminal" })

-- Open Horizontal Terminal
-- vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Open Horizontal Terminal" })
-- vim.keymap.set("n", "<F7>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Open Horizontal Terminal" })

-- Open Vertical Terminal
-- vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Open Vertical Terminal" })

-- Open Toggle Lazygit
vim.keymap.set(
  "n",
  "<leader>tl",
  '<cmd>ToggleTerm cmd="lazygit" direction=vertical<cr>',
  { desc = "Toggle vertical terminal" }
)

-- Open Toggle
vim.keymap.set("n", "<leader>tn", '<cmd>ToggleTerm cmd="node" direction=vertical<cr>', { desc = "Open Toggle Node" })

-- Open Toggle Python
-- vim.keymap.set(
--   "n",
--   "<leader>tp",
--   '<cmd>ToggleTerm cmd="python" direction=vertical<cr>',
--   { desc = "Open Toggle Python" }
-- )

-- Open Toggle btm
vim.keymap.set("n", "<leader>tt", '<cmd>ToggleTerm cmd="btm" direction=vertical<cr>', { desc = "Open Toggle btm" })
vim.keymap.set("n", "ñ", ":", { desc = "Close terminal" })

-- CopilotChat
vim.keymap.set("n", "<leader>av", "<cmd>CopilotChatOpen<cr>", { desc = "CopilotChatOpen" })
vim.keymap.set("n", "<leader>an", "<cmd>CopilotChatOpen<cr>", { desc = "CopilotChatOpen" })
vim.keymap.set("n", "<leader>ae", "<cmd>CopilotChatExplain<cr>", { desc = "CopilotChatExplain" })

-- surround
-- vim.keymap.set("n", "<CR>", "<cmd>Surround<cr>", { desc = "Surround" })

-- oil
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- yanky
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- hello world
-- vim.keymap.set('n', '<c-_>', ':CommentToggle<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<c-_>', ':CommentToggle<CR>', { noremap = true, silent = true })

-- comments
-- vim.keymap.set("n", "ﾯ", "gc^j")
vim.keymap.set("n", "ﾯ", "gccj", { noremap = true })
vim.keymap.set("n", "<C-_>", "gccj", { noremap = true })
vim.keymap.set("n", "<C-/>", "gccj", { noremap = true })

-- buffer tab control
vim.keymap.set("n", "<PageDown>", "<C-d>zz")
vim.keymap.set("n", "<PageUp>", "<C-u>zz")
vim.keymap.set("n", "<C-PageDown>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-PageUp>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<C-S-PageDown>", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<C-S-PageUp>", ":BufferLineMovePrev<CR>")
-- vim.keymap.set("i", "<c-bs>", "dw")
-- vim.keymap.set("i", "<c-bs>", "dw")
--

-- ctrl arrow movement
-- vim.keymap.set("n", "<C-Up>", "{")
-- vim.keymap.set("n", "<C-Down>", "}")
vim.keymap.set("n", "<C-Left>", "B")
vim.keymap.set("n", "<C-Right>", "E")
-- vim.keymap.set("i", "<C-Left>", "B")
-- vim.keymap.set("i", "<C-Right>", "E")

vim.keymap.set("i", "<C-Left>", "<C-o>B")
vim.keymap.set("i", "<C-Right>", "<C-o>E")

-- arrow movement
-- vim.keymap.set("n", "<Up>", "<Up>_")
-- vim.keymap.set("n", "<Down>", "<Down>_")
-- vim.keymap.set("n", "<Left>", "<Left>_")
-- vim.keymap.set("n", "<Right>", "<Right>_")

-- arrow resize
-- vim.keymap.set("n", "<A-Up>", ":resize +3<CR>")
-- vim.keymap.set("n", "<A-Down>", ":resize -3<CR>")
-- vim.keymap.set("n", "<A-Left>", ":vertical resize +3<CR>")
-- vim.keymap.set("n", "<A-Right>", ":vertical resize -3<CR>")

-- arrow resize
vim.keymap.set("n", "<C-S-Up>", ":resize +3<CR>")
vim.keymap.set("n", "<C-S-Down>", ":resize -3<CR>")
vim.keymap.set("n", "<C-S-Left>", ":vertical resize +3<CR>")
vim.keymap.set("n", "<C-S-Right>", ":vertical resize -3<CR>")

-- arrow move window
vim.keymap.set("n", "<A-Up>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Left>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", "<C-w>l", { noremap = true, silent = true })

-- backspace delete word
-- vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "", "<C-w>")

-- switch window
vim.keymap.set("n", "<C-Tab>", "<C-w>w", { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>", "<C-w>w", { noremap = true, silent = true })

-- telescope notification
vim.keymap.set("n", "<leader>fN", ":Telescope notify")
-- vim.keymap.set("n", "<leader>fN", ":Telescope notify", { noremap = true, silent = true })

-- telescope cwd search
vim.keymap.set("n", "<leader>ff", LazyVim.pick("files", { root = false }), { noremap = true, silent = true })

-- Compiler
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>nc", "<cmd>CompilerOpen<cr>", { desc = "Open compiler" })
vim.keymap.set("n", "<leader>nr", "<cmd>CompilerOpen<cr>", { desc = "Open compiler" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>nr",
  -- "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
  "<cmd>CompilerRedo<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<S-F7>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
