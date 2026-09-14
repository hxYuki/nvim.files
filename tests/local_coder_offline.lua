require('lazy').load({plugins={'minuet-ai.nvim','blink.cmp'}})
local notices={}
vim.notify=function(msg) notices[#notices+1]=tostring(msg) end
local config=require('minuet').config
local options=config.provider_options.openai_fim_compatible
options.end_point='http://127.0.0.1:18012/v1/completions'
options.stream=false
local backend=require('minuet.backends.openai_fim_compatible')
local context={lines_before='def f():\n    ',lines_after='\n',opts={}}
local function request()
  local result
  backend.complete(context,function(items) result=items end)
  assert(vim.wait(2000,function() return result~=nil end),'callback stalled')
  return result
end
assert(#request()==0)
assert(#notices==0,'offline notification')
local calls=0
local system=vim.system
vim.system=function(...) calls=calls+1;return system(...) end
assert(#request()==0 and calls==0,'cooldown still launched request')
vim.system=system
local server=vim.system({'python','-u','-c',[[
from http.server import BaseHTTPRequestHandler,HTTPServer
class H(BaseHTTPRequestHandler):
 def do_POST(self):
  self.rfile.read(int(self.headers['Content-Length']))
  body=b'{"choices":[{"text":"return 42"}]}'
  self.send_response(200);self.send_header('Content-Type','application/json');self.send_header('Content-Length',str(len(body)));self.end_headers();self.wfile.write(body)
 def log_message(self,*a): pass
HTTPServer(('127.0.0.1',18012),H).serve_forever()
]]})
local ok,err=pcall(function()
  vim.wait(3100,function() return false end)
  assert(request()[1]=='return 42','did not recover when server returned')
  assert(#notices==0)
  local action=LazyVim.cmp.actions.ai_accept
  local fallback=action()
  assert(fallback==nil,'Tab fallback consumed')
  local utils=require('minuet.utils')
  for _,name in ipairs({'stream_decode','no_stream_decode'}) do
    local file=vim.fn.tempname();vim.fn.writefile({'test'},file)
    utils[name]({code=7,stdout=''},file,'Other provider',function()end)
    assert(vim.fn.filereadable(file)==0)
  end
  assert(#notices==2,'unrelated provider errors suppressed')
end)
server:kill(15);server:wait()
assert(ok,err)
print('PASS: offline, cooldown, recovery, Tab fallback, unrelated errors')
vim.cmd('qa!')
