local ok, reload = pcall(require, "plenary.reload")
RELOAD = ok and reload.reload_module or function(...)
  return ...
end
function R(name)
  RELOAD(name)
  return require(name)
end

------------------------------------------------------------------------
-- Plugin Configurations
------------------------------------------------------------------------
R "v.options"
R "v.keymaps"
R "v.plugins"
R "v.cmp"
R "v.lsp"
R "v.telescope"
R "v.treesitter"
R "v.pairs"
R "v.statusline"
