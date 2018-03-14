local Console = {};

Console.enableLog = false;
Console.consoleMode = true;

Console.lines = {} --: vector<string>
Console.maxLines = 1000;
Console.filePath = "data/ui_log.txt";

--v function(str: string)
function Console.write(str)
    if Console.consoleMode then
        if #Console.lines > Console.maxLines then 
            table.remove(Console.lines, 1);
        end
        
        table.insert(Console.lines, str);

        local file = io.open(Console.filePath,"w+");
        for index, line in ipairs(Console.lines) do 
            file:write(line.."\n");
        end
        
        file:close();
    else
        local file = io.open(Console.filePath,"a+");
        file:write(str.."\n");
        file:close();
    end
end

return {
    write = Console.write;
}