return {

	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                             ┏━┳┳━┳━┳┓╋┏┳━━┳━┳━┓                              ",
				"                             ┃┃┃┃┳┫┃┃┗┳┛┣┃┃┫┃┃┃┃                              ",
				"                             ┃┃┃┃┻┫┃┣┓┃┏╋┃┃┫┃┃┃┃                              ",
				"                             ┗┻━┻━┻━┛┗━┛┗━━┻┻━┻┛                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
				"                                                                              ",
			}

			-- dashboard.section.header.val = {
			-- 	"                                                                              ",
			-- 	"                                   ██████                                     ",
			-- 	"                               ████▒▒▒▒▒▒████                                 ",
			-- 	"                             ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                               ",
			-- 	"                           ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                             ",
			-- 	"                         ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                               ",
			-- 	"                         ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                           ",
			-- 	"                         ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                           ",
			-- 	"                       ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                         ",
			-- 	"                       ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                         ",
			-- 	"                       ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                         ",
			-- 	"                       ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                         ",
			-- 	"                       ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                         ",
			-- 	"                       ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                         ",
			-- 	"                       ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                         ",
			-- 	"                       ██      ██      ████      ████                         ",
			-- 	"                                                                              ",
			-- 	"                                                                              ",
			-- 	"                                                                              ",
			-- 	"                                                                              ",
			-- 	"             ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗           ",
			-- 	"             ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║           ",
			-- 	"             ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║           ",
			-- 	"             ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║           ",
			-- 	"             ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║           ",
			-- 	"             ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝           ",
			-- 	"                                                                              ",
			-- 	"                                                                              ",
			-- }

			dashboard.section.header.opts.hl = "String"

			local newFile = dashboard.button("󱁐 n f", "  New   ", "Boolean")
			newFile.opts.hl_shortcut = "SpecialComment"
			newFile.opts.width = 26

			local recentFile = dashboard.button("󱁐 f r", "  Recent")
			recentFile.opts.hl_shortcut = "SpecialComment"
			recentFile.opts.width = 26

			local recentSession = dashboard.button("󱁐 w r", "  Session")
			recentSession.opts.hl_shortcut = "SpecialComment"
			recentSession.opts.width = 26

			local findFile = dashboard.button("󱁐 󱁐  ", "  Find  ")
			findFile.opts.hl_shortcut = "SpecialComment"
			findFile.opts.width = 26

			local quit = dashboard.button("󱁐 Q  ", "  Quit  ")
			quit.opts.hl_shortcut = "SpecialComment"
			quit.opts.width = 26

			-- dashboard.button("<Leader>ps", "  Update plugins"),

			local header_height = 10
			local center_height = 8
			local footer_height = 10
			local win_height = vim.fn.winheight("%")
			local padding = math.floor((win_height - header_height - center_height - footer_height) / 5)

			dashboard.section.buttons.val = {
				{ type = "padding", val = padding },
				{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
				newFile,
				recentFile,
				recentSession,
				findFile,
				quit,
			}

			dashboard.section.buttons.opts.spacing = 1
			dashboard.section.buttons.opts.hl = "String"

			local function footer()
				local total_plugins = #vim.tbl_keys(require("lazy").plugins())
				local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
				local version = vim.version()
				local nvim_version_info = " 󰥔 v" .. version.major .. "." .. version.minor .. "." .. version.patch

				return {
					"",
					datetime,
					" " .. total_plugins .. " plugins on" .. nvim_version_info,
					"",
					"         Focus!",
				}
			end

			dashboard.section.footer.val = footer()
			dashboard.section.footer.opts.hl = "String"

			alpha.setup(dashboard.opts)

			vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
		end,
	},
}
