local function hello()
  print("Hello world")
  return true
end

local function test()
  local result = hello()
  return result
end

return { hello = hello, test = test }
