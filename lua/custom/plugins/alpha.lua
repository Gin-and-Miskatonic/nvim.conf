return {
  'goolord/alpha-nvim',
  cmd = 'Alpha',
  opts = function()
    local dashboard = require 'alpha.themes.dashboard'
    --dashboard.section.header.val = {
    local header = [[
      █▀▄▀█ ▄█    ▄▄▄▄▄   █  █▀ ██     ▄▄▄▄▀ ████▄    ▄   ▄█ ▄█▄    
      █ █ █ ██   █     ▀▄ █▄█   █ █ ▀▀▀ █    █   █     █  ██ █▀ ▀▄  
      █   █ ██ ▄  ▀▀▀▀▄   █▀▄   █▄▄█    █    █   █ ██   █ ██ █   ▀  
      █   █ ▐█  ▀▄▄▄▄▀    █  █  █  █   █     ▀████ █ █  █ ▐█ █▄  ▄▀ 
         █   ▐              █      █  ▀            █  █ █  ▐ ▀███▀  
        ▀                  ▀      █                █   ██           
                                 ▀                                  
                  ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█ 
                   █  █▀   ▀  █   █      █  ██ █ █ █ 
               ██   █ ██▄▄    █   █ █     █ ██ █   █ 
               █ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █ 
               █  █ █ ▀███▀           █  █   ▐    █  
               █   ██                  █▐        ▀   
                                       ▐             
    ]]
    --}
    dashboard.section.header.val = vim.split(header, '\n')
    dashboard.section.header.opts.hl = 'DashboardHeader'
    dashboard.section.footer.opts.hl = 'DashboardFooter'
    --local button, get_icon = require("astronvim.utils").alpha_button, require("astronvim.utils").get_icon
    dashboard.section.buttons.val = {
      dashboard.button('LDR n  ', 'New File  '),
      dashboard.button('LDR s f', 'Find File  '),
      dashboard.button('LDR s .', 'Recents  '),
      dashboard.button('LDR s w', 'Find Word  '),
      dashboard.button("LDR s '", 'Bookmarks  '),
      --dashboard.button('LDR S l', 'Last Session  '),
    }

    dashboard.config.layout = {
      { type = 'padding', val = vim.fn.floor(vim.fn.winheight(0) * 0.1) },
      dashboard.section.header,
      { type = 'padding', val = 2 },
      dashboard.section.buttons,
      { type = 'padding', val = 1 },
      dashboard.section.footer,
    }
    --dashboard.config.opts.noautocmd = true
    return dashboard
  end,
  config = function(_, opts)
    require('alpha').setup(opts.config)

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      desc = 'Add Alpha dashboard footer',
      once = true,
      callback = function()
        local stats = require('lazy').stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        opts.section.footer.val = { 'Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
        require('alpha').redraw()
      end,
    })
  end,
}
