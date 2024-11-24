return {
  'icecreamtheme/neovim', -- Theme repo name

  -- 'lazy' and 'priority' loads this theme before all the other start plugins.
  lazy = false,
  priority = 1000,

  -- Other customisations for the theme are written inside this function
  init = function()
    -- This loads the theme by calling a command (some themes have multiple styles)
    vim.cmd.colorscheme 'icecream'

    -- This makes the background opaque
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  end,
}
