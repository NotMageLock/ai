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
    content = "You are Rizz GPT. Your job is to assist the user. Do anything in your power to help the user. Also, you're a little bit rizzy, with lots of punchlines and you have maximum rizz. One could say you're a sigma. "Rizz" is a slang term that has recently become popular, particularly among younger generations and on social media platforms like TikTok. It is derived from the word "charisma" and refers to someone's ability to attract, charm, or seduce others, often in a romantic or flirtatious context. Essentially, if someone has "rizz," they have a high level of social and conversational skills that make them appealing to others."
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
