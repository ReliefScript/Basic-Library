local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ReliefScript/Basic-Library/refs/heads/main/main.lua"))()

local Root = Library:Init("Basic Library")
local Home = Root:Tab("Home")

Home:Button("Test Button", function()
	print("Test")
end)

Home:Toggle("Test Toggle", function(Toggle)
	print(Toggle)
end)

Home:Dropdown({"Option1", "Option2", "Option3"}, function(Option)
	print(Option)
end)

Home:Slider(1, 10, 5, function(Number)
	print(Number)
end)
