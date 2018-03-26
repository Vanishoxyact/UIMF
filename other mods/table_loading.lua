--v function(path: string) --> map<string, WHATEVER>
function read_file(path)
    local configEnv = {}
    local f,err = loadfile(path);
    if f then
        --local local_env = getfenv(1);
        setfenv(f, configEnv);
        package.loaded[f] = true;
        f();
        for i, v in pairs(configEnv) do
            output(tostring(i) .. " " .. tostring(v));
        end
        return configEnv;
    else
        output(err);
        return nil;
    end
end

--v function(completeTable: map<string, WHATEVER>) --> map<string, map<string, string>>
function convertDataIntoTable(completeTable)
    local schema = completeTable["SCHEMA"] --: vector<string>
    local keyIndex;
    for i, schemaEntry in ipairs(schema) do
        if schemaEntry == completeTable["KEY"] then
            keyIndex = i;
        end
    end
    output("FOUND KEY AT INDEX:" .. keyIndex);
    local data = completeTable["DATA"] --: vector<vector<string>>
    local dataTable = {} --: map<string, map<string, string>>
    for _, dataRow in ipairs(data) do
        local tableRow = {} --: map<string, string>
        local rowKey;
        for i, dataValue in ipairs(dataRow) do
            if i == keyIndex then
                rowKey = dataValue;
                output("ROW KEY:" .. rowKey);
            else
                tableRow[schema[i]] = dataValue;
            end
            dataTable[rowKey] = tableRow;
        end
    end
    return dataTable
end

local game_interface = cm:get_game_interface();

if not game_interface then
    output("no game_interface");
else
    output("STARTED LOADING TABLES");
    local file_str_c = game_interface:filesystem_lookup("/script/campaign/mod/tables", "*.lua");
    output("TABLE FILES FOUND:" .. file_str_c);

    local TABLES = {} --: map<string, map<string, map<string, string>>>
    if file_str_c ~= "" then
        for filename in string.gmatch(file_str_c, '([^,]+)') do
            output("LOADING TABLES FROM:" .. filename);

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

            local fileContent = read_file("tables/" .. current_file);
            for tableName, completeTable in pairs(fileContent) do
                output("LOADING TABLE:" .. tableName);
                local convertedTable = convertDataIntoTable(completeTable);
                TABLES[tableName] = convertedTable;
            end
		end
    end
    output("FINISHED LOADING TABLES");
    output(TABLES["TEST_DATA"]["One"]["value1"]);
    output(TABLES["TEST_DATA"]["One"]["value2"]);
    output(TABLES["TEST_DATA"]["Two"]["value1"]);
    output(TABLES["TEST_DATA"]["Two"]["value2"]);

    output(TABLES["CHARACTER_TRAIT_LEVELS"]["wh_dlc04_trait_name_dummy_the_grim"]["trait"]);
    _G.TABLES = TABLES;
end

--" -> \\\"
--(.*?)[\t\r] -> "$1", 
--(.*), \n -> {$1},\n