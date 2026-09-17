-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  -- Neo-tree is enabled in init.lua via `require 'kickstart.plugins.neo-tree'`.
  -- This spec is merged on top of it to add a <C-e> toggle without touching the
  -- kickstart file (so upstream updates never conflict). `\` still reveals.
  {
    'nvim-neo-tree/neo-tree.nvim',
    keys = {
      { '<C-e>', '<cmd>Neotree toggle reveal left<CR>', desc = 'Toggle file [E]xplorer', silent = true },
    },
    opts = {
      filesystem = {
        -- Show dotfiles and gitignored files instead of hiding them.
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        window = {
          mappings = {
            ['<C-e>'] = 'close_window',
          },
        },
      },
    },
  },

  -- Jump to any visible location with `s` + two characters.
  -- Also upgrades f/F/t/T and makes `/` search jumpable.
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@module 'flash'
    ---@type Flash.Config
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<C-s>', mode = 'c', function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },

  -- Edit your filesystem like a normal buffer: `dd` to delete, `p` to move,
  -- change a name and `:w` to rename. `-` opens the parent directory.
  {
    'stevearc/oil.nvim',
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { '-', '<cmd>Oil<CR>', desc = 'Open parent directory (oil)' },
      { '<leader>-', function() require('oil').toggle_float() end, desc = 'Oil in a floating window' },
    },
  },

  -- todo-comments is already installed by kickstart's init.lua; this only adds
  -- navigation + search keymaps and turns the sign column markers back on.
  {
    'folke/todo-comments.nvim',
    ---@diagnostic disable-next-line: missing-fields
    opts = { signs = true },
    keys = {
      {
        ']t',
        function() require('todo-comments').jump_next() end,
        desc = 'Next [T]odo comment',
      },
      {
        '[t',
        function() require('todo-comments').jump_prev() end,
        desc = 'Previous [T]odo comment',
      },
      { '<leader>st', '<cmd>TodoTelescope<CR>', desc = '[S]earch [T]odo comments' },
      { '<leader>sT', '<cmd>TodoQuickFix<CR>', desc = '[S]earch [T]odos to quickfix' },
    },
  },
}
