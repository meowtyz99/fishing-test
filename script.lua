– Element Rod Luck Boost Script
– Script untuk testing map fishing game

local Players = game:GetService(“Players”)
local ReplicatedStorage = game:GetService(“ReplicatedStorage”)
local LocalPlayer = Players.LocalPlayer

– Konfigurasi
local TARGET_ROD = “Element rod” – Nama rod yang akan diberi boost
local LUCK_BOOST = 100000000 – 100 juta luck

– Fungsi untuk mencari rod di inventory
local function findRod(rodName)
local character = LocalPlayer.Character
if not character then return nil end

```
-- Cek di backpack
local backpack = LocalPlayer.Backpack
for _, item in pairs(backpack:GetChildren()) do
    if item.Name == rodName and item:IsA("Tool") then
        return item
    end
end

-- Cek di character (equipped)
for _, item in pairs(character:GetChildren()) do
    if item.Name == rodName and item:IsA("Tool") then
        return item
    end
end

return nil
```

end

– Fungsi untuk apply luck boost
local function applyLuckBoost()
local rod = findRod(TARGET_ROD)

```
if not rod then
    warn("Rod '" .. TARGET_ROD .. "' tidak ditemukan!")
    return false
end

-- Method 1: Modifikasi attributes
if rod:GetAttribute("Luck") then
    local currentLuck = rod:GetAttribute("Luck")
    rod:SetAttribute("Luck", currentLuck + LUCK_BOOST)
    print("✓ Luck boost applied via Attributes: +" .. LUCK_BOOST)
end

-- Method 2: Modifikasi values
local luckValue = rod:FindFirstChild("Luck") or rod:FindFirstChild("LuckValue")
if luckValue and (luckValue:IsA("NumberValue") or luckValue:IsA("IntValue")) then
    luckValue.Value = luckValue.Value + LUCK_BOOST
    print("✓ Luck boost applied via Value: +" .. LUCK_BOOST)
end

-- Method 3: Modifikasi configuration
local config = rod:FindFirstChild("Configuration") or rod:FindFirstChild("Config")
if config then
    local luckConfig = config:FindFirstChild("Luck")
    if luckConfig and (luckConfig:IsA("NumberValue") or luckConfig:IsA("IntValue")) then
        luckConfig.Value = luckConfig.Value + LUCK_BOOST
        print("✓ Luck boost applied via Config: +" .. LUCK_BOOST)
    end
end

return true
```

end

– Fungsi untuk monitor perubahan rod
local function setupRodMonitor()
local backpack = LocalPlayer.Backpack

```
-- Monitor ketika rod baru ditambahkan ke backpack
backpack.ChildAdded:Connect(function(item)
    if item.Name == TARGET_ROD and item:IsA("Tool") then
        wait(0.1) -- Delay sedikit untuk memastikan item sudah loaded
        applyLuckBoost()
    end
end)

-- Monitor ketika rod di-equip
LocalPlayer.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(function(item)
        if item.Name == TARGET_ROD and item:IsA("Tool") then
            wait(0.1)
            applyLuckBoost()
        end
    end)
end)
```

end

– Main execution
print(”===========================================”)
print(“Element Rod Luck Boost Script - AKTIF”)
print(“Target Rod: “ .. TARGET_ROD)
print(“Luck Boost: +” .. LUCK_BOOST)
print(”===========================================”)

– Apply boost pertama kali
local success = applyLuckBoost()

if success then
print(“✓ Script berhasil dijalankan!”)
else
print(“⚠ Rod belum ditemukan, script akan monitor rod…”)
end

– Setup monitor untuk rod yang akan datang
setupRodMonitor()

print(”===========================================”)
print(“Script akan otomatis apply boost saat”)
print(“rod ‘” .. TARGET_ROD .. “’ di-equip”)
print(”===========================================”)

– Notifikasi UI (opsional)
game:GetService(“StarterGui”):SetCore(“SendNotification”, {
Title = “Luck Boost Active”;
Text = “Element Rod: +100M Luck”;
Duration = 5;
})
