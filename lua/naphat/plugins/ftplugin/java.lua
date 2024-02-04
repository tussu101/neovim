local capabilities = vim.lsp.protocol.make_client.capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local config = {
	cmd = {
		"java",
		"Declipse.application=org.eclipse.jdt.ls.core.id1",
		"Dosgi.bundles.defaultStartLevel=4",
		"Declipse.product=org.eclipse.jdt.ls.core.product",
		"Dlog.protocol=true",
		"Dlog.level=ALL",
		"Xmx1g",
		"jar",
		"/Library/Java/jdt-language-server-1.9.0-202203031534/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		"configuration",
		"/Library/Java/jdt-language-server-1.9.0-202203031534/config_mac",
		"data",
		vim.fn.expand("~/.cache/jdtls-workspace") .. workspace_dir,
	},

	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
	capabilities = capabilities,
}
require("jdtls").start_or_attach(config)
