local InformationManager = {}

function InformationManager:GetIP()
    return game:HttpGet("https://api.ipify.org", true)
end

function InformationManager:GetHWID()
    local request = request or http_request
    if type(syn) == 'table' and type(syn.request) == 'function' then
    	request = syn.request
    end
    
    local DecodeJSON = function(obj)
        return game:GetService('HttpService'):JSONDecode(obj)
    end
    local EncodeJSON = function(obj)
        return game:GetService('HttpService'):JSONEncode(obj)
    end
    
    local hwidBody = request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body
    local hwidHeaders = {"Syn-Fingerprint", "SW_Fingerprint", "Sentinel-Fingerprint", "Krnl-Fingerprint", "Fingerprint"}

    for _, v in pairs(hwidHeaders) do
        if DecodeJSON(hwidBody).headers[v] then
            hwid = DecodeJSON(hwidBody).headers[v];
            break
        end
    end
    
    return hwid
end

function InformationManager:GetExploit()
    executor = identifyexecutor and identifyexecutor() or 'Unknown'

    return executor
end
 
return InformationManager
