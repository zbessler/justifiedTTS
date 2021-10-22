TOTAL_TURNS = 4
JOURNALISTS_DECK = '20d986'
STAFF_DECK = '2425e4'
SUPPORT_DECK = 'fde0ba'
DEADLINE_DECK = 'fd922e'
STORIES_DECK = 'f5b765'
EDITOR_DECK = '682634'
CURRENT_PLAYER = 1

COLOR_DATA = {
    pink = {
        color = 'Pink',
        start_area = 'a23c41',
        token_bag = 'ad6ab9',
        pass_location = { 3.89, 6.58, 0.07 },
        action_token = '64d0ee',
        editor_location = {20.73, 5.52, -4.85},
        action_zone = 'a1cae5',
        play_zone = '7f0555',
        dept_offset = Vector(0, 0, 0),
        number_token_locations = {
            {25.15, 7, -23.36},
            {25.13, 7, -24.31},
            {26.20, 7, -23.35},
            {26.20, 7, -24.33},
            {27.19, 7, -23.38},
            {27.21, 7, -24.33}
        },
        number_tokens = {
            'b1131d', 'cb8f1a', 'a0f6c5',
            'b6a70e', '608696', 'ef8b1f',
            '341dd4', '6cba70', 'f6af06',
            '35db40', '7c62b6', '373489',
            '328b8f', '76c2f4', 'b8cc93',
            '010a6a', 'd5f567', '960d3d',
        }
    },
    teal = {
        color = 'Teal',
        start_area = 'cd98c5',
        token_bag = 'dff7b5',
        pass_location = { 4.80, 6.58, 0.05 },
        action_token = 'c15df3',
        editor_location = {0.32, 5.47, -15.94},
        action_zone = '4d3500',
        play_zone = '9c83a6',
        dept_offset = Vector(0.5, 0, 0),
        number_token_locations = {
            {-8.20, 5.73, -24.59},
            {-9.22, 5.73, -24.58},
            {-10.29, 5.73, -24.58},
            {-8.23, 5.74, -23.64},
            {-9.22, 5.74, -23.61},
            {-10.27, 5.74, -23.62}
        },
        number_tokens = {
            '3f3a29', '59ccec', '4f940c',
            '4c50e4', '80107c', '8cbc87',
            '229648', 'c5220b', 'ee6e1d',
            '044859', '676133', 'e4142f',
            '4054e2', '63b7ef', '849482',
            '4de938', '0ae059', '4e7fbf',
        }
    },
    green = {
        color = 'Green',
        start_area = '5c5311',
        token_bag = 'd08d1e',
        pass_location = { 2.92, 6.58, 0.10 },
        action_token = '5582cc',
        editor_location = {-39.02, 5.47, -15.76},
        action_zone = '0e45f6',
        play_zone = 'efdfa6',
        dept_offset = Vector(0.65, 0, -0.39),
        number_token_locations = {
            {-19.88, 5.74, -23.35},
            {-20.87, 5.74, -23.33},
            {-21.92, 5.74, -23.33},
            {-19.85, 5.73, -24.30},
            {-20.86, 5.53, -24.29},
            {-21.94, 5.73, -24.28}
        },
        number_tokens = {
            '0f5d96', 'df5095', 'cfb84b',
            'b4e446', '118e3d', '410cfc',
            '61bd6a', '238088', '3a90d0',
            '1730b1', '4eaa2c', 'ed38a6',
            '4b7cff', '4ed979', '064f92',
            'c850c7', 'fb959d', '224a8c',
        }
    },
    yellow = {
        color = 'Yellow',
        start_area = '8647d9',
        token_bag = '043a22',
        pass_location = { 1.99, 6.58, 0.12 },
        action_token = '5daa16',
        editor_location = {-58.84, 5.53, -3.82},
        action_zone = '07280a',
        play_zone = '79d507',
        dept_offset = Vector(0.15, 0, -0.39),
        number_token_locations = {
            {-52.76, 5.74, -23.48},
            {-52.73, 5.73, -24.43},
            {-53.75, 5.73, -24.42},
            {-53.75, 5.74, -23.46},
            {-54.81, 5.74, -23.47},
            {-54.82, 5.73, -24.42}
        },
        number_tokens = {
            '625007', '1ee96d', '9eaee1',
            '9eaee1', '3c4775', 'f37764',
            'dfc40c', 'af9e04', 'a8a743',
            'c8e208', '96170b', 'e8a494',
            '44db67', 'd9259e', 'b1d189',
            '7918cf', 'b7fec3', '916722',
        }
    }
}

START_PLAYER_PAWN = '8a9c72'
TURN_TOKEN = '0d63ea'

JOURNALISTS_MARKET_ZONE = '415c5b'
STAFF_MARKET_ZONE = '76aead'
STAFF_DELETE_ZONE = '571f80'
SUPPORT_MARKET_ZONE = 'd9e40c'
SUPPORT_DELETE_ZONE = '53b518'

WEST_STORY_ZONES = {'3bfbbe', 'd49a13', 'ba3e24', 'db1c5c', 'e5aa28', 'eaad8f'}
CENTRAL_STORY_ZONES = {'f664e4', '7058c4', '3c0da6', '7a5114', 'ffd971', '01cf31'}
EAST_STORY_ZONES = {'7852af', '17a85f', '0fe121', 'c1a448', 'efdd93', 'f8bfb2'}


function dealJournalists()
    local zone = getObjectFromGUID(JOURNALISTS_MARKET_ZONE)
    for _, card in ipairs(zone.getObjects()) do
        if card.hasTag('journalist') then
            destroyObject(card)
        end
    end

    local deck = getObjectFromGUID(JOURNALISTS_DECK)
    for i = 1, #getSeatedPlayers() + 1 do
        deck.takeObject({flip = true, position = {12 + i * 2.7, 6, 10}})
    end
end

function onLoad()
end

function onUpdate()
end

-- Whenever a card leaves a deck, give it the same tags as that deck
function onObjectLeaveContainer(container, leave_object)
    if container.type == "Deck" then
     leave_object.setTags(container.getTags())
   end
 end




 -- Scoring functions


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