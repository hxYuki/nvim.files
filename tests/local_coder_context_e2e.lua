require('lazy').load({plugins={'minuet-ai.nvim','blink.cmp'}})
vim.b.minuet_virtual_text_auto_trigger=false
local action=require('minuet.virtualtext').action
local before_request
require('minuet.backends.common').start_job=function(_,args,handlers)
 local file
 for _,arg in ipairs(args) do if arg:sub(1,1)=='@' then file=arg:sub(2) end end
 before_request=vim.json.decode(table.concat(vim.fn.readfile(file),'\n')).prompt
 local body='data: '..vim.json.encode({choices={{text='(app: &mut App) {\n    app.add_systems(Update, spawn_player);\n}'}}})..'\n\ndata: [DONE]\n'
 vim.defer_fn(function()handlers.on_exit({}, {code=0,stdout=body,stderr=''})end,300)
 return {pid=0}
end
vim.cmd('enew')
vim.bo.filetype='rust'
vim.b.minuet_virtual_text_auto_trigger=false
vim.api.nvim_buf_set_lines(0,0,-1,false,{'pub fn plugin'})
vim.api.nvim_win_set_cursor(0,{1,#'pub fn plugin'})
vim.cmd('startinsert!')
vim.defer_fn(function()
 action.next()
 -- The user/autopair plugin adds () while the earlier request is in flight.
 vim.defer_fn(function()
  vim.api.nvim_buf_set_lines(0,0,-1,false,{'pub fn plugin()'})
  vim.api.nvim_win_set_cursor(0,{1,#'pub fn plugin('})
 end,80)
 vim.defer_fn(function()
  print('REQUEST='..before_request)
  print('BUFFER='..vim.api.nvim_get_current_line())
  print('STALE_VISIBLE='..tostring(action.is_visible()))
  assert(not action.is_visible(),'old request rendered inside newly typed parentheses')
  vim.cmd('qa!')
 end,550)
end,400)
