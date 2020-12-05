local Log = {};

Log.filePath = "uimf_log.txt";
Log.fileReset = false;

--v function(str: string)
function Log.write(str)
    if write_log then
        Log.resetFileIfNeeded();
        local file = io.open(Log.filePath,"a+");
        file:write(str.."\n");
        file:close();
    end
end

function Log.resetFileIfNeeded()
    if not Log.fileReset then
        local file = io.open(Log.filePath,"w+");
        file:close();
        Log.fileReset = true;
    end
end

return {
    write = Log.write;
}