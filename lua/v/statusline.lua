local cond = require "heirline.conditions"
local utils = require "heirline.utils"

local pal = require "rose-pine.palette"
local Mode = {
  init = function(self)
    self.mode = vim.fn.mode(0)
  end,

  static = {
    mode_names = {
      n = "Normal",
      v = "Visual",
      V = "Visual",
      s = "Select",
      i = "Insert",
      R = "Replace",
      c = "Command",
    },
    colors = {
      n = pal.rose,
      i = pal.foam,
      V = pal.iris,
      v = pal.iris,
      s = pal.iris,
      R = pal.love,
      c = pal.gold,
    },
  },

  provider = function(self)
    return " %2(" .. self.mode_names[self.mode] .. "%)"
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = self.colors[mode], style = "bold" }
  end,
}

local FileNameComp = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local ext = vim.fn.fnamemodify(filename, ":e") -- :e take out the ext
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
      filename,
      ext,
      { default = true }
    )
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
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
    hl = { fg = pal.foam },
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
  FileIcon,
  utils.insert(FileNameModifer, FileName),
  unpack(FileFlags),
  { provider = "%<" }
)
local Align = { provider = "%=" }
local Space = { provider = " " }

Mode = utils.surround({ "", "" }, pal.surface, { Mode })

local DefaultStatusline = {
  Mode,
  Space,
  FileNameComp,
  Space,
  Space,
  Align,
}

require("heirline").setup(DefaultStatusline)
