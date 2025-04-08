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
