---Author: Nola
---Stack list
---made for Lua 5.1.5

local Stack = {}
Stack.__index = Stack

function Stack.new()
    --node definition
    local Node = {} Node.__index = Node
    function Node.new(v)
        local insNode = setmetatable({}, Node)

        insNode.v = v or nil
        insNode.next = nil

        return insNode
    end

    --Stack internal variables
    local ins = setmetatable({},Stack)
    local top = Node.new()
    local count = 0

    ---insert a value on top of the stack
    ---@param v any : the value to insert
    function Stack:insert(v)
        count = count + 1

        if top.v == nil then
            top.v = v
        else
            local newNode = Node.new(v)
            newNode.next = top
            top = newNode
        end
    end

    ---read the top value
    ---@return any : the value on the top of the stack
    function Stack:read()
        return top.v
    end

    ---Check if the stack is empty
    ---@return boolean
    function Stack:empty()
        return top.v == nil
    end

    ---remove the top value
    ---@return number : the deleted value
    function Stack:pop()
        count = count - 1

        local out = top.v
        if not top.next then
            top.v = nil
        else
            top = top.next
        end
        return out
    end

    ---pop the whole stack into a table
    ---@return table : all the stack's values
    function Stack:burn()
        local out = {}
        while not self:empty() do
            out[#out+1] = self:pop()
        end
        return out
    end

    ---read how many entries are in the stack
    ---@return integer : the count
    function Stack:count()
        return count
    end

    return ins
end

--statics
setmetatable(Stack, {
    ---call the constructor
    __call = function(cls, ...)
        return cls:new(...)
    end
})

return Stack