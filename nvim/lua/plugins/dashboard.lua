local M = {}

function M.setup()
	local db = require("dashboard")

	db.custom_header = {
		[[                                                                              ]],
		[[                                    ██████                                    ]],
		[[                                ████▒▒▒▒▒▒████                                ]],
		[[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
		[[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
		[[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
		[[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
		[[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
		[[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
		[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
		[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
		[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
		[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
		[[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
		[[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
		[[                        ██      ██      ████      ████                        ]],
		[[                                                                              ]],
		[[                                                                              ]],
		[[                                                                              ]],
		[[                                                                              ]],
		[[             ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗           ]],
		[[             ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║           ]],
		[[             ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║           ]],
		[[             ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║           ]],
		[[             ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║           ]],
		[[             ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝           ]],
		[[                                                                              ]],
		[[                                                                              ]],
	}

	db.preview_file_height = 11
	db.preview_file_width = 70
	db.custom_center = {
		{
			icon = "  ",
			desc = "New file            ",
			-- action = "enew",
			shortcut = "SPC n f",
		},
		{
			icon = "  ",
			desc = "Recent files        ",
			shortcut = "SPC f r",
		},
		{
			icon = "  ",
			desc = "Find file/path      ",
			shortcut = "SPC SPC",
		},
		{
			icon = "  ",
			desc = "Find word           ",
			shortcut = "SPC f g",
		},
		{
			icon = "  ",
			desc = "Session load        ",
			shortcut = "SPC !  ",
		},
	}

	db.custom_footer = {
		"ﯦ  Focus!",
	}

	-- Default sizes.
	local header_height = 6
	local center_height = 9
	local footer_height = 1

	-- Extra padding.
	local header_extra_padding = 1
	local center_extra_padding = 0
	local footer_extra_padding = 0

	-- Get window height in rows.
	local win_height = vim.fn.winheight("%")
	local padding = (win_height - header_height - center_height - footer_height) / 4

	-- Calculate and set padding for each section.
	db.header_pad = padding - header_extra_padding
	db.center_pad = padding - center_extra_padding
	db.footer_pad = padding - footer_extra_padding
end

return M
