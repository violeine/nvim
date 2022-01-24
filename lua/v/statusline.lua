local M = {}
local cond = require "heirline.conditions"
local utils = require "heirline.utils"
local icon = require "nvim-web-devicons"

local pal = {
  base = "#191724",
  surface = "#1f1d2e",
  overlay = "#26233a",
  muted = "#6e6a86",
  subtle = "#908caa",
  text = "#e0def4",
  love = "#eb6f92",
  gold = "#f6c177",
  rose = "#ebbcba",
  pine = "#31748f",
  foam = "#9ccfd8",
  iris = "#c4a7e7",
  highlight_low = "#21202e",
  highlight_med = "#403d52",
  highlight_high = "#524f67",
}

function M.setup()
  local Align = { provider = "%=" }
  local Space = { provider = " " }
  local Mode = {
    init = function(self)
      self.mode = vim.fn.mode(1)
      self.filename = vim.api.nvim_buf_get_name(0)
      self.ext = vim.fn.fnamemodify(self.filename, ":e")
      self.ft = vim.bo.filetype
      self.ftIcon = icon.get_icon(self.filename, self.ext, { default = true })
    end,

    static = {
      bg = {
        n = pal.rose,
        i = pal.foam,
        V = pal.iris,
        v = pal.iris,
        s = pal.iris,
        r = pal.love,
        R = pal.love,
        c = pal.gold,
      },
    },
    {
      provider = function()
        return ""
      end,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = self.bg[mode], bg = pal.surface }
      end,
    },
    {
      provider = function(self)
        if self.ft == "" then
          return string.format("%s %%2(%s%%)", self.ftIcon, "no ft")
        end
        return string.format(
          "%s %%2(%s%%)",
          self.ftIcon,
          self.ext == "" and self.ft or self.ext
        )
      end,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { bg = self.bg[mode], fg = pal.surface }
      end,
    },
    {
      provider = function()
        return ""
      end,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = self.bg[mode], bg = pal.surface }
      end,
    },
  }

  local FileNameComp = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
  }

  local FileName = {
    provider = function(self)
      local filename = vim.fn.fnamemodify(self.filename, ":.") -- :. only take relative to the current

      if filename == "" then
        return "[No Name]"
      end

      if not cond.width_percent_below(#filename, 0.25) then
        filename = vim.fn.pathshorten(filename)
      end
      return filename
    end,
    hl = { fg = pal.foam },
  }
  local FileFlags = {
    {
      provider = function()
        if vim.bo.modified then
          return "[+]"
        end
      end,
      hl = { fg = pal.rose },
    },
    {
      provider = function()
        if not vim.bo.modifiable or vim.bo.readonly then
          return ""
        end
      end,
      hl = { fg = pal.gold },
    },
  }

  local FileNameModifer = {
    hl = function()
      if vim.bo.modified then
        -- use `force` because we need to override the child's hl foreground
        return { fg = pal.rose, style = "bold", force = true }
      end
    end,
  }

  FileNameComp = utils.insert(
    FileNameComp,
    utils.insert(FileNameModifer, FileName, Space),
    unpack(FileFlags),
    { provider = "%<" }
  )
  local Git = {
    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
    end,
    provider = function(self)
      return string.format(" %s", self.status_dict.head)
    end,
    hl = {
      bg = pal.muted,
    },
  }

  Git = utils.surround({ "", "" }, pal.muted, Git)

  local Ruler = {
    provider = " %2p%% %3l:%-2v",
    hl = { fg = pal.muted },
  }

  local DefaultStatusline = {
    Mode,
    Space,
    FileNameComp,
    Align,
    Ruler,
    Space,
    { condition = cond.is_git_repo, Git },
  }

  local StatusLine = {
    hl = function()
      if cond.is_active() then
        return {
          fg = pal.text,
          bg = pal.surface,
        }
      else
        return {
          fg = pal.text,
          bg = pal.base,
        }
      end
    end,
    DefaultStatusline,
  }

  require("heirline").setup(StatusLine)
end

vim.cmd [[
augroup heirline
    autocmd!
    autocmd ColorScheme * lua require'heirline'.reset_highlights(); require'v.statusline'.setup()
augroup END
]]

M.setup()
return M
