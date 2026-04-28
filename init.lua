function loadrequire(module)
    local ok, err = pcall(require, module)
    if not ok then
        vim.api.nvim_err_writeln(("Failed to load module %s: %s"):format(module, err))
        error(err)
    end
end

loadrequire("settings")
loadrequire("mappings")
loadrequire("plugins")
loadrequire("autogroups")
loadrequire("dev")
