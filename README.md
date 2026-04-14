# 🌇 Sunset UI Library

A clean, modern, and customizable UI library for Roblox.

---

## 📥 Getting Started

Local library

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/doenteexploiter/sunsetlibary/refs/heads/main/sunset.lua"))()
```

---

## 🪟 Create Window

```lua
local win = Library:CreateWindow("Sunset UI", "assetid") -- asset id optional
```

---

## 📑 Tabs & Sections

```lua
local mainTab = win:CreateTab("Main")
local section = mainTab:AddSection("Player Info")
```

---

# 🔘 UI Elements

## 🔘 Button

```lua
section:AddButton("Click Me", function()
	print("Button clicked!")
end)
```

---

## 🔄 Toggle

```lua
section:AddToggle("Enable Feature", function(state)
	print("Toggle state:", state)
end)
```

---

## 🎚️ Slider

```lua
section:AddSlider("Volume", 0, 100, function(value)
	print("Slider value:", value)
end)
```

---

## 📂 Dropdown

```lua
section:AddDropdown("Choose Option", {"Option 1", "Option 2", "Option 3"}, function(selected)
	print("Selected:", selected)
end)
```

---

## 🏷️ Label

```lua
section:AddLabel("This is a label text")
```

---

## 💬 Discord Invite Button

```lua
section:AddDiscordInvite(
	"My Discord Server",
	"https://discord.gg/invite",
	"97939372251102"
)
```

---

## 🔥 Full Example

```lua
local settingsTab = win:CreateTab("Settings")
local settingsSection = settingsTab:AddSection("Adjustments")

settingsSection:AddButton("Click Me", function()
	print("Button clicked!")
end)

settingsSection:AddDropdown("Select an option", {"Option 1", "Option 2", "Option 3"}, function(selected)
	print("Selected:", selected)
end)

settingsSection:AddSlider("Volume", 0, 100, function(value)
	print("Volume:", value)
end)

settingsSection:AddToggle("Enable effect", function(state)
	print("Toggle:", state)
end)

settingsSection:AddLabel("This is an important message")
```

---

## 🎮 Features

* Modern UI design
* Draggable window and toggle button
* Tabs and sections system
* Button, Toggle, Slider, Dropdown, Label
* Discord invite component
* Notification system

---

## 📌 Notes

* Asset ID is optional in `CreateWindow`
* Discord invite button automatically copies the link (if supported)

---

## 👑 Credits

doente exploits/Mlk_doente70
