require('lazy').load({plugins={'minuet-ai.nvim','blink.cmp'}})
local options=require('minuet').config.provider_options.openai_fim_compatible
local after=')\n'
local request_seen=false
require('minuet.backends.common').start_job=function(_,args,handlers)
 local file
 for _,arg in ipairs(args) do if arg:sub(1,1)=='@' then file=arg:sub(2) end end
 local payload=vim.json.decode(table.concat(vim.fn.readfile(file),'\n'))
 assert(payload.prompt:find('<|fim_suffix|>'..after,1,true),'actual cursor suffix missing')
 request_seen=true
 local raw='(app: &mut App) {\n    app.add_systems(Update, spawn_player);\n}'
 local body='data: '..vim.json.encode({choices={{text=raw}}})..'\n\ndata: [DONE]\n'
 vim.schedule(function()handlers.on_exit({}, {code=0,stdout=body,stderr=''})end)
 return {pid=0}
end
vim.cmd('enew')
vim.bo.filetype='rust'
local original={'pub fn plugin()'}
vim.api.nvim_buf_set_lines(0,0,-1,false,original)
vim.api.nvim_win_set_cursor(0,{1,#'pub fn plugin('})
vim.cmd('startinsert')
vim.defer_fn(function()
 local action=require('minuet.virtualtext').action
 action.next()
 local timer=vim.uv.new_timer()
 local attempts=0
 timer:start(50,50,vim.schedule_wrap(function()
  attempts=attempts+1
  if not action.is_visible() and attempts<30 then return end
  timer:stop();timer:close()
  assert(action.is_visible(),'no suggestion')
  local marks=vim.api.nvim_buf_get_extmarks(0,require('minuet.virtualtext').ns_id,0,-1,{details=true})
  assert(marks[1][4].virt_text[1][1]=='app: &mut App','preview still duplicates suffix')
  assert(not marks[1][4].virt_lines or #marks[1][4].virt_lines==0,'preview leaked repeated lines')
  assert(vim.fn.maparg('<Tab>','i',false,true).desc=='blink.cmp: <Custom Fn>')
  local key=vim.env.SUFFIX_TEST_ACCEPT or '<Tab>'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key,true,false,true),'m',false)
  vim.defer_fn(function()
   local expected=vim.deepcopy(original);expected[1]='pub fn plugin(app: &mut App)'
   assert(vim.deep_equal(vim.api.nvim_buf_get_lines(0,0,-1,false),expected),'accepted buffer duplicated/removed context')
   assert(request_seen)
   print('PASS '..key..': only missing parameters displayed and inserted, original parentheses preserved')
   vim.cmd('qa!')
  end,200)
 end))
end,600)
