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
local Queue = require("Queue")

local list = Queue()

list:insert("p")
list:insert("o")
list:insert("m")
list:insert("m")
list:insert("e")
list:insert(" ")
list:insert("d")
list:insert("e")
list:insert(" ")
list:insert("t")
list:insert("e")
list:insert("r")
list:insert("r")
list:insert("e")

while not list:empty() do
    print(list:pop())
end
