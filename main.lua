--- @since 25.5.31
local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

local function dir_exists(path)
	local f = io.open(path .. "/.", "r")
	if f then
		f:close()
		return true
	end
	return false
end

local function get_repo_toplevel()
	local path = get_cwd()

	while path and path ~= "" do
		if dir_exists(path .. "/.hg") or dir_exists(path .. "/.git") then
			return path .. "/"
		end
		local parent = path:match("(.+)/[^/]+$")
		if not parent then
			break
		end
		path = parent
	end

	return nil
end

return {
	entry = function()
		local destination = get_repo_toplevel()
		if destination then
			ya.emit("cd", { Url(destination) })
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
