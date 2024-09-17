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

-- Make the leader a noop when not followed by something.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- Remap for dealing with word wrap.
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

-- Indent while remaining in visual mode.
-- vim.keymap.set('v', '<', '<gv')
-- vim.keymap.set('v', '>', '>gv')

-- Open the package manager.
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Quitting.
-- vim.keymap.set('n', '<leader>Q', '<cmd>qa<cr>', { desc = 'Quit all' })

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
vim.keymap.set("n", "<leader>aa", "<cmd>CopilotChatOpen<cr>", { desc = "Toggle vertical copilot chat" })

-- surround
-- vim.keymap.set("n", "<CR>", "<cmd>Surround<cr>", { desc = "Surround" })

-- oil
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- yanky
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- hello world
-- vim.keymap.set('n', '<c-_>', ':CommentToggle<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<c-/>', 'gc<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-_>', 'gc<CR>')
-- <PageDown><PageUp><C-PageDown><C-BS>

vim.keymap.set('n', '<C-PageDown>', '<leader>bP')
vim.keymap.set('n', '<C-PageUp>', '<leader>bP')
-- vim.keymap.set("i", "<c-bs>", "dw")
-- vim.keymap.set("i", "<c-bs>", "dw")
vim.keymap.set("n", "<C-Up>", "{")
vim.keymap.set("n", "<C-Down>", "}")
vim.keymap.set("n", "<C-Left>", "b")
vim.keymap.set("n", "<C-Right>", "w")
