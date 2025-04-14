local Queue = require("Queue")

local q = Queue()

print("insert: A")
q:insert("A")

print("insert: B")
q:insert("B")

print("insert: C")
q:insert("C")

print("insert: D")
q:insert("D")

print("Pop : "..q:pop())
print("Pop : "..q:pop())
print("Pop : "..q:pop())
print("Pop : "..q:pop())

print("insert: E")
q:insert("E")

print("insert: F")
q:insert("F")

print("insert: G")
q:insert("G")

print("insert: H")
q:insert("H")

print("Pop : "..q:pop())
print("Pop : "..q:pop())

print("insert: I")
q:insert("I")

print("insert: J")
q:insert("J")



print("burning...")
q = q:burn()

for k, v in pairs(q) do
    print(k,v)
end