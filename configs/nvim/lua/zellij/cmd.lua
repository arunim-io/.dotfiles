local api = require("zellij.api")

---@class SubCommand
---@field impl fun(args: string[], opts: table)
---@field complete? fun(subcmd_arg_lead: string): string[]

---@type table<string, SubCommand>
local subcommands = {
  navigate = {
    impl = function(args)
      local direction = args[1]

      if not direction then
        vim.notify("Zellij navigate {direction}: Missing argument", vim.log.levels.ERROR)
      end

      api.move_focus(direction)
    end,
    complete = function(subcmd_arg_lead)
      local args = { "left", "right", "up", "down" }

      return vim
        .iter(args)
        :filter(function(arg)
          return arg:find(subcmd_arg_lead) ~= nil
        end)
        :totable()
    end,
  },
}

---@param opts table
local function cmd(opts)
  local fargs = opts.fargs
  local subcommand_key = fargs[1]
  local args = #fargs > 1 and vim.list_slice(fargs, 2, #fargs) or {}
  local subcommand = subcommands[subcommand_key]

  if not subcommand then
    vim.notify("zellij.nvim: Unknown command: " .. subcommand_key, vim.log.levels.ERROR)
  end

  subcommand.impl(args, opts)
end

local function create_nvim_cmd()
  vim.api.nvim_create_user_command("Zellij", cmd, {
    nargs = "+",
    bang = true,
    complete = function(arg_lead, cmdline, _)
      local subcmd_key, subcmd_arg_lead = cmdline:match("^['<,'>]*Zellij[!]*%s(%S+)%s(.*)$")

      if subcmd_key and subcmd_arg_lead and subcommands[subcmd_key] and subcommands[subcmd_key].complete then
        return subcommands[subcmd_key].complete(subcmd_arg_lead)
      end

      if cmdline:match("^['<,'>]*Zellij[!]*%s+%w*$") then
        local subcommand_keys = vim.tbl_keys(subcommands)

        return vim
          .iter(subcommand_keys)
          :filter(function(key)
            return key:find(arg_lead) ~= nil
          end)
          :totable()
      end
    end,
  })
end

return { create_nvim_cmd = create_nvim_cmd }
