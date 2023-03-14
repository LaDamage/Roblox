local NumberLibrary = {}

NumberLibrary.Prefixes = {"K","M","B","T","Qd","Qn","Sx","Sp","Oc","No",
	"De","UDe","DDe","TDe","QtDe","QnDe","SxDe","SpDe","OcDe","NoDe",
	"Vg","UVg","DVg","TVg","QdVg","QnVg","SxVg","SpVg","OcVg","NoVg",
	"Tg","UTg","DTg","TTg","QdTg","QnTg","SxTg","SpTg","OcTg","NoTg",
	"qg","Uqg","Dqg","Tqg","Qdqg","Qnqg","Sxqg","Spqg","Ocqg","Noqg",
	"Qg","UQg","DQg","TQg","QdQg","QnQg","SxQg","SpQg","OcQg","NoQg",
	"sg","Usg","Dsg","Tsg","Qdsg","Qnsg","Sxsg","Spsg","Ocsg","Nosg",
	"Sg","USg","DSg","TSg","QdSg","QnSg","SxSg","SpSg","OcSg","NoSg",
	"Og","UOg","DOg","TOg","QdOg","QnOg","SxOg","SpOg","OcOg","NoOg",
	"Ng","UNg","DNg","TNg","QdNg","QnNg","SxNg","SpNg","OcNg","NoNg",
	"Ce"}


function NumberLibrary.CutDigits(x)
	if x - math.floor(x) == 0 then return x end
	return string.format("%.2f", x)
end

function NumberLibrary.Comma(value)
	value = tostring(value)
	return value:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

function NumberLibrary.Decimal(value, decimals)
	return tonumber(string.format("%." .. (decimals) .. "f", value))
end

function NumberLibrary.Abbreviate(number, digits)
	if number == 0 then return number end
	if number < 1 then return NumberLibrary.CutDigits(number) end
	
	number = (number < 0 and math.abs(number)) or number
	digits = digits or 2
	
	local suffix = math.floor(math.log10(number)/3)
	
	return NumberLibrary.CutDigits(number / 1000^(suffix)) .. ( NumberLibrary.Prefixes[math.floor(suffix)] or "")
end

function NumberLibrary.TimeFlow(val)
	if not tonumber(val) then return val end

	local days = math.floor(val / 86400)
	val = val - days * 86400

	local hours = math.floor(val / 3600)
	val = val - hours * 3600

	local mins = math.floor(val / 60)
	val = val - mins * 60

	val = val > 0 and " " .. math.floor(val) .. "s" or ""
	return (days > 0 and days .. "d" or "") .. (hours > 0 and " " .. hours .. "h" or "") .. (mins > 0 and " " .. mins .. "m" or "") .. val
end

return NumberLibrary
