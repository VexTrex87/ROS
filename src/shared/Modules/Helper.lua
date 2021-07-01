local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Helper = {}

function Helper.createElement(className, properties, subelement)
    assert(className, "Missing Parameter 1: className (string)")
    local newElement
    local success, errorMessage = pcall(function()
        newElement = Instance.new(className)
    end)
    assert(success, "Rovis Error: Unable to create element with the className (" .. className .. "). Error Message: " .. tostring(errorMessage))

    for propertyName, propertyValue in pairs(properties or {}) do
        assert(propertyName, "Rovis Error: Missing key (property name) for properties dictionary")
        assert(propertyName, "Rovis Error: Missing value (property value) for properties dictionary")

        success, errorMessage = pcall(function()
            newElement[propertyName] = propertyValue
        end)
        assert(success, "Rovis Error: Unable to set property value (" .. tostring(propertyValue) .. ") for property name (" .. tostring(propertyName) .. "). Error Message: " .. tostring(errorMessage))
    end

    for _, subelementInstance in pairs(subelement or {}) do
        subelementInstance.Parent = newElement
    end

    return newElement
end

function Helper.createUICorner(cornerRadius)
    return Helper.createElement("UICorner", {
        CornerRadius = cornerRadius
    })
end

function Helper.createTopRightButton(name, position, color)
    return Helper.createElement("ImageButton", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = color,
        Name = name,
        Position = position,
        Size = UDim2.new(0, 15, 0, 15),
    }, {
        CornerRadius = Helper.createUICorner(UDim.new(1, 0))
    })
end

function Helper.waitForPath(target, path, maxWait)
    local BAD_ARG_ERROR="%s is not a valid %s"

	assert(typeof(target) == "Instance", BAD_ARG_ERROR:format("Argument 1", "Instance"))
	assert(typeof(path) == "string", BAD_ARG_ERROR:format("Argument 2", "string"))
	if maxWait then
		assert(typeof(maxWait) == "number", BAD_ARG_ERROR:format("Argument 3", "number"))
	end

	local children = string.split(path,".")
	local currentChild
	local yieldDuration = tick()
	for _, segment in pairs(children) do
		currentChild = maxWait and target:WaitForChild(segment, yieldDuration + maxWait - tick()) or target:WaitForChild(segment)
		if currentChild then
			target = currentChild
		else
			return
		end
	end

	return currentChild
end

return Helper