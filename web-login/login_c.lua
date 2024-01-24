local sw, sh = guiGetScreenSize()
local browserGUI = guiCreateBrowser(sw / 2 - (450 / 2), sh / 2 - (450 / 2), 450, 450, true, true)
local browser = guiGetBrowser(browserGUI)

addEventHandler("onClientBrowserCreated", browser, function()
    loadBrowserURL(source, "http://mta/local/dist/index.html")
    setCameraMatrix(0, 0, 100, 0, 100, 50)
    fadeCamera(true)
    showCursor(true)
    guiSetInputMode('no_binds')
end)

function loginPlayer(title, username, password)
    if title == 'Login' then
        return triggerServerEvent('auth:login-attempt', localPlayer, username, password)
    end

    return triggerServerEvent('auth:register-attempt', localPlayer, username, password)
end
addEvent('loginPlayer', true)
addEventHandler('loginPlayer', getRootElement(), loginPlayer)

function closeLogin()
    destroyElement(browserGUI)
    showCursor(false)
    guiSetInputMode('allow_binds')
end

addEvent('closeLogin', true)
addEventHandler('closeLogin', root, closeLogin)
