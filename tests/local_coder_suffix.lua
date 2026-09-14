-- Run with the normal configuration: nvim --headless '+luafile <this-file>'
require('lazy').load({plugins={'minuet-ai.nvim','blink.cmp'}})
local config=require('minuet').config
local options=config.provider_options.openai_fim_compatible
local utils=require('minuet.utils')
local backend=require('minuet.backends.openai_fim_compatible')
local raw, captured
local start_job=require('minuet.backends.common').start_job
-- Replace only the transport. Use the real provider, FIM prompt, filtering and
-- callback path so this regression fails without the installed suffix guard.
require('minuet.backends.common').start_job=function(_,args,handlers)
 local file=args[#args]
 -- minuet stores the body in a file referenced by --data-binary @<path>.
 for _,arg in ipairs(args) do if arg:sub(1,1)=='@' then file=arg:sub(2) end end
 captured=vim.json.decode(table.concat(vim.fn.readfile(file),'\n'))
 local body
 if options.stream then body='data: '..vim.json.encode({choices={{text=raw}}})..'\n\ndata: [DONE]\n'
 else body=vim.json.encode({choices={{text=raw}}}) end
 vim.schedule(function() handlers.on_exit({}, {code=0,stdout=body,stderr=''}) end)
 return {pid=0}
end
local after='<Entity>,\n    /// The modifier owner, a parent modifier identity\n    pub owner: Option<Entity>,\n}'
local tests={
 {'short inline overlap','Option<Entity>,',after,'Option'},
 {'screenshot spill','Option'..after..'\n\n#[derive(Component)]\npub struct Another {',after,'Option'},
 {'already correct','Option',after,'Option'},
 {'partial suffix','Option<Entity>','<Entity>,','Option'},
 {'exact duplicate',after,after,nil},
 {'ambiguous inline spill','Entity,\n    pub owner: Entity,',after,nil},
 {'ordinary multiline','if x {\n    return 1;\n}', '\n}', 'if x {\n    return 1;\n}'},
 {'new function before existing function','fn new() {}\n\nfn existing() {}\nmore','\n\nfn existing() {}','fn new() {}'},
 {'literal pattern characters','Result<T, E>,','<T, E>,','Result'},
 {'nested closers','inner(x)',');','inner(x)'},
 {'no suffix','some_code','', 'some_code'},
 {'identifier coincidence','food','foobar', 'food'},
}
for _,stream in ipairs({false,true}) do
 options.stream=stream
 for _,case in ipairs(tests) do
  raw=case[2];local result
  local context={lines_before='pub source: ',lines_after=case[3],opts={}}
  backend.complete(context,function(items) result=items end)
  assert(vim.wait(1000,function()return result~=nil end),'callback stalled')
  assert(result[1]==case[4],case[1]..': '..vim.inspect(result)..' expected '..vim.inspect(case[4]))
  assert(captured.prompt:find('<|fim_suffix|>'..case[3]..'<|fim_middle|>',1,true),'suffix omitted from prompt')
 end
end
options.name='Other provider';raw='Option<Entity>,'
local passthrough
backend.complete({lines_before='',lines_after=after,opts={}},function(items)passthrough=items end)
assert(vim.wait(1000,function()return passthrough~=nil end))
assert(passthrough[1]==raw,'other provider modified')
require('minuet.backends.common').start_job=start_job
print('PASS: 24 provider-path suffix cases plus other-provider isolation')
vim.cmd('qa!')
