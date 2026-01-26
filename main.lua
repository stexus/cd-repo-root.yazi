--- @since 25.5.31
local function run_command(command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	local status_table = { handle:close() }
	local status_code = status_table[3]
	if status_code == 0 then
		local destination = result:gsub("[\n\r]", "") .. "/"
		return destination
	else
		return nil
	end
end

local function get_repo_toplevel()
	local destination = run_command("sl root 2>&1")
	if destination then
		return destination
	end
	destination = run_command("git rev-parse --show-toplevel 2>&1")
	if destination then
		return destination
	end
	return nil
end

return {
	entry = function()
		local destination = get_repo_toplevel()
		ya.dbg(destination)
		if destination then
			local target = Url(destination)
			ya.emit("cd", { target })
		else
			ya.notify({
				title = "Could not change directory!",
				content = "You are not in a git or sapling repository.",
				timeout = 3,
				level = "error",
			})
		end
	end,
}
