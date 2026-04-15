local Library = {}
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

function Library:CreateWindow(title)
	local gui = Instance.new("ScreenGui")
	gui.Parent = player:WaitForChild("PlayerGui")
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false

	local currentColor = Color3.fromRGB(255, 128, 0)
	local toggleButton = nil
	local toggleButtonSize = 40
	local mainFrame = nil
	local sidebarFrame = nil
	local titleLabel = nil
	local contentFrame = nil

	-- Função para atualizar todas as cores do tema
	local function updateThemeColor(newColor)
		currentColor = newColor
		if mainFrame and mainFrame:FindFirstChild("UIStroke") then
			mainFrame.UIStroke.Color = currentColor
		end
		if sidebarFrame and sidebarFrame:FindFirstChild("UIStroke") then
			sidebarFrame.UIStroke.Color = currentColor
		end
		if titleLabel then
			titleLabel.TextColor3 = currentColor
		end
		if toggleButton then
			toggleButton.BackgroundColor3 = currentColor
		end
		for _, tab in ipairs(contentFrame:GetChildren()) do
			if tab:IsA("ScrollingFrame") then
				tab.ScrollBarImageColor3 = currentColor
			end
		end
	end

	-- Função para atualizar o tamanho do botão toggle
	local function updateToggleButtonSize(newSize)
		toggleButtonSize = newSize
		if toggleButton then
			toggleButton.Size = UDim2.new(0, newSize, 0, newSize)
			toggleButton.Position = UDim2.new(0, 10, 0.5, -(newSize / 2))
		end
	end

	-- Função de notificação
	local function Notify(titulo, texto, duracao)
		pcall(function()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = titulo,
				Text = texto,
				Duration = duracao or 5,
			})
		end)
	end

	-- Tela de loading
	local Login = Instance.new("Frame")
	Login.Size = UDim2.new(1, 0, 1, 0)
	Login.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Login.BackgroundTransparency = 0.5
	Login.Parent = gui

	local loginText = Instance.new("TextLabel")
	loginText.Size = UDim2.new(1, 0, 1, 0)
	loginText.Text = "Loading..."
	loginText.TextColor3 = currentColor
	loginText.BackgroundTransparency = 1
	loginText.TextScaled = true
	loginText.Parent = Login

	task.wait(2)
	Login:Destroy()

	local notified = false

	-- BOTÃO TOGGLE
	toggleButton = Instance.new("ImageButton")
	toggleButton.Size = UDim2.new(0, toggleButtonSize, 0, toggleButtonSize)
	toggleButton.Position = UDim2.new(0, 10, 0.5, -(toggleButtonSize / 2))
	toggleButton.BackgroundColor3 = currentColor
	toggleButton.Image = "rbxassetid://97939372251102"
	toggleButton.Parent = gui
	Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)

	local draggingBtn, dragStartBtn, startPosBtn
	toggleButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingBtn = true
			dragStartBtn = input.Position
			startPosBtn = toggleButton.Position
		end
	end)
	toggleButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingBtn = false
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if draggingBtn and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
			local delta = input.Position - dragStartBtn
			toggleButton.Position = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y)
		end
	end)

	-- MAIN FRAME
	mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 450, 0, 380)
	mainFrame.Position = UDim2.new(0.5, -225, 0.5, -190)
	mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	mainFrame.BackgroundTransparency = 0.2
	mainFrame.Parent = gui
	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

	local draggingMain, dragStart, startPos
	mainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingMain = true
			dragStart = input.Position
			startPos = mainFrame.Position
		end
	end)
	mainFrame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingMain = false
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if draggingMain and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
			local delta = input.Position - dragStart
			mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	local strokeMain = Instance.new("UIStroke")
	strokeMain.Color = currentColor
	strokeMain.Thickness = 1
	strokeMain.Parent = mainFrame

	-- SIDEBAR
	sidebarFrame = Instance.new("Frame")
	sidebarFrame.Size = UDim2.new(0, 90, 1, 0)
	sidebarFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	sidebarFrame.BackgroundTransparency = 0.2
	sidebarFrame.Parent = mainFrame
	Instance.new("UICorner", sidebarFrame).CornerRadius = UDim.new(0, 8)

	local strokeSidebar = Instance.new("UIStroke")
	strokeSidebar.Color = currentColor
	strokeSidebar.Parent = sidebarFrame

	titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, 0, 0, 30)
	titleLabel.Text = title
	titleLabel.TextColor3 = currentColor
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextSize = 14
	titleLabel.Font = Enum.Font.BuilderSans
	titleLabel.Parent = sidebarFrame

	contentFrame = Instance.new("Frame")
	contentFrame.Size = UDim2.new(1, -90, 1, 0)
	contentFrame.Position = UDim2.new(0, 90, 0, 0)
	contentFrame.BackgroundTransparency = 1
	contentFrame.Parent = mainFrame

	local currentTab
	local tabY = 35

	-- FUNÇÕES DA JANELA
	local windowFunctions = {}

	function windowFunctions:CreateTab(name)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -10, 0, 28)
		btn.Position = UDim2.new(0, 5, 0, tabY)
		btn.Text = name
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		btn.TextColor3 = currentColor
		btn.Font = Enum.Font.BuilderSans
		btn.TextSize = 12
		btn.Parent = sidebarFrame
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
		tabY = tabY + 33

		local Tab = Instance.new("ScrollingFrame")
		Tab.Size = UDim2.new(1, 0, 1, 0)
		Tab.Visible = false
		Tab.Parent = contentFrame
		Tab.ScrollBarThickness = 4
		Tab.ScrollBarImageColor3 = currentColor
		Tab.BackgroundTransparency = 1
		Tab.BorderSizePixel = 0
		Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
		Tab.ScrollingEnabled = true
		Tab.AutomaticCanvasSize = Enum.AutomaticSize.Y

		local layout = Instance.new("UIListLayout", Tab)
		layout.Padding = UDim.new(0, 8)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		btn.MouseButton1Click:Connect(function()
			for _, child in ipairs(sidebarFrame:GetChildren()) do
				if child:IsA("TextButton") then
					child.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					child.TextColor3 = currentColor
				end
			end
			btn.BackgroundColor3 = currentColor
			btn.TextColor3 = Color3.fromRGB(0, 0, 0)
			if currentTab then currentTab.Visible = false end
			currentTab = Tab
			Tab.Visible = true
		end)

		local Elements = {}

		function Elements:AddSection(sectionTitle)
			local Section = {}

			local sectionFrame = Instance.new("Frame")
			sectionFrame.Size = UDim2.new(1, -12, 0, 0)
			sectionFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			sectionFrame.BackgroundTransparency = 0.3
			sectionFrame.Parent = Tab
			sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
			Instance.new("UICorner", sectionFrame).CornerRadius = UDim.new(0, 6)

			local stroke = Instance.new("UIStroke", sectionFrame)
			stroke.Color = currentColor
			stroke.Thickness = 1

			local sectionLayout = Instance.new("UIListLayout", sectionFrame)
			sectionLayout.Padding = UDim.new(0, 4)

			local titleLabelSection = Instance.new("TextLabel")
			titleLabelSection.Size = UDim2.new(1, 0, 0, 22)
			titleLabelSection.Text = "  " .. sectionTitle
			titleLabelSection.BackgroundTransparency = 1
			titleLabelSection.TextColor3 = currentColor
			titleLabelSection.TextSize = 12
			titleLabelSection.Font = Enum.Font.BuilderSans
			titleLabelSection.TextXAlignment = Enum.TextXAlignment.Left
			titleLabelSection.Parent = sectionFrame

			local container = Instance.new("Frame")
			container.Size = UDim2.new(1, 0, 0, 0)
			container.BackgroundTransparency = 1
			container.Parent = sectionFrame
			container.AutomaticSize = Enum.AutomaticSize.Y

			local clayout = Instance.new("UIListLayout", container)
			clayout.Padding = UDim.new(0, 6)
			clayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

			-- ========== TEXTBOX FUNCIONAL ==========
			function Section:AddTextBox(placeholder, callback)
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, -12, 0, 55)
				frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				frame.Parent = container
				Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)

				local stroke = Instance.new("UIStroke", frame)
				stroke.Color = currentColor
				stroke.Thickness = 1

				local textBox = Instance.new("TextBox")
				textBox.Size = UDim2.new(1, -20, 0, 30)
				textBox.Position = UDim2.new(0, 10, 0, 8)
				textBox.PlaceholderText = placeholder or "Digite algo..."
				textBox.Text = ""
				textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				textBox.Font = Enum.Font.BuilderSans
				textBox.TextSize = 12
				textBox.Parent = frame
				Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 4)
				textBox.ClearTextOnFocus = false

				local submitBtn = Instance.new("TextButton")
				submitBtn.Size = UDim2.new(0, 60, 0, 28)
				submitBtn.Position = UDim2.new(1, -70, 0, 8)
				submitBtn.Text = "Enviar"
				submitBtn.BackgroundColor3 = currentColor
				submitBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
				submitBtn.Font = Enum.Font.BuilderSans
				submitBtn.TextSize = 11
				submitBtn.Parent = frame
				Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 4)

				submitBtn.MouseButton1Click:Connect(function()
					if textBox.Text ~= "" then
						callback(textBox.Text)
						Notify("TextBox", "Enviado: " .. textBox.Text, 2)
					end
				end)

				textBox.FocusLost:Connect(function(enterPressed)
					if enterPressed and textBox.Text ~= "" then
						callback(textBox.Text)
						Notify("TextBox", "Enviado: " .. textBox.Text, 2)
					end
				end)

				return frame
			end

			-- ========== FUNÇÃO RETRATO (Imagem do personagem) ==========
			function Section:AddRetrato()
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, -12, 0, 100)
				frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				frame.Parent = container
				Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

				local stroke = Instance.new("UIStroke", frame)
				stroke.Color = currentColor
				stroke.Thickness = 1

				local titleLabel = Instance.new("TextLabel")
				titleLabel.Size = UDim2.new(1, 0, 0, 22)
				titleLabel.Position = UDim2.new(0, 0, 0, 5)
				titleLabel.Text = "🎭 Seu Personagem"
				titleLabel.BackgroundTransparency = 1
				titleLabel.TextColor3 = currentColor
				titleLabel.TextSize = 11
				titleLabel.Font = Enum.Font.BuilderSans
				titleLabel.TextXAlignment = Enum.TextXAlignment.Center
				titleLabel.Parent = frame

				local characterImage = Instance.new("ImageLabel")
				characterImage.Size = UDim2.new(0, 65, 0, 65)
				characterImage.Position = UDim2.new(0.5, -32.5, 0, 28)
				characterImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				characterImage.Parent = frame
				Instance.new("UICorner", characterImage).CornerRadius = UDim.new(1, 0)

				-- Carrega a imagem do personagem
				local userId = player.UserId
				local content, isReady = game:GetService("Players"):GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				
				if isReady then
					characterImage.Image = content
				else
					characterImage.Image = "rbxassetid://6031093672"
				end

				local nameLabel = Instance.new("TextLabel")
				nameLabel.Size = UDim2.new(1, 0, 0, 20)
				nameLabel.Position = UDim2.new(0, 0, 1, -22)
				nameLabel.Text = player.Name
				nameLabel.BackgroundTransparency = 1
				nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				nameLabel.TextSize = 11
				nameLabel.Font = Enum.Font.BuilderSans
				nameLabel.TextXAlignment = Enum.TextXAlignment.Center
				nameLabel.Parent = frame

				return frame
			end

			-- ========== FUNÇÃO NOME DO JOGO ==========
			function Section:AddGameName()
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, -12, 0, 55)
				frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				frame.Parent = container
				Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

				local stroke = Instance.new("UIStroke", frame)
				stroke.Color = currentColor
				stroke.Thickness = 1

				local icon = Instance.new("ImageLabel")
				icon.Size = UDim2.new(0, 40, 0, 40)
				icon.Position = UDim2.new(0, 10, 0.5, -20)
				icon.BackgroundTransparency = 1
				icon.Image = "rbxassetid://6031093672"
				icon.Parent = frame
				Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)

				local titleLabel = Instance.new("TextLabel")
				titleLabel.Size = UDim2.new(1, -70, 0, 18)
				titleLabel.Position = UDim2.new(0, 60, 0, 8)
				titleLabel.Text = "🎮 Nome do Jogo"
				titleLabel.BackgroundTransparency = 1
				titleLabel.TextColor3 = currentColor
				titleLabel.TextSize = 11
				titleLabel.Font = Enum.Font.BuilderSans
				titleLabel.TextXAlignment = Enum.TextXAlignment.Left
				titleLabel.Parent = frame

				local gameNameLabel = Instance.new("TextLabel")
				gameNameLabel.Size = UDim2.new(1, -70, 0, 22)
				gameNameLabel.Position = UDim2.new(0, 60, 0, 26)
				gameNameLabel.BackgroundTransparency = 1
				gameNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				gameNameLabel.TextSize = 12
				gameNameLabel.Font = Enum.Font.BuilderSansBold
				gameNameLabel.TextXAlignment = Enum.TextXAlignment.Left
				gameNameLabel.Parent = frame

				local function updateGameName()
					local success, result = pcall(function()
						return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
					end)
					
					if success and result then
						gameNameLabel.Text = result
					else
						gameNameLabel.Text = "Carregando..."
					end
				end

				updateGameName()

				local copyBtn = Instance.new("TextButton")
				copyBtn.Size = UDim2.new(0, 50, 0, 22)
				copyBtn.Position = UDim2.new(1, -60, 1, -28)
				copyBtn.Text = "Copiar"
				copyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				copyBtn.TextColor3 = currentColor
				copyBtn.Font = Enum.Font.BuilderSans
				copyBtn.TextSize = 10
				copyBtn.Parent = frame
				Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 4)

				copyBtn.MouseButton1Click:Connect(function()
					setclipboard(gameNameLabel.Text)
					Notify("Game Name", "Nome do jogo copiado: " .. gameNameLabel.Text, 2)
				end)

				return frame
			end

			-- LABEL
			function Section:AddLabel(text)
				local l = Instance.new("TextLabel")
				l.Size = UDim2.new(1, -12, 0, 20)
				l.Text = text
				l.BackgroundTransparency = 1
				l.TextColor3 = Color3.fromRGB(200, 200, 200)
				l.Font = Enum.Font.BuilderSans
				l.TextSize = 11
				l.Parent = container
				return l
			end

			-- BUTTON
			function Section:AddButton(text, callback)
				local b = Instance.new("TextButton")
				b.Size = UDim2.new(1, -12, 0, 32)
				b.Text = text
				b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				b.TextColor3 = currentColor
				b.Font = Enum.Font.BuilderSans
				b.TextSize = 12
				b.Parent = container
				Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
				b.MouseButton1Click:Connect(callback)
				return b
			end

			-- NAME PLAYER
			function Section:AddNamePlayer()
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, -12, 0, 65)
				frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				frame.Parent = container
				Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

				local stroke = Instance.new("UIStroke", frame)
				stroke.Color = currentColor
				stroke.Thickness = 1

				local nameLabel = Instance.new("TextLabel")
				nameLabel.Size = UDim2.new(1, -20, 0, 28)
				nameLabel.Position = UDim2.new(0, 10, 0, 5)
				nameLabel.Text = "👤 " .. player.Name
				nameLabel.BackgroundTransparency = 1
				nameLabel.TextColor3 = currentColor
				nameLabel.TextSize = 12
				nameLabel.Font = Enum.Font.BuilderSans
				nameLabel.TextXAlignment = Enum.TextXAlignment.Left
				nameLabel.Parent = frame

				local copyBtn = Instance.new("TextButton")
				copyBtn.Size = UDim2.new(1, -20, 0, 24)
				copyBtn.Position = UDim2.new(0, 10, 0, 35)
				copyBtn.Text = "📋 Copiar Nome"
				copyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				copyBtn.TextColor3 = currentColor
				copyBtn.Font = Enum.Font.BuilderSans
				copyBtn.TextSize = 11
				copyBtn.Parent = frame
				Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 4)

				copyBtn.MouseButton1Click:Connect(function()
					setclipboard(player.Name)
					Notify("Copiado!", "Nome copiado: " .. player.Name, 2)
				end)

				return frame
			end

			-- PLAYERS SERVER
			function Section:AddPlayersServer()
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, -12, 0, 65)
				frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				frame.Parent = container
				Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

				local stroke = Instance.new("UIStroke", frame)
				stroke.Color = currentColor
				stroke.Thickness = 1

				local playersCount = Instance.new("TextLabel")
				playersCount.Size = UDim2.new(1, -20, 0, 28)
				playersCount.Position = UDim2.new(0, 10, 0, 5)
				playersCount.Text = "👥 Players: " .. #Players:GetPlayers()
				playersCount.BackgroundTransparency = 1
				playersCount.TextColor3 = currentColor
				playersCount.TextSize = 12
				playersCount.Font = Enum.Font.BuilderSans
				playersCount.TextXAlignment = Enum.TextXAlignment.Left
				playersCount.Parent = frame

				local refreshBtn = Instance.new("TextButton")
				refreshBtn.Size = UDim2.new(1, -20, 0, 24)
				refreshBtn.Position = UDim2.new(0, 10, 0, 35)
				refreshBtn.Text = "🔄 Atualizar"
				refreshBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				refreshBtn.TextColor3 = currentColor
				refreshBtn.Font = Enum.Font.BuilderSans
				refreshBtn.TextSize = 11
				refreshBtn.Parent = frame
				Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 4)

				local function updateCount()
					playersCount.Text = "👥 Players: " .. #Players:GetPlayers()
				end

				refreshBtn.MouseButton1Click:Connect(updateCount)
				Players.PlayerAdded:Connect(updateCount)
				Players.PlayerRemoving:Connect(updateCount)

				return frame
			end

			-- DISCORD INVITE
			function Section:AddDiscordInvite(serverName, inviteLink, imageAssetId)
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, -12, 0, 100)
				frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				frame.Parent = container
				Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

				local stroke = Instance.new("UIStroke", frame)
				stroke.Color = currentColor
				stroke.Thickness = 1

				if imageAssetId then
					local image = Instance.new("ImageLabel")
					image.Size = UDim2.new(0, 50, 0, 50)
					image.Position = UDim2.new(0, 10, 0, 10)
					image.Image = "rbxassetid://" .. imageAssetId
					image.BackgroundTransparency = 1
					image.Parent = frame
					Instance.new("UICorner", image).CornerRadius = UDim.new(1, 0)
				end

				local nameLabel = Instance.new("TextLabel")
				nameLabel.Size = UDim2.new(1, -85, 0, 28)
				nameLabel.Position = UDim2.new(0, 70, 0, 8)
				nameLabel.Text = serverName
				nameLabel.BackgroundTransparency = 1
				nameLabel.TextColor3 = currentColor
				nameLabel.TextSize = 12
				nameLabel.Font = Enum.Font.BuilderSans
				nameLabel.TextXAlignment = Enum.TextXAlignment.Left
				nameLabel.Parent = frame

				local inviteText = Instance.new("TextLabel")
				inviteText.Size = UDim2.new(1, -85, 0, 20)
				inviteText.Position = UDim2.new(0, 70, 0, 36)
				inviteText.Text = inviteLink
				inviteText.BackgroundTransparency = 1
				inviteText.TextColor3 = Color3.fromRGB(150, 150, 150)
				inviteText.TextXAlignment = Enum.TextXAlignment.Left
				inviteText.TextSize = 9
				inviteText.Font = Enum.Font.BuilderSans
				inviteText.Parent = frame

				local joinBtn = Instance.new("TextButton")
				joinBtn.Size = UDim2.new(0, 75, 0, 30)
				joinBtn.Position = UDim2.new(1, -85, 1, -38)
				joinBtn.Text = "JOIN"
				joinBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
				joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
				joinBtn.Font = Enum.Font.BuilderSans
				joinBtn.TextSize = 11
				joinBtn.Parent = frame
				Instance.new("UICorner", joinBtn).CornerRadius = UDim.new(0, 4)

				joinBtn.MouseButton1Click:Connect(function()
					setclipboard(inviteLink)
					Notify("Discord Invite", "Link copiado: " .. inviteLink, 3)
				end)

				return frame
			end

			-- ========== DROPDOWN CORRIGIDO ==========
			function Section:AddDropdown(text, options, callback)
				local open = false
				local dropdownFrame = nil

				local main = Instance.new("TextButton")
				main.Size = UDim2.new(1, -12, 0, 32)
				main.Text = text
				main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				main.TextColor3 = currentColor
				main.Font = Enum.Font.BuilderSans
				main.TextSize = 12
				main.Parent = container
				Instance.new("UICorner", main).CornerRadius = UDim.new(0, 4)

				-- Container para o dropdown
				local dropdownContainer = Instance.new("Frame")
				dropdownContainer.Size = UDim2.new(1, -12, 0, 0)
				dropdownContainer.BackgroundTransparency = 1
				dropdownContainer.ClipsDescendants = false
				dropdownContainer.Parent = container
				dropdownContainer.ZIndex = 10

				local list = Instance.new("Frame")
				list.Size = UDim2.new(1, 0, 0, 0)
				list.ClipsDescendants = true
				list.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				list.Parent = dropdownContainer
				list.BorderSizePixel = 0
				list.ZIndex = 10
				Instance.new("UICorner", list).CornerRadius = UDim.new(0, 4)

				local listLayout = Instance.new("UIListLayout", list)
				listLayout.Padding = UDim.new(0, 2)

				local buttons = {}
				for i, v in ipairs(options) do
					local opt = Instance.new("TextButton")
					opt.Size = UDim2.new(1, 0, 0, 28)
					opt.Text = v
					opt.BackgroundTransparency = 1
					opt.TextColor3 = currentColor
					opt.Font = Enum.Font.BuilderSans
					opt.TextSize = 11
					opt.Parent = list
					opt.ZIndex = 10
					
					opt.MouseButton1Click:Connect(function()
						main.Text = v
						open = false
						list.Size = UDim2.new(1, 0, 0, 0)
						dropdownContainer.Size = UDim2.new(1, -12, 0, 0)
						callback(v)
					end)
					buttons[i] = opt
				end

				main.MouseButton1Click:Connect(function()
					open = not open
					if open then
						local totalHeight = #options * 30
						list.Size = UDim2.new(1, 0, 0, totalHeight)
						dropdownContainer.Size = UDim2.new(1, -12, 0, totalHeight)
						dropdownContainer.Position = UDim2.new(0, 0, 0, 36)
					else
						list.Size = UDim2.new(1, 0, 0, 0)
						dropdownContainer.Size = UDim2.new(1, -12, 0, 0)
					end
				end)

				return main
			end

			-- TOGGLE
			function Section:AddToggle(text, callback)
				local state = false

				local f = Instance.new("Frame")
				f.Size = UDim2.new(1, -12, 0, 36)
				f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				f.Parent = container
				Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1, -55, 1, 0)
				label.Position = UDim2.new(0, 10, 0, 0)
				label.Text = text
				label.BackgroundTransparency = 1
				label.TextColor3 = currentColor
				label.Font = Enum.Font.BuilderSans
				label.TextSize = 12
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = f

				local toggle = Instance.new("Frame")
				toggle.Size = UDim2.new(0, 40, 0, 20)
				toggle.Position = UDim2.new(1, -50, 0.5, -10)
				toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				toggle.Parent = f
				Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

				local circle = Instance.new("Frame")
				circle.Size = UDim2.new(0, 16, 0, 16)
				circle.Position = UDim2.new(0, 2, 0.5, -8)
				circle.BackgroundColor3 = currentColor
				circle.Parent = toggle
				Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

				f.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
						state = not state
						local bgColor = state and currentColor or Color3.fromRGB(50, 50, 50)
						TweenService:Create(toggle, TweenInfo.new(0.2), { BackgroundColor3 = bgColor }):Play()
						TweenService:Create(circle, TweenInfo.new(0.2), {
							Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
						}):Play()
						callback(state)
					end
				end)

				return f
			end

			-- SLIDER
			function Section:AddSlider(text, min, max, callback)
				local value = min
				local dragging = false

				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, -12, 0, 55)
				frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				frame.Parent = container
				Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1, -10, 0, 20)
				label.Position = UDim2.new(0, 5, 0, 5)
				label.Text = text .. " (" .. value .. ")"
				label.BackgroundTransparency = 1
				label.TextColor3 = currentColor
				label.Font = Enum.Font.BuilderSans
				label.TextSize = 11
				label.Parent = frame

				local bar = Instance.new("Frame")
				bar.Size = UDim2.new(1, -20, 0, 5)
				bar.Position = UDim2.new(0, 10, 1, -15)
				bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				bar.Parent = frame
				Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

				local fill = Instance.new("Frame")
				fill.Size = UDim2.new(0, 0, 1, 0)
				fill.BackgroundColor3 = currentColor
				fill.Parent = bar
				Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

				local function update(input)
					local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
					fill.Size = UDim2.new(pos, 0, 1, 0)
					value = math.floor(min + (max - min) * pos)
					label.Text = text .. " (" .. value .. ")"
					callback(value)
				end

				bar.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						update(input)
					end
				end)

				UIS.InputChanged:Connect(function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
						update(input)
					end
				end)

				UIS.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)

				return frame
			end

			return Section
		end

		return Elements
	end

	-- FUNÇÕES DE CONFIGURAÇÃO DA JANELA
	function windowFunctions:SetThemeColor(color)
		updateThemeColor(color)
	end

	function windowFunctions:SetToggleIcon(iconAssetId)
		if toggleButton then
			toggleButton.Image = "rbxassetid://" .. iconAssetId
		end
	end

	function windowFunctions:SetToggleColor(color)
		if toggleButton then
			toggleButton.BackgroundColor3 = color
		end
	end

	function windowFunctions:SetToggleSize(size)
		updateToggleButtonSize(size)
	end

	function windowFunctions:ConfigureToggle(iconAssetId, color, size)
		if iconAssetId then self:SetToggleIcon(iconAssetId) end
		if color then self:SetToggleColor(color) end
		if size then self:SetToggleSize(size) end
	end

	function windowFunctions:Notify(titulo, texto, duracao)
		Notify(titulo, texto, duracao)
	end

	-- Abrir/fechar
	local open = true
	toggleButton.MouseButton1Click:Connect(function()
		open = not open
		mainFrame.Visible = open
		if open and not notified then
			Notify("Welcome Sunset 🌞", "Thank you for using Sunset UI library 🌞", 5)
			notified = true
		end
	end)

	-- Abrir primeira aba automaticamente
	task.wait(0.1)
	for _, btn in ipairs(sidebarFrame:GetChildren()) do
		if btn:IsA("TextButton") then
			btn.MouseButton1Click:Fire()
			break
		end
	end

	return windowFunctions
end

return Library
