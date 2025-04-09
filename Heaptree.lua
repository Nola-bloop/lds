local nullptr = "nullptr"
local Heaptree = {}
Heaptree.__index = Heaptree

---Constructor of the Heaptree
---@param _datatype string|nil : the type of the values. leave nil to avoid type checks (only leave nil if you know what you're doing)
---@param _comparator boolean|nil : true = heapmax, false = heapmin (defautls to heapmin)
---@diagnostic disable-next-line
---@return Heaptree : a Heaptree object
function Heaptree.new(_datatype, _comparator)
    --node definition
    local Node = {} Node.__index = Node
    function Node.new(parent)
        local insNode = setmetatable({}, Node)

        insNode.v = nil
        local left = nullptr
        local right = nullptr
        local childCount = nil
        local Parent = parent or nullptr

        function Heaptree:refreshChildCount()
            childCount = 0
            if left ~= nullptr then
                ---@diagnostic disable-next-line: undefined-field
                childCount = childCount + left.childCount() + 1
            end
            if right ~= nullptr then
                ---@diagnostic disable-next-line: undefined-field
                childCount = childCount + right.childCount() + 1
            end
            if parent ~= nullptr then
                parent.refreshChildCount()
            end
        end

        function Node:childCount()
            return childCount
        end

        function Node:parent(v)
            if v.getmetatable() == Node then
                if v.left() ~= insNode or v.right() ~= insNode then error("ERROR: Trying to set the parent of a node without linking the parent to the child first!") end
                parent = v
            elseif v == nullptr then
                error("ERROR: You shouldn't need to remove the parent of a node. (Heaptree)")
            else
                error("ERROR: You aren't allowed to put anything else than nodes in the parent value!")
            end
            return parent
        end

        function Node:left(v)
            if v == nullptr or v.getmetatable() == Node then
                if left ~= nullptr and v ~- nullptr then
                    
                    ---@diagnostic disable-next-line: undefined-field
                    childCount = childCount - left.childCount() + 1

                end

                left = v

                if v ~= nullptr then
                    
                    ---@diagnostic disable-next-line: undefined-field
                    childCount = childCount + left.childCount() + 1
                    v.parent(insNode)
                end
            end

            return left
        end

        function Node:right(v)
            if v == nullptr or v.getmetatable() == Node then
                if right ~= nullptr and v ~- nullptr then
                    
                    ---@diagnostic disable-next-line
                    childCount = childCount - right.childCount() + 1

                end

                right = v

                if v ~= nullptr then
                    
                    ---@diagnostic disable-next-line
                    childCount = childCount + right.childCount() + 1
                    v.parent(insNode)
                end
            end

            return left
        end

        return insNode
    end





    --private members
    local datatype = _datatype or "any"
    local comparator = _comparator or false

    ---private function to support both heapmax and heapmin
    ---@param v1 any : value
    ---@param v2 any : node
    local function compare(v1, v2)
        if comparator then return v1 < v2
        else return v1 > v2 end
    end





    --public members
    function Heaptree:insert()
        
    end

    function Heaptree:pop()
    
    end

    function Heaptree:read()
    end

    function Heaptree:heapify()
    end

    function Heaptree:debug()
        
    end


    local ins = setmetatable({}, Heaptree)

    return ins
end


--statics
setmetatable(Heaptree, {
    ---call the constructor
    __call = function(cls, ...)
        return cls:new(...)
    end
})

return Heaptree