local RoblocFunctions = {}

function RoblocFunctions:DoubleUnpack(target)
    local unpacked_target = unpack(target)
    return unpack(unpacked_target)
end

return RoblocFunctions
