--- @since 25.5.31

local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

-- Walk up from `url` until a directory containing `.git` is found.
-- `.git` is a directory in a regular checkout, but a *file* (`gitdir: ...`)
-- in linked worktrees and submodules, so accept either: this way a worktree
-- resolves to its own root instead of the directory holding all worktrees.
local function find_repo_root(url)
	while url do
		if fs.cha(url:join(".git"), false) then
			return url
		end
		url = url.parent
	end
	return nil
end

return {
	entry = function()
		local root = find_repo_root(Url(get_cwd()))
		if root then
			ya.emit("cd", { root })
		else
			ya.notify({
				title = "Could not change directory!",
				content = "You are not in a git repository.",
				timeout = 3,
				level = "error",
			})
		end
	end,
}
