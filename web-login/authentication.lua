local MINIMUM_PASSWORD_LENGTH = 6

local function isPasswordValid(password)
    return string.len(password) >= MINIMUM_PASSWORD_LENGTH
end

local function getPlayerInfo(username)
    local db = exports.db:getConnection()
    local query = dbQuery(db, 'SELECT * FROM accounts WHERE username = ?', username)
    local result = dbPoll(query, -1)

    return result and result[1] or false
end

local function spawnPlayerAfterAuth(player, x, y, z)
    spawnPlayer(player, x, y, z + 2)
    setCameraTarget(player, player)
end

-- create an account
addEvent('auth:register-attempt', true)
addEventHandler('auth:register-attempt', root, function(username, password)
    if not isPasswordValid(password) then
        return outputChatBox('The password supplied was not valid.', source, 255, 100, 100)
    end

    -- Check if account is existing
    local user = getPlayerInfo(username)
    if user then
        return outputChatBox('An account already exists with that name.', source, 255, 100, 100)
    end

    -- -- create a hash of the password
    local player = source
    passwordHash(password, 'bcrypt', {}, function(hashedPassword)
        -- create the account
        local db = exports.db:getConnection()
        local x = 0
        local y = 0
        local z = 2

        dbExec(db, 'INSERT INTO accounts (username, password, x, y, z) VALUES (?, ?, ?, ?, ?)', username,
            hashedPassword, x, y, z)
        setPlayerName(player, username)
        spawnPlayerAfterAuth(player, x, y, z)
        return triggerClientEvent(player, 'closeLogin', player)
    end)
end)

-- login to their account
addEvent('auth:login-attempt', true)
addEventHandler('auth:login-attempt', root, function(username, password)
    if not isPasswordValid(password) then
        return outputChatBox('The password supplied was not valid.', source, 255, 100, 100)
    end

    -- Check if account is existing
    local user = getPlayerInfo(username)
    if not user then
        return outputChatBox('This user is not found, please sign up first.', source, 255, 100, 100)
    end

    local player = source
    passwordVerify(password, user.password, function(isValid)
        if not isValid then
            return outputChatBox('The username or password is incorrect!', source, 255, 100, 100)
        end
        setPlayerName(player, username)
        spawnPlayerAfterAuth(player, user.x, user.y, user.z)
        return triggerClientEvent(player, 'closeLogin', player)
    end)
end)
