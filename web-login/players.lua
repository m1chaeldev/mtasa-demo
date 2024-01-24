-- when a player joins run some code
setTime(12, 0)
setMinuteDuration(10000000000)

addCommandHandler('clearchat', function(player)
    for i = 1, 16 do
        outputChatBox(' ', player)
    end
end, false, false)

addEventHandler('onPlayerJoin', root, function()
end)

addEventHandler('onPlayerQuit', root, function()
    if type(source) == 'userdata' then
        local db = exports.db:getConnection()
        local x, y, z = getElementPosition(source)
        dbExec(db, 'UPDATE accounts SET x = ?, y = ?, z = ? WHERE username = ?', x, y, z, getPlayerName(source))
    end
end)
