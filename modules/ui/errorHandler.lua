DFRL:NewDefaults('Errors', {
    enabled = {true},
    hideErrors = {false, 'checkbox', nil, nil, '微调', 1, '隐藏所有 lua 错误', nil, nil},
})

DFRL:NewMod('Errors', 1, function()
    local originalHandler = geterrorhandler()

    local callbacks = {}

    callbacks.hideErrors = function(value)
        if value then
            seterrorhandler(function() end)
        else
            seterrorhandler(originalHandler)
        end
    end

    DFRL:NewCallbacks('Errors', callbacks)
end)
