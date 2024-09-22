return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  opts = function()
    local ai = require("mini.ai")
    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({ -- code block
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
        d = { "%f[%d]%d+" }, -- digits
        e = { -- Word with case
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        i = LazyVim.mini.ai_indent, -- indent
        g = LazyVim.mini.ai_buffer, -- buffer
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)
    LazyVim.on_load("which-key.nvim", function()
      vim.schedule(function()
        LazyVim.mini.ai_whichkey(opts)
      end)
    end)
  end
}

-- -- No need to copy this inside `setup()`. Will be used automatically.
-- {
--   -- Table with textobject id as fields, textobject specification as values.
--   -- Also use this to disable builtin textobjects. See |MiniAi.config|.
--   custom_textobjects = nil,
--
--   -- Module mappings. Use `''` (empty string) to disable one.
--   mappings = {
--     -- Main textobject prefixes
--     around = 'a',
--     inside = 'i',
--
--     -- Next/last variants
--     around_next = 'an',
--     inside_next = 'in',
--     around_last = 'al',
--     inside_last = 'il',
--
--     -- Move cursor to corresponding edge of `a` textobject
--     goto_left = 'g[',
--     goto_right = 'g]',
--   },
--
--   -- Number of lines within which textobject is searched
--   n_lines = 50,
--
--   -- How to search for object (first inside current line, then inside
--   -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
--   -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
--   search_method = 'cover_or_next',
--
--   -- Whether to disable showing non-error feedback
--   silent = false,
-- }
