require('lazy').load({plugins={'minuet-ai.nvim'}})
local trim=require('config.local_coder_suffix').trim
local prefix='pub fn plugin('
local cases={
 {'screenshot','(app: &mut App) {\n    app.add_systems(Update, spawn_player);\n}', 'app: &mut App'},
 {'single line duplicate','(app: &mut App) {','app: &mut App'},
 {'only needed text','app: &mut App','app: &mut App'},
 {'right duplicate only','app: &mut App) {','app: &mut App'},
 {'tuple destructuring','(x, y): (i32, i32)','(x, y): (i32, i32)'},
 {'tuple with extra close','(x, y): (i32, i32)) {}','(x, y): (i32, i32)'},
 {'nested fn pointer','f: fn(i32) -> (i32, i32)','f: fn(i32) -> (i32, i32)'},
 {'comment parentheses','app: /* ) */ &mut App','app: /* ) */ &mut App'},
 {'lifetimes',"app: &'a mut App", "app: &'a mut App"},
 {'generic fn','(f: impl Fn() -> Result<(), Error>) {','f: impl Fn() -> Result<(), Error>'},
 {'incomplete type','app: &mut',nil},
 {'repeated entire declaration','pub fn plugin(app: &mut App) {}',nil},
}
for _,case in ipairs(cases) do
 local value=trim(case[2],')\n',prefix,'rust')
 assert(value==case[3],case[1]..': '..vim.inspect(value)..' expected '..vim.inspect(case[3]))
end
assert(trim('inner(x)',');','outer(','rust')=='inner(x)','nested call altered')
assert(trim('(x, y)',')','call(','python')=='(x, y)','other language altered')
print('PASS: 12 Rust parameter cases, nested calls, other language isolation')
vim.cmd('qa!')
