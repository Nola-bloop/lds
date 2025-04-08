---Author: Nola
---Circular list

------------------------------------------

--then define the list itself:
local Circular = {}
Circular.__index = Circular

function Circular.new()

    --definition of nodes
        local Node = {}
        Node.__index = Node;

        function Node.new(v)
            local ins = setmetatable({}, Node)

            ins.v = v
            ins.next = nil
            ins.prev = nil
            ins.flag = false

            return ins
        end

    local ins = setmetatable({}, Circular)
    local bookmark = Node.new();
    local count = 0;

    ---read the value of the bookmark
    ---@return any : the value inside the bookmark
    ---@return nil|boolean : true if a flag is found, false if not. nil if there is no value
    function Circular:read()
        return bookmark.v, bookmark.flag
    end

    ---if the bookmark has a nil value, insert the value there, else, insert a new node behind the bookmark
    ---@param v unknown
    function Circular:insert(v)
        --handle no prior data
        if bookmark.v == nil then
            bookmark.v = v
        else
            --handle single data case
            if not bookmark.prev then
                local newNode = Node.new(v)

                newNode.prev = bookmark
                newNode.next = bookmark
                bookmark.next = newNode
                bookmark.prev = newNode

            --handle every other case
            else
                local newNode = Node.new(v)
                local back = bookmark.prev

                back.next = newNode
                newNode.next = bookmark
                newNode.prev = back
                bookmark.prev = newNode
            end
        end

        count = count + 1;
    end

    ---Remove the node at the bookmark's prosition. The bookmark is then moved to the ex-previous node.
    ---@return any : the value of the bookmark after the deletion
    ---@return boolean : the flag state. if the bookmark value is nil, this will default to false
    function Circular:remove()
        if bookmark.next == nil then
            bookmark.v = nil
            bookmark.flag = false
            return nil, false
        end

        if bookmark.next == bookmark.prev then
            local last = bookmark.next
            last.next = nil
            last.prev = nil
            bookmark = last
            return bookmark.v, bookmark.flag
        end

        local back = bookmark.prev
        local front = bookmark.next

        back.next = front
        front.prev = back
        bookmark = back

        count = count - 1;

        return bookmark.v, bookmark.flag
    end

    ---move the bookmark to the next node
    ---@param iterations number|nil : how far to go (default 1)
    ---@return any : the new value of the bookmark
    ---@return boolean : true if the node is flagged, false if not
    function Circular:next(iterations)
        iterations = iterations or 1
        for i = 1, iterations do
            bookmark = bookmark.next
        end
        return bookmark.v, bookmark.flag
    end

    ---move the bookmark to the previous node
    ---@param iterations number|nil : how far back to go (default 1)
    ---@return any : the new value of the bookmark
    ---@return boolean : true if the node is flagged, false if not
    function Circular:previous(iterations)
        iterations = iterations or 1
        for i = 1, iterations do
            bookmark = bookmark.prev
            
        end
        return bookmark.v, bookmark.flag
    end

    ---Check if the circular list is empty
    ---@return boolean : true if empty, false otherwise.
    function Circular:empty()
        return bookmark.v == nil
    end

    ---reads the number of values inside the wheel
    ---@return integer : the number of values
    function Circular:count()
        return count
    end

    ---turns the circular list into a table by deleting the values
    ---@return table : a table of the values
    function Circular:burn()
        local values = {}
        while not self:empty() do
            values[#values+1] = self:read()
            self:remove()
        end
        return values
    end

    ---set the flag of the node at the current bookmark
    ---@param v any
    function Circular:setFlag(v)
        if type(v) ~= "boolean" then error("Cannot set anything else than boolean on flag. type used: "..type(v)) end

        bookmark.flag = v;
    end

    ---read only the flag state
    ---@return boolean : flag state
    function Circular:readFlag()
        return bookmark.flag
    end

    return ins
end

return Circular