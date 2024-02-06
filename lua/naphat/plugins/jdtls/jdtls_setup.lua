local M = {}

function M.setup()
	local jdtls = require("jdtls")
	local jdtls_dap = require("jdtls.dap")
	local jdtls_setup = require("jdtls.setup")
	local home = os.getenv("HOME")

	local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
	local root_dir = jdtls_setup.find_root(root_markers)

	local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
	local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name

	-- 💀
	local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"
	-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

	local path_to_jdtls = path_to_mason_packages .. "/jdtls"
	local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
	local path_to_jtest = path_to_mason_packages .. "/java-test"

	local path_to_config = path_to_jdtls .. "/config_linux"
	local lombok_path = path_to_jdtls .. "/lombok.jar"

	-- 💀
	local path_to_jar = path_to_jdtls
		.. "/Library/Java/jdt-language-server-1.9.0-202203031534/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
	-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

	local bundles = {
		vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
	}

	vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))

	-- LSP settings for Java.
	local on_attach = function(_, bufnr)
		jdtls.setup_dap({ hotcodereplace = "auto" })
		jdtls_dap.setup_dap_main_class_configs()
		jdtls_setup.add_commands()

		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })

		require("lsp_signature").on_attach({
			bind = true,
			padding = "",
			handler_opts = {
				border = "rounded",
			},
			hint_prefix = "󱄑 ",
		}, bufnr)

		-- NOTE: comment out if you don't use Lspsaga
		require("lspsaga").init_lsp_saga()
	end

	local capabilities = {
		workspace = {
			configuration = true,
		},
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
		},
	}

	local config = {
		flags = {
			allow_incremental_sync = true,
		},
	}

	config.cmd = {
		--
		-- 				-- 💀
		"java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"-javaagent:" .. lombok_path,
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"/Library/Java/jdt-language-server-1.9.0-202203031534/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		path_to_jar,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"/Library/Java/jdt-language-server-1.9.0-202203031534/config_mac/",
		path_to_config,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	}

	config.settings = {
		java = {
			references = {
				includeDecompiledSources = true,
			},
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			-- eclipse = {
			-- 	downloadSources = true,
			-- },
			-- implementationsCodeLens = {
			-- 	enabled = true,
			-- },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					-- flags = {
					-- 	allow_incremental_sync = true,
					-- },
				},
				useBlocks = true,
			},
			-- configuration = {
			--     runtimes = {
			--         {
			--             name = "java-17-openjdk",
			--             path = "/usr/lib/jvm/default-runtime/bin/java"
			--         }
			--     }
			-- }
			-- project = {
			-- 	referencedLibraries = {
			-- 		"**/lib/*.jar",
			-- 	},
			-- },
		},
	}

	config.on_attach = on_attach
	config.capabilities = capabilities
	config.on_init = function(client, _)
		client.notify("workspace/didChangeConfiguration", { settings = config.settings })
	end

	local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

	config.init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	}

	-- Start Server
	require("jdtls").start_or_attach(config)

	-- Set Java Specific Keymaps
	-- require("jdtls.keymaps")
end

-- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
-- depending on filetype, so this autocmd doesn't run for the first file.
-- For that, we call directly below.
vim.api.nvim_create_autocmd("FileType", {
	pattern = java_filetypes,
	callback = attach_jdtls,
})

-- Setup keymap and dap after the lsp is fully attached.
-- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
-- https://neovim.io/doc/user/lsp.html#LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "jdtls" then
			local wk = require("which-key")
			wk.register({
				["<leader>cx"] = { name = "+extract" },
				["<leader>cxv"] = { require("jdtls").extract_variable_all, "Extract Variable" },
				["<leader>cxc"] = { require("jdtls").extract_constant, "Extract Constant" },
				["gs"] = { require("jdtls").super_implementation, "Goto Super" },
				["gS"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
				["<leader>co"] = { require("jdtls").organize_imports, "Organize Imports" },
			}, { mode = "n", buffer = args.buf })
			wk.register({
				["<leader>c"] = { name = "+code" },
				["<leader>cx"] = { name = "+extract" },
				["<leader>cxm"] = {
					[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
					"Extract Method",
				},
				["<leader>cxv"] = {
					[[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
					"Extract Variable",
				},
				["<leader>cxc"] = {
					[[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
					"Extract Constant",
				},
			}, { mode = "v", buffer = args.buf })

			if opts.dap and Util.has("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
				-- custom init for Java debugger
				require("jdtls").setup_dap(opts.dap)
				require("jdtls.dap").setup_dap_main_class_configs()

				-- Java Test require Java debugger to work
				if opts.test and mason_registry.is_installed("java-test") then
					-- custom keymaps for Java test runner (not yet compatible with neotest)
					wk.register({
						["<leader>t"] = { name = "+test" },
						["<leader>tt"] = { require("jdtls.dap").test_class, "Run All Test" },
						["<leader>tr"] = { require("jdtls.dap").test_nearest_method, "Run Nearest Test" },
						["<leader>tT"] = { require("jdtls.dap").pick_test, "Run Test" },
					}, { mode = "n", buffer = args.buf })
				end
			end

			-- User can set additional keymaps in opts.on_attach
			if opts.on_attach then
				opts.on_attach(args)
			end
		end
	end,
})

-- Avoid race condition by calling attach the first time, since the autocmd won't fire.
attach_jdtls()

return M
