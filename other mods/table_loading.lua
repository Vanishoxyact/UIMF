function read_file(path)
    local configEnv = {}
    local f,err = loadfile(path);
    if f then
        --local local_env = getfenv(1);
        setfenv(f, configEnv);
        package.loaded[f] = true;
        f();
        output(configEnv.user4.id);
        return "found";
    else
        output(err);
        return "not found";
    end
end

local game_interface = cm:get_game_interface()

if not game_interface then
    output("no game_interface");
else
    local file_str_c = game_interface:filesystem_lookup("/script/campaign/mod/tables", "*.lua");
    output("files found:" .. file_str_c);


    if file_str_c ~= "" then
        for filename in string.gmatch(file_str_c, '([^,]+)') do
            output("filename:" .. filename);

            local current_file = filename;
            local pointer = 1;
            
            while true do
                local next_separator = string.find(current_file, "\\", pointer) or string.find(current_file, "/", pointer);
                
                if next_separator then
                    pointer = next_separator + 1;
                else
                    if pointer > 1 then
                        current_file = string.sub(current_file, pointer);
                    end
                    break;
                end
            end
            
            local suffix = string.sub(current_file, string.len(current_file) - 3);
            
            if string.lower(suffix) == ".lua" then
                current_file = string.sub(current_file, 1, string.len(current_file) - 4);
            end

            local fileContent2 = read_file("tables/" .. current_file);
            output(fileContent2);
		end
	end
end