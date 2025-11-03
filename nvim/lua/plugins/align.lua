return {
    vim.keymap.set("v", "aa", function()
        -- ask for delimiter (default '=')
        local char = vim.fn.input("Align on char (default '='): ")
        if char == "" then char = "=" end

        -- simple trims
        local function ltrim(s) return s:match("^%s*(.*)$") end
        local function rtrim(s) return s:match("^(.-)%s*$") end

        -- obtain a safe selection range (1-based lines)
        local function get_selection_range()
            -- primary method
            local s_line = vim.fn.line("'<")
            local e_line = vim.fn.line("'>")

            -- fallback to buffer marks if primary returned 0 (sometimes happens)
            if (not s_line or s_line == 0) or (not e_line or e_line == 0) then
            local s_mark = vim.api.nvim_buf_get_mark(0, "<")
            local e_mark = vim.api.nvim_buf_get_mark(0, ">")
            if s_mark and #s_mark >= 1 then s_line = s_mark[1] end
            if e_mark and #e_mark >= 1 then e_line = e_mark[1] end
            end

            -- final sanity defaults/clamping
            local last = vim.api.nvim_buf_line_count(0)
            if not s_line or s_line < 1 then s_line = 1 end
            if not e_line or e_line < 1 then e_line = last end
            if s_line > last then s_line = last end
            if e_line > last then e_line = last end

            -- ensure start <= end
            if s_line > e_line then s_line, e_line = e_line, s_line end

            return s_line, e_line
        end

        local ok, s_line, e_line = pcall(get_selection_range)
        if not ok or not s_line or not e_line then
            vim.notify("Could not determine visual selection range — aborting align.", vim.log.levels.WARN)
            return
        end

        -- safety check: final sanity
        if s_line > e_line then
            vim.notify(("Invalid selection range: %d > %d"):format(s_line, e_line), vim.log.levels.WARN)
            return
        end

        -- fetch lines (end index for nvim_buf_get_lines is exclusive)
        local raw_lines = vim.api.nvim_buf_get_lines(0, s_line - 1, e_line, false)

        -- parse and compute max left width (preserve indent)
        local parts = {}
        local maxleft = 0
        for _, line in ipairs(raw_lines) do
            local indent = line:match("^[ \t]*") or ""
            local content = line:sub(#indent + 1)

            local idx = content:find(char, 1, true) -- literal find
            if idx then
            local raw_left  = content:sub(1, idx - 1)
            local raw_right = content:sub(idx + #char)
            local left  = rtrim(raw_left)
            local right = ltrim(raw_right)
            table.insert(parts, { indent = indent, left = left, right = right, has = true })
            if #left > maxleft then maxleft = #left end
            else
            table.insert(parts, { indent = indent, left = content, right = nil, has = false })
            end
        end

        -- build new lines
        local new_lines = {}
        for _, p in ipairs(parts) do
            if not p.has then
            table.insert(new_lines, p.indent .. p.left)
            else
            local pad_fmt = "%s%-" .. tostring(maxleft) .. "s %s %s"
            table.insert(new_lines, string.format(pad_fmt, p.indent, p.left, char, p.right))
            end
        end

        -- final replace (nvim_buf_set_lines end index is exclusive -> e_line is correct)
        local ok2, err = pcall(vim.api.nvim_buf_set_lines, 0, s_line - 1, e_line, false, new_lines)
        if not ok2 then
            vim.notify("Failed to set lines: " .. tostring(err), vim.log.levels.ERROR)
        end
    end, { desc = "Align selected lines on a character (robust, preserves indent)" })
}