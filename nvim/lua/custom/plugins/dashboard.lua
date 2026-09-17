-- A pretty start screen, replacing Neovim's default intro splash, plus a
-- floating lazygit window (<leader>gg). Only the `dashboard` and `lazygit`
-- modules of snacks.nvim are enabled here; the rest of the kickstart setup
-- (telescope, neo-tree, ...) is left untouched and is what the menu entries
-- below drive.

---@module 'lazy'
---@type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazy[G]it' },
    { '<leader>gl', function() Snacks.lazygit.log() end, desc = '[G]it [L]og (lazygit)' },
    { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = '[G]it log current [F]ile' },
  },
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    lazygit = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        -- `key` is both the shortcut shown on the right and the mapping that
        -- is created while the dashboard is focused.
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ':Telescope live_grep' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
          { icon = ' ', key = 'e', desc = 'File Explorer', action = ':Neotree toggle reveal left' },
          { icon = ' ', key = 'G', desc = 'Lazygit', action = function() Snacks.lazygit() end },
          { icon = ' ', key = 'c', desc = 'Config', action = ':Telescope find_files cwd=' .. vim.fn.stdpath 'config' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 0, padding = 1 },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', limit = 5, indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
  },
}
