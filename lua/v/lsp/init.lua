local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("v.lsp.lsp-installer")
require("v.lsp.handlers").setup()
