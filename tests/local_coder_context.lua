require('lazy').load({plugins={'minuet-ai.nvim'}})
local options=require('minuet').config.provider_options.openai_fim_compatible
options.stream=false
local pending
require('minuet.backends.common').start_job=function(_,_,handlers)
 pending=handlers
 return {pid=0}
end
local backend=require('minuet.backends.openai_fim_compatible')
local cases={'unchanged','typing','cursor','buffer'}
for _,case in ipairs(cases) do
 local buf=vim.api.nvim_create_buf(false,true)
 vim.api.nvim_set_current_buf(buf)
 vim.api.nvim_buf_set_lines(buf,0,-1,false,{'prefix'})
 vim.api.nvim_win_set_cursor(0,{1,3})
 local items
 backend.complete({lines_before='pre',lines_after='fix',opts={}},function(value)items=value end)
 if case=='typing' then vim.api.nvim_buf_set_lines(buf,0,-1,false,{'prefix()'}) end
 if case=='cursor' then vim.api.nvim_win_set_cursor(0,{1,4}) end
 if case=='buffer' then
  local other=vim.api.nvim_create_buf(false,true)
  vim.api.nvim_buf_set_lines(other,0,-1,false,{'prefix'})
  vim.api.nvim_set_current_buf(other)
  vim.api.nvim_win_set_cursor(0,{1,3})
 end
 pending.on_exit({}, {code=0,stdout=vim.json.encode({choices={{text='fresh'}}}),stderr=''})
 assert(items and ((case=='unchanged' and items[1]=='fresh') or (case~='unchanged' and #items==0)),case..': '..vim.inspect(items))
end
print('PASS: unchanged request accepted; typing, cursor movement and buffer switch discard obsolete replies')
vim.cmd('qa!')
