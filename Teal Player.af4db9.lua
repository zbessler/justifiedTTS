-- Global Variables
Scores = {}
RowsAdded = 1
ColumnsAdded = 1

function onLoad(saved_data)
    RowsAdded     = 4
    ColumnsAdded  = 1
end

function IncrementScore(player, value, id)
    local scoreId = string.sub(id, 3)
    local score = tonumber(self.UI.getAttribute(scoreId, "text"))

    self.UI.setAttribute(scoreId, "text", tonumber(score)+1)

    local modifier = tonumber(self.UI.getAttribute(scoreId .. "_calc", "value"))
    if modifier != nil then
        self.UI.setAttribute(scoreId .. "_calc", "text", (tonumber(score)+1) * modifier)
    end

    Wait.frames(UpdateTotalScore, 5)
end

function DecrementScore(player, value, id)
    local scoreId = string.sub(id, 3)
    local score = tonumber(self.UI.getAttribute(scoreId, "text"))
    self.UI.setAttribute(scoreId, "text", tonumber(score)-1)

    local modifier = tonumber(self.UI.getAttribute(scoreId .. "_calc", "value"))
    if modifier != nil then
        self.UI.setAttribute(scoreId .. "_calc", "text", (tonumber(score)-1) * modifier)
    end

    Wait.frames(UpdateTotalScore, 5)
end

function UpdateTotalScore()
    local unique = tonumber(self.UI.getAttribute("uniqueValue_calc", "text"))
    local rainbow = tonumber(self.UI.getAttribute("rainbowValue_calc", "text"))
    local mono = tonumber(self.UI.getAttribute("monoValue_calc", "text"))
    local complete = tonumber(self.UI.getAttribute("completedValue_calc", "text"))
    local blank = tonumber(self.UI.getAttribute("blanksValue_calc", "text"))
    local editor = tonumber(self.UI.getAttribute("editorValue_calc", "text"))
    local deadline = tonumber(self.UI.getAttribute("deadlineValue", "text"))
    local relv = tonumber(self.UI.getAttribute("relvValue", "text"))
    local dept = tonumber(self.UI.getAttribute("deptValue", "text"))

    self.UI.setAttribute(
        "totalValue",
        "text",
        unique + rainbow + mono + complete + blank + editor + deadline + relv + dept )

end