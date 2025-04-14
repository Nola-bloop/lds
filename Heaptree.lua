---Author: Nola
---Heaptree
---made for Lua 5.1.5

--requirements
local Queue = require("Queue") --integrated in this package.


local nullptr = "nullptr" --I use this as a substitute for nullptr from c++. I needed a different thing from nil values.
local Heaptree = {}
Heaptree.__index = Heaptree

---Constructor of the Heaptree
---@param t table|string|nil : the type of the values. leave nil to avoid type checks (only leave nil if you know what you're doing)
---@param c boolean|nil : true = heapmax, false = heapmin (defautls to heapmin)
---@diagnostic disable-next-line
---@return Heaptree : a Heaptree object
function Heaptree.new(t, c)
    --node definition
    local Node = {} Node.__index = Node
    function Node.new(param_v, param_p)
        local insNode = setmetatable({}, Node)

        insNode.v = param_v or nil
        local left = nullptr
        local right = nullptr
        local childCount = 0
        local parent = param_p or nullptr


        function Node:childCount()
            return childCount
        end

        function Heaptree:refreshChildCount()
            childCount = 0
            if left ~= nullptr then
                ---@diagnostic disable-next-line: undefined-field
                childCount = childCount + left:childCount() + 1
            end
            if right ~= nullptr then
                ---@diagnostic disable-next-line: undefined-field
                childCount = childCount + right:childCount() + 1
            end
            if parent ~= nullptr then
                parent:refreshChildCount()
            end
        end

        function Node:parent(v)
            if v then
                if getmetatable(v) == Node then
                    parent = v
                elseif v == nullptr then
                    error("ERROR: You shouldn't need to remove the parent of a node. (Heaptree)")
                else
                    error("ERROR: You aren't allowed to put anything else than nodes in the parent value!")
                end
            end
            
            return parent
        end

        function Node:left(v)
            if v == nullptr or getmetatable(v) == Node then
                if left ~= nullptr and v ~= nullptr then
                    
                    ---@diagnostic disable-next-line: undefined-field
                    childCount = childCount - left:childCount() + 1

                end

                left = v

                if v ~= nullptr then
                    
                    ---@diagnostic disable-next-line: undefined-field
                    childCount = childCount + left:childCount() + 1
                    v:parent(insNode)
                end
            end

            return left
        end

        function Node:right(v)
            if v == nullptr or getmetatable(v) == Node then
                if right ~= nullptr and v ~= nullptr then
                    
                    ---@diagnostic disable-next-line
                    childCount = childCount - right:childCount() + 1

                end

                right = v

                if v ~= nullptr then
                    
                    ---@diagnostic disable-next-line
                    childCount = childCount + right:childCount() + 1
                    v:parent(insNode)
                end
            end

            return right
        end

        ---debug starting at a certain node.
        ---@param spaces string : indent
        function Node:debug(spaces)
            spaces = spaces or " "
            local out = spaces.."\n> "..self.v.." ("..childCount..")"
            if left ~= nullptr then out = out .. left:debug("  ") end
            if right ~= nullptr then out = out .. right:debug("  ") end
            
            return out
        end

        return insNode
    end





    --private members
    local _root = nullptr
    local _datatype = t or "any"
    local _comparator = c or false

    ---private function to support both heapmax and heapmin
    ---@param v1 any : value
    ---@param v2 any : node
    local function _compare(v1, v2)
        if _comparator then return v1 < v2
        else return v1 > v2 end
    end

    ---find where to insert a certain value.
    ---@param v any : the value to evaluate
    ---@return string|table : returns either nullptr or a node
    local function _findPotential(v)
        local it = _root
        if it == nullptr then return nullptr end

        while not _compare(v, it.v) do
            if it:left() == nullptr or it:right() == nullptr then
                break
            end

            local lGreater = not _compare(v, it:left().v)
            local rGreater = not _compare(v, it:right().v)

            if not lGreater and not rGreater then break end
            if lGreater and rGreater then
                if it:left():childCount() <= it:right():childCount() then
                    it = it:left()
                else
                    it = it:right()
                end
            elseif lGreater then
                it = it:left()
            else
                it = it:right()
            end
        end
        return it
    end

    ---bubble a value down the tree starting at ptr with the value in mem
    ---@param ptr any : pointer where to start
    ---@param mem any : value to bubble down
    local function _bubble(ptr, mem)
        if not _compare(mem, ptr.v) then
            local temp = ptr.v
            ptr.v = mem
            mem = temp
        end

        while ptr ~= nullptr do
            --if one of the children is empty, fill the blank
            if ptr:left() == nullptr then ptr:left(Node.new(mem,ptr)) break
            elseif ptr:right() == nullptr then ptr:right(Node.new(mem,ptr)) break
            end

            --find if a side needs to be favored because of the child count (if equal, go left)
            local childrenFavor = ptr:left():childCount() <= ptr:right():childCount()

            --I know by now that both children are not nullptr
            if childrenFavor then
                ptr = ptr:left()
            else
                ptr = ptr:right()
            end

            local temp = ptr.v
            ptr.v = mem
            mem = temp
        end
    end




    --public members
    ---Insert a value in the heaptree
    ---@param v any : MUST BE A COMPARABLE VALUE (and if you created your heaptree with type check, the value must be of the same type.)
    function Heaptree:insert(v)
        --if root is empty, set the root
        if _root == nullptr then
            _root = Node.new(v)
            return
        end

        --this is accessed when the value is greater than the root's value to bypass priority checks
        if not _compare(v, _root.v) then
            _bubble(_root, v)
            return
        end

        --find where to add
        local where = _findPotential(v)

        --if the potential has an empty child, then add the new node to it
        if where:left() == nullptr then
            where:left(Node.new(v, where))
        elseif where:right() == nullptr then
            where:right(Node.new(v, where))
        else
            _bubble(where,v)
        end
    end

    function Heaptree:pop()
        --to implement
    end

    function Heaptree:read()
        --to implement
    end

    function Heaptree:heapify()
        --to implement
    end

    function Heaptree:burn(keepHeap)
        --to implement
    end

    ---Get a string version of the content of the tree
    ---@param pretty boolean|nil : if false or nil, return the content in a straight line, else return a pretty version of the tree
    ---@return string
    function Heaptree:debug(pretty)
        if pretty then
            if _root ~= nullptr then return _root:debug() 
            else return "No data" end
        else
            local out = "No data   "
            local q = Queue()
            if _root ~= nullptr then q:insert(_root) out = "" end

            while not q:empty() do
                local node = q:read()

                if node:left()  ~= nullptr then q:insert(node:left())   end
                if node:right() ~= nullptr then q:insert(node:right())  end

                out = out..node.v.." ; "
            end
            return out:sub(1, out:len()-3)
        end
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