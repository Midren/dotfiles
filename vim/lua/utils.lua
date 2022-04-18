local M={}

function M.tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function M.get_visual_selection()
    -- this will exit visual mode
    -- use 'gv' to reselect the text
    local _, csrow, cscol, cerow, cecol
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' or mode == '' then
      -- if we are in visual mode use the live position
      _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
      _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
      if mode == 'V' then
        -- visual line doesn't provide columns
        cscol, cecol = 0, 999
      end
      -- exit visual mode
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', true)
    else
      -- otherwise, use the last known visual position
      _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
      _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
    end
    -- swap vars if needed
    if cerow < csrow then csrow, cerow = cerow, csrow end
    if cecol < cscol then cscol, cecol = cecol, cscol end
    local lines = vim.fn.getline(csrow, cerow)
    -- local n = cerow-csrow+1
    local n = M.tablelength(lines)
    if n <= 0 then return '' end
    lines[n] = string.sub(lines[n], 1, cecol)
    lines[1] = string.sub(lines[1], cscol)
    return table.concat(lines, "\n")
end

function M.to_arglist()
    local arglist = vim.split(M.get_visual_selection(), ' ')

    local buf = vim.api.nvim_get_current_buf()
    local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))

    local res = ""
    for _, arg in ipairs(arglist) do
        if string.len(arg) > 0 then
                res = (res .. "\"" .. arg .. "\", ")
        end
    end

    local constructed_arg_list = string.sub(res:gsub("\n", ""), 1, -3)
    local st_line = string.sub(vim.api.nvim_buf_get_lines(buf, csrow-1, csrow, false)[1], 1, cscol-1)
    local en_line = string.sub(vim.api.nvim_buf_get_lines(buf, cerow-1, cerow, false)[1], cecol+1, -1)

    vim.api.nvim_buf_set_lines(buf, csrow-1, cerow, false, {st_line .. constructed_arg_list .. en_line})
end

function M.cmake_build()
  local job = require('cmake').build()
  job:after(vim.schedule_wrap(
    function(_, exit_code)
      if exit_code == 0 then
        vim.cmd([[cclose]])
      else
        vim.notify("Target build failed", vim.log.levels.ERROR, { title = 'CMake' })
      end
    end
  ))
end

return M
