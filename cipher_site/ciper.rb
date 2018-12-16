require "sinatra"
#require "sinatra/reloader" if development?
@@str = ""
@@offset = 0
get "/" do
    @@str = params["input"]
    if @@str == nil
        @@str = ""
    end
    @@offset = params["cipher_num"].to_i
    ciphered_str = cipher(@@str,@@offset)
    erb :index, :locals => {:ciphered_str => ciphered_str}
end

def cipher(str,num)
    str_array = str.split("")
    ciphered_str = ""
    for char in str_array do
        if /[\w]/.match(char)
            num.times do
                char = char.next
            end
        end
        ciphered_str += char[-1]
    end
    return ciphered_str
end