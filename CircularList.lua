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
    end

    ---Remove the node at the bookmark's prosition. The bookmark is then moved to the ex-previous node.
    ---@return any : the value of the bookmark after the deletion
    ---@return boolean : the flag state
    function Circular:remove()
        local back = bookmark.prev
        local front = bookmark.next

        back.next = front
        front.prev = back
        bookmark = back
        return bookmark.v, bookmark.flag
    end

    ---move the bookmark to the next node
    ---@return any : the new value of the bookmark
    ---@return boolean : true if the node is flagged, false if not
    function Circular:next()
        bookmark = bookmark.next
        return bookmark.v, bookmark.flag
    end

    ---move the bookmark to the previous node
    ---@return any : the new value of the bookmark
    ---@return boolean : true if the node is flagged, false if not
    function Circular:previous()
        bookmark = bookmark.prev
        return bookmark.v, bookmark.flag
    end
    
    return ins
end

return Circular