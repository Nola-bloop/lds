--[[
local CircularList = require("CircularList")

local list = CircularList()

list:insert("3")
list:insert("7") --x
list:insert("2")
list:insert("8")
list:insert("9")

list:next(1)
list:remove()
list:next(2)
list:insert("peepoo")



list:setFlag(true)
print(list:next())
while not list:readFlag() do
    print(list:next())
end
]]
local Stack = require("Stack")

local stack = Stack()

stack:insert("p")
stack:insert("o")
stack:insert("m")
stack:insert("m")
stack:insert("e")
stack:insert(" ")
stack:insert("d")
stack:insert("e")
stack:insert(" ")
stack:insert("t")
stack:insert("e")
stack:insert("r")
stack:insert("r")
stack:insert("e")

while not stack:empty() do
    print(stack:pop())
end
