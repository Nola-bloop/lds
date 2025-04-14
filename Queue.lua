---Author: Nola
---Queue list
---made for Lua 5.1.5

local Queue = {}
Queue.__index = Queue

function Queue.new()
    --node definition
    local Node = {} Node.__index = Node

    ---Node definition with a value and a single ptr to the next one
    ---@param v any
    ---@return table
    function Node.new(v)
        local insNode = setmetatable({}, Node)

        insNode.v = v or nil
        insNode.next = nil

        return insNode
    end





    --Queue private variables
    local ins = setmetatable({},Queue)
    local top = Node.new()
    local tail = top
    local count = 0

    ---insert a value at the end of the Queue
    ---@param v any : the value to insert
    function Queue:insert(v)
        if v == nil then return end

        count = count + 1

        if tail.v == nil then
            tail.v = v
        else
            local newNode = Node.new(v)
            tail.next = newNode
            tail = newNode
        end
    end

    ---read the top value
    ---@return any : the value on the top of the Queue
    function Queue:read()
        return top.v
    end

    ---Check if the Queue is empty
    ---@return boolean
    function Queue:empty()
        return top.v == nil
    end

    ---remove the top value
    ---@return number : the deleted value
    function Queue:pop()
        

        local out = top.v
        if not top.next then
            if top.v ~= nil then count = count - 1 end
            top.v = nil
        else
            count = count - 1
            top = top.next
        end
        return out
    end

    ---pop the whole Queue into a table
    ---@return table : all the Queue's values
    function Queue:burn()
        local out = {}
        while not self:empty() do
            out[#out+1] = self:pop()
        end
        return out
    end

    ---read how many entries are in the Queue
    ---@return integer : the count
    function Queue:count()
        return count
    end

    return ins
end

--statics
setmetatable(Queue, {
    ---call the constructor
    __call = function(cls, ...)
        return cls:new(...)
    end
})

return Queue