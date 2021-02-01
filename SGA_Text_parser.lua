local SGA_Text_Parser = {}

letterArray = {}

letterWidth = {35fx, 40fx, 30fx, 45fx, 40fx, 35fx, 25fx, 40fx, 20fx, 30fx, 35fx, 30fx, 35fx, 35fx, 35fx, 35fx, 35fx, 35fx, 35fx, 35fx, 35fx, 40fx, 35fx, 35fx, 35fx, 35fx, 25fx}

function SGA_Text_Parser.parseString(string)
    local LetterTemplate = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
    local LetterIndexArray = {}
    for i = 1, #string do
        local letter = string.sub(string, i, i)
        for n = 1, #LetterTemplate do
            if letter == string.sub(LetterTemplate, n, n) then
                table.insert(LetterIndexArray, n)
            end
        end
        if i == #string then
            return LetterIndexArray
        end
    end
    return "Err"
end

function SGA_Text_Parser.displaySGA(x, y, scale, Text)
    if #Text == 1 then
        local parsedText = SGA_Text_Parser.parseString(Text)
        local entity = pewpew.new_customizable_entity(x, y)
        pewpew.customizable_entity_set_mesh_scale(entity, scale)
        table.insert(letterArray, entity)
        pewpew.customizable_entity_set_mesh(entity, "/dynamic/SGA_Letters.lua", parsedText[1])
        return "Letter Displayed: Letter: " .. Text .. " , EntityId: " .. entity .. " , ParsedTextId: " .. parsedText[1]
    elseif #Text > 1 then
        local parsedText = SGA_Text_Parser.parseString(Text)
        for i = 1, #Text do
            x = x - ((letterWidth[parsedText[i]] * scale) / 2fx)
        end
        for i = 1, #Text do
            local entity = pewpew.new_customizable_entity(x, y)
            pewpew.customizable_entity_set_mesh_scale(entity, scale)
            table.insert(letterArray, entity)
            if parsedText[i] == 27 then
                x = x + (25fx * scale)
            else
                pewpew.customizable_entity_set_mesh(entity, "/dynamic/SGA_Letters.lua", parsedText[i])
                x = x + (letterWidth[parsedText[i]] * scale)
            end
        end
        local output_message = "String Displayed: " .. Text .. " , EntityIds: ("
        for i = 1, #letterArray do
            output_message = output_message .. " " .. letterArray[i]
        end
        output_message = output_message .. ") , ParsedStringIds: ("
        for i = 1, #parsedText do
            output_message = output_message .. " " .. parsedText[i]
        end
        output_message = output_message .. ")"
        return output_message
    else
        return "String/Letter was not Displayed: Error, please Check your code and try again."
    end
end

function SGA_Text_Parser.disposeLetters(animationBool, animationTime)
    local animationBool = animationBool or false
    local animationTime = animationTime or 30
    if animationBool then
        for i = 1, #letterArray do
            pewpew.customizable_entity_start_exploding(letterArray[i], animationTime)
        end
        local output_message = "String/Letter was Disposed, with animation, EntityIds removed: ("
        for i = 1, #letterArray do
            output_message = output_message .. " " .. letterArray[i]
        end
        output_message = output_message .. ")"
        return output_message
    else
        for i = 1, #letterArray do
            pewpew.entity_destroy(letterArray[i])
        end
        local output_message = "String/Letter was Disposed, without animation, EntityIds removed: ("
        for i = 1, #letterArray do
            output_message = output_message .. " " .. letterArray[i]
        end
        output_message = output_message .. ")"
        return output_message
    end
    return "Letter(s) was(were) not Disposed: Error, please Check your code and try again."
end

return SGA_Text_Parser