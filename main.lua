-- Services
local function Service(Name)
	return cloneref(game:GetService(Name))
end

local CoreGui = Service("CoreGui")
local TweenService = Service("TweenService")
local UserInputService = Service("UserInputService")
local Players = Service("Players")

-- Variables & Functions
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local function Center(Inst)
	Inst.AnchorPoint = Vector2.new(0.5, 0.5)
	Inst.Position = UDim2.new(0.5, 0, 0.5, 0)
end

local function CenterX(Inst)
	Inst.AnchorPoint = Vector2.new(0.5, 0)
	Inst.Position = UDim2.new(0.5, 0, 0, 0)
end

local function CenterY(Inst)
	Inst.AnchorPoint = Vector2.new(0, 0.5)
	Inst.Position = UDim2.new(0, 0, 0.5, 0)
end

local function Pad(Inst)
	local Padding = Instance.new("UIPadding")
	Padding.Parent = Inst

	local Tree = {}

	function Tree:A(X, Y)
		X = X or 0
		Y = Y or 0
		Padding.PaddingLeft = UDim.new(X, Y)
		Padding.PaddingRight = UDim.new(X, Y)
		Padding.PaddingTop = UDim.new(X, Y)
		Padding.PaddingBottom = UDim.new(X, Y)
		return Tree
	end

	function Tree:L(X, Y)
		Padding.PaddingLeft = UDim.new(X or 0, Y or 0)
		return Tree
	end

	function Tree:R(X, Y)
		Padding.PaddingRight = UDim.new(X or 0, Y or 0)
		return Tree
	end

	function Tree:T(X, Y)
		Padding.PaddingTop = UDim.new(X or 0, Y or 0)
		return Tree
	end

	function Tree:B(X, Y)
		Padding.PaddingBottom = UDim.new(X or 0, Y or 0)
		return Tree
	end

	return Tree
end

local function TextDefault(Inst)
	Inst.BackgroundTransparency = 1
	Inst.TextColor3 = Color3.new(1, 1, 1)
	Inst.TextScaled = true
	Inst.Font = Enum.Font.GothamBlack
end

local function Stroke(Inst)
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Parent = Inst
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

local function Ratio(Inst, X)
	local Ratio = Instance.new("UIAspectRatioConstraint")
	Ratio.Parent = Inst
	Ratio.AspectRatio = X or 1
end

-- Ui
local Screen = Instance.new("ScreenGui")
Screen.Parent = CoreGui
Screen.ResetOnSpawn = false
Screen.DisplayOrder = 1e6

local Frame = Instance.new("Frame")
Frame.Parent = Screen
Frame.Size = UDim2.new(0.3375, 0, 0.4125, 0)
Frame.BorderSizePixel = 0
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Frame.Active = true
Frame.Draggable = true
Center(Frame)
Ratio(Frame, 1.75)

local TabHolder = Instance.new("ScrollingFrame")
TabHolder.Parent = Frame
TabHolder.Size = UDim2.new(0.2, 0, 0.7, 0)
TabHolder.Position = UDim2.new(0, 0, 0.2, 0)
TabHolder.BackgroundTransparency = 1
TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)

local Layout = Instance.new("UIListLayout")
Layout.Parent = TabHolder

local Divider = Instance.new("Frame")
Divider.Parent = Frame
Divider.Size = UDim2.new(0.005, 0, 0.7, 0)
Divider.Position = UDim2.new(0.2, 0, 0.2, 0)
Divider.BorderSizePixel = 0
Divider.BackgroundColor3 = Color3.new(0, 0, 0)
Divider.BackgroundTransparency = 0.85

-- Module
local Library = {}

