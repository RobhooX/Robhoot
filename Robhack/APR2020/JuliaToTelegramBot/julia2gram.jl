#https://stackoverflow.com/questions/60661148/send-a-file-to-telegram-with-julia

import HTTP

r = HTTP.request("GET", "https://api.telegram.org/"; verbose=3)
println(r.status)
#println(String(r.body))


function sendDoc(chat, fileName::String)
    url = string(base_url, "https://api.telegram.org/")
    file = open(fileName)
    query = Dict("1065718228" => chat)
    HTTP.post(url, query=query; body=HTTP.Form(Dict("commit_test.txt" => file)))
    close(file)
end 
