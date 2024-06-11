-- Function to encode a Lua table to JSON format
function Tabletostr(chat)
    local jsonString
    jsonString = "["
    for i = 1, #chat do
        local entry = '{ "role": "' .. chat[i].role .. '", "content": "' .. chat[i].content .. '" }'
        if i < #chat then
            jsonString = jsonString .. entry .. ", "
        else
            jsonString = jsonString .. entry
        end
    end
    jsonString = jsonString .. "]"
    return jsonString
end

function Tabletocontent(chat)
    local contentString
    contentString = ""
    for i = 2, #chat do
        local entry = chat[i].role .. ": " .. chat[i].content .. "\n"
        contentString = contentString .. entry
    end
    return contentString
end

local chat = { {
    role = "system",
    content = "You are ai. Your job is to assist the user in any way possible."
} }
print('hello world')

get("yap-input").on_submit(function(content)
    local userYap = {
        role = "user",
        content = content
    }
    table.insert(chat, userYap)

    -- fetch works out of the box --
    local res = fetch({
        url = "https://api.awanllm.com/v1/chat/completions",
        method = "POST",
        headers = {
            ["Authorization"] = "Bearer 9e256659-ee41-48bd-a7f3-736af779311b",
            ["Content-Type"] = "application/json",
        },
        body = '{"model":"Awanllm-Llama-3-8B-Dolfin","messages":' .. Tabletostr(chat) .. '}'
    })

    table.insert(chat, res['choices'][1]['message'])
    get("yap-out").set_content(Tabletocontent(chat))
    get("yap-input").set_content("")
end)
