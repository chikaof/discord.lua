local logger = {}

function logger:log(...) 
    print("[LOG] ", ...)
end

function logger:warn(...) 
    print("[WARN] ", ...)
end

function logger:fatal(...) 
    print("[FATAL] ", ...)
end

function logger:success(...) 
    print("[YAY] ", ...)
end

return logger