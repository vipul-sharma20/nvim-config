function loadrequire(module)
    local function requiref(module)
        require(module)
    end
    res = pcall(requiref,module)
    if not(res) then
        print("Module doesn't exist: "..module)
    end
end

loadrequire("settings")
loadrequire("mappings")
loadrequire("plugins")
loadrequire("autogroups")
loadrequire("dev")
