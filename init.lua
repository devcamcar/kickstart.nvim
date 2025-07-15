require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins.theme',
  require 'plugins.neo-tree',
  require 'plugins.bufferlines',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.todo-comments',
  require 'plugins.autocomplete',
  require 'plugins.lsp',
  require 'plugins.none-ls',
  require 'plugins.indent-blankline',
  require 'plugins.alpha',
  require 'plugins.misc',
  --  require 'plugins.lazydev',
  --  require 'plugins.conform',
  --  require 'plugins.complete',
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

-- Silence the specific position encoding message
local notify_original = vim.notify
vim.notify = function(msg, ...)
  if
      msg
      and (
        msg:match 'position_encoding param is required'
        or msg:match 'Defaulting to position encoding of the first client'
        or msg:match 'multiple different client offset_encodings'
      )
  then
    return
  end
  return notify_original(msg, ...)
end