function Library:Init(Title)
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Parent = Frame
	TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Text = Title or "Basic Library"
	TextDefault(TitleLabel)
	Pad(TitleLabel):L(0.02):T(0.1):B(0.1)

	local Root = {}
	local Tabs = {}

	local function SelectTab(Query)
		for Name, TabFrame in Tabs do
			TabFrame.Visible = Name == Query
		end
	end

	local SelectedTab = false
	function Root:Tab(Name)
		local TabButton = Instance.new("TextButton")
		TabButton.Parent = TabHolder
		TabButton.Text = Name
		TabButton.Size = UDim2.new(1, 0, 0.12, 0)
		TabButton.TextTransparency = 0.2
		TabButton.AutoButtonColor = false
		Pad(TabButton):A(0.1)
		TextDefault(TabButton)

		local TabFrame = Instance.new("ScrollingFrame")
		TabFrame.Parent = Frame
		TabFrame.Size = UDim2.new(0.8, 0, 0.7, 0)
		TabFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
		TabFrame.BackgroundTransparency = 1
		TabFrame.Visible = not SelectedTab
		TabFrame.ClipsDescendants = true
		TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

		local Layout = Instance.new("UIListLayout")
		Layout.Parent = TabFrame
		Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		TabButton.MouseEnter:Connect(function()
			TabButton.TextTransparency = 0.6
		end)

		TabButton.MouseLeave:Connect(function()
			TabButton.TextTransparency = 0.2
		end)

		TabButton.MouseButton1Down:Connect(function()
			SelectTab(Name)
		end)

		Tabs[Name] = TabFrame

		local Tab = {}

		function Tab:Button(Text, Callback)
			local ButtonFrame = Instance.new("Frame")
			ButtonFrame.Parent = TabFrame
			ButtonFrame.BackgroundTransparency = 1
			ButtonFrame.Size = UDim2.new(0.8, 0, 0.2, 0)

			local Button = Instance.new("TextButton")
			Button.Parent = ButtonFrame
			TextDefault(Button)
			Button.Size = UDim2.new(1, 0, 0.7, 0)
			Button.BackgroundTransparency = 0.8
			Button.BackgroundColor3 = Color3.new(0, 0, 0)
			Button.Text = Text
			Pad(Button):A(0.1)
			Center(Button)

			Button.MouseEnter:Connect(function()
				Button.BackgroundTransparency = 0.7
			end)

			Button.MouseLeave:Connect(function()
				Button.BackgroundTransparency = 0.8
			end)

			Button.MouseButton1Down:Connect(function()
				task.spawn(Callback)
			end)
		end

		function Tab:Toggle(Text, Callback)
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Parent = TabFrame
			ToggleFrame.BackgroundTransparency = 1
			ToggleFrame.Size = UDim2.new(0.8, 0, 0.2, 0)

			local Title = Instance.new("TextLabel")
			Title.Parent = ToggleFrame
			Title.Size = UDim2.new(0.7, 0, 0.5, 0)
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.Text = Text
			CenterY(Title)
			TextDefault(Title)

			local ToggleButtonFrame = Instance.new("Frame")
			ToggleButtonFrame.Parent = ToggleFrame
			ToggleButtonFrame.Size = UDim2.new(0.2, 0, 0.5, 0)
			ToggleButtonFrame.BorderSizePixel = 0
			CenterY(ToggleButtonFrame)
			ToggleButtonFrame.Position = UDim2.new(0.75, 0, 0.5, 0)
			ToggleButtonFrame.BackgroundColor3 = Color3.new(1, 0, 0)
			Stroke(ToggleButtonFrame)

			local LeftBar = Instance.new("Frame")
			LeftBar.Parent = ToggleButtonFrame
			LeftBar.BackgroundColor3 = Color3.new(0, 1, 0)
			LeftBar.BorderSizePixel = 0
			LeftBar.Size = UDim2.new(0, 0, 1, 0)

			local ToggleButton = Instance.new("TextButton")
			ToggleButton.Parent = ToggleButtonFrame
			ToggleButton.Size = UDim2.new(0.35, 0, 1, 0)
			ToggleButton.BorderSizePixel = 0
			ToggleButton.Text = ""
			ToggleButton.BackgroundColor3 = Color3.new(1, 1, 1)
			ToggleButton.AutoButtonColor = false
			Stroke(ToggleButton)

			local Info = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			local Toggle = false

			ToggleButton.MouseButton1Down:Connect(function()
				Toggle = not Toggle
				task.spawn(Callback, Toggle)

				if Toggle then
					TweenService:Create(ToggleButton, Info, {Position = UDim2.new(0.65, 0, 0, 0)}):Play()
					TweenService:Create(LeftBar, Info, {Size = UDim2.new(0.65, 0, 1, 0)}):Play()
				else
					TweenService:Create(ToggleButton, Info, {Position = UDim2.new(0, 0, 0, 0)}):Play()
					TweenService:Create(LeftBar, Info, {Size = UDim2.new(0, 0, 1, 0)}):Play()
				end
			end)
		end

		function Tab:Dropdown(Options, Callback)
			local DropdownFrame = Instance.new("Frame")
			DropdownFrame.Parent = TabFrame
			DropdownFrame.BackgroundTransparency = 1
			DropdownFrame.Size = UDim2.new(0.8, 0, 0.2, 0)

			local Dropdown = Instance.new("TextButton")
			Dropdown.Parent = DropdownFrame
			Dropdown.Size = UDim2.new(1, 0, 0.6, 0)
			Dropdown.Text = Options[1]
			Dropdown.BorderSizePixel = 0
			Center(Dropdown)
			TextDefault(Dropdown)
			Pad(Dropdown):A(0.1)
			Dropdown.BackgroundTransparency = 0.5
			Dropdown.BackgroundColor3 = Color3.new(0, 0, 0)

			local OptionTable = {}
			for _, Option in Options do
				local Clone = Dropdown:Clone()
				Clone.Parent = DropdownFrame
				Clone.Position = UDim2.new(0.5, 0, 0.5 + (_ * 0.6), 0)
				Clone.Visible = false
				Clone.Text = Option
				table.insert(OptionTable, Clone)

				Clone.MouseButton1Down:Connect(function()
					Dropdown.Text = Option
					task.spawn(Callback, Option)
					for _, Option in OptionTable do
						Option.Visible = false
					end
				end)
			end

			Dropdown.MouseButton1Down:Connect(function()
				for _, Option in OptionTable do
					Option.Visible = not Option.Visible
				end
			end)
		end

		function Tab:Slider(Name, Min, Max, Default, Callback)
			local SliderFrame = Instance.new("Frame")
			SliderFrame.Parent = TabFrame
			SliderFrame.BackgroundTransparency = 1
			SliderFrame.Size = UDim2.new(0.8, 0, 0.2, 0)

			local Bar = Instance.new("Frame")
			Bar.Parent = SliderFrame
			Bar.Size = UDim2.new(0.5, 0, 0.1, 0)
			Bar.BorderSizePixel = 0
			Bar.BackgroundColor3 = Color3.new(0, 0, 0)
			Bar.BackgroundTransparency = 0.8
			Center(Bar)

			local Button = Instance.new("TextButton")
			Button.Parent = Bar
			Button.Size = UDim2.new(1, 0, 2.5, 0)
			Button.BorderSizePixel = 0
			Button.BackgroundColor3 = Color3.new(1, 1, 1)
			Button.Text = ""
			Ratio(Button)
			Stroke(Button)
			Center(Button)

			local Display = Instance.new("TextLabel")
			Display.Parent = SliderFrame
			Display.TextStrokeTransparency = 0
			Display.Size = UDim2.new(1, 0, 0.3, 0)
			TextDefault(Display)
			CenterX(Display)

			local Dragging = false

			Button.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
				end
			end)

			Button.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(Input)
				if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
					local MouseX = math.clamp(Mouse.X - Bar.AbsolutePosition.X, 0, Bar.AbsoluteSize.X)
					local Value = Min + (MouseX / Bar.AbsoluteSize.X) * (Max - Min)
					Value = math.floor(Value * 100) / 100
					Display.Text = `{Name} > {Value}`
					local RelativePos = (Value - Min) / (Max - Min)
					Button.Position = UDim2.new(RelativePos, 0, 0.5, 0)
					task.spawn(Callback, Value)
				end
			end)

			Display.Text = `{Name} > {Default}`
			Button.Position = UDim2.new(Default / Max, 0, 0.5, 0)
		end

		SelectedTab = true
		return Tab
	end

	return Root
end
