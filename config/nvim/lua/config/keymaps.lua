-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
M = {}

local function map_normal_mode(keys, func, desc)
  -- default values:
  -- noremap: false
  -- silent: false
  vim.keymap.set("n", keys, func, { desc = desc, noremap = false, silent = true })
end

function M.setup_tmux_navigator_keymaps()
  return {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  }
end

function M.setup_lsp_keymaps()
  map_normal_mode("<leader>uh", require("utils.inlay_hints").toggle_inlay_hints, "Toggle inlay hints")
end

function M.setup_diagnostics_keymaps()
  map_normal_mode("<leader>ud", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, "Toggle diagnostics")
end

function M.setup_lsp_autocmd_keymaps(event)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc, nowait = true })
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

  -- Find references for the word under your cursor.
  map("gr", ':lua require("telescope.builtin").lsp_references({ show_line = false })<CR>', "[G]oto [R]eferences")

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [t]ype definition")

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map("<leader>cS", require("telescope.builtin").lsp_document_symbols, "Do[c]ument [S]ymbols (telescope)")

  -- Fuzzy find all the symbols in your current workspace
  --  Similar to document symbols, except searches over your whole project.
  map("<leader>cw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols (telescope)")

  -- Rename the variable under your cursor
  --  Most Language Servers support renaming across files, etc.
  map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap
  map("K", vim.lsp.buf.hover, "Hover Documentation")

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

function M.setup_dap_ui_keymaps()
  -- keymaps: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L508
  return {
    {
      "<leader>du",
      function()
        require("dapui").toggle({})
      end,
      desc = "DAP UI",
    },

    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      desc = "DAP Eval",
    },
  }
end

function M.setup_dap_keymaps()
  return {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "toggle [d]ebug [b]reakpoint",
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "[d]ebug [B]reakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "[d]ebug [c]ontinue (start here)",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "[d]ebug [C]ursor",
    },
    {
      "<leader>dg",
      function()
        require("dap").goto_()
      end,
      desc = "[d]ebug [g]o to line",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "[d]ebug step [o]ver",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_out()
      end,
      desc = "[d]ebug step [O]ut",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "[d]ebug [i]nto",
    },
    {
      "<leader>dj",
      function()
        require("dap").down()
      end,
      desc = "[d]ebug [j]ump down",
    },
    {
      "<leader>dk",
      function()
        require("dap").up()
      end,
      desc = "[d]ebug [k]ump up",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "[d]ebug [l]ast",
    },
    {
      "<leader>dp",
      function()
        require("dap").pause()
      end,
      desc = "[d]ebug [p]ause",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "[d]ebug [r]epl",
    },
    {
      "<leader>dR",
      function()
        require("dap").clear_breakpoints()
      end,
      desc = "[d]ebug [R]emove breakpoints",
    },
    {
      "<leader>ds",
      function()
        require("dap").session()
      end,
      desc = "[d]ebug [s]ession",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "[d]ebug [t]erminate",
    },
    {
      "<leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "[d]ebug [w]idgets",
    },
  }
end

function M.setup_neotest_keymaps()
  return {
    {
      "<leader>ta",
      function()
        require("neotest").run.attach()
      end,
      desc = "Attach",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run File",
    },
    {
      "<leader>tA",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      desc = "Run All Test Files",
    },
    {
      "<leader>tT",
      function()
        require("neotest").run.run({ suite = true })
      end,
      desc = "Run Test Suite",
    },
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Nearest",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "Show Output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
    {
      "<leader>tt",
      function()
        require("neotest").run.stop()
      end,
      desc = "Terminate",
    },
    {
      "<leader>td",
      function()
        vim.cmd("Neotree close")
        require("neotest").summary.close()
        require("neotest").output_panel.close()
        require("neotest").run.run({ suite = false, strategy = "dap" })
      end,
      desc = "Debug nearest test",
    },

    -- -- map_normal_mode("<leader>td", ':lua require("neotest").run.run({vim.fn.expand("%"), strategy = "dap"})<CR>', "[t]est [d]ebug Nearest")
    -- map_normal_mode("<leader>td", ':lua require("neotest").run.run({ strategy = "dap" })<CR>', "[t]est [d]ebug Nearest")
    -- map_normal_mode("<leader>tg", function()
    --   -- FIXME: https://github.com/nvim-neotest/neotest-go/issues/12
    --   -- Depends on "leoluz/nvim-dap-go"
    --   require("dap-go").debug_test()
    -- end, "[d]ebug [g]o (nearest test)")
  }
end

function M.setup_snippets_keymaps()
  return {
    {
      "<tab>",
      function()
        return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      end,
      expr = true,
      silent = true,
      mode = "i",
    },
    {
      "<tab>",
      function()
        require("luasnip").jump(1)
      end,
      mode = "s",
    },
    {
      "<s-tab>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
    },
  }
end

function M.setup_cmp_keymaps(cmp)
  return {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-Space>"] = cmp.mapping.complete(), -- NOTE: already taken on macOS
    ["<C-e>"] = cmp.mapping.abort(),
    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- If nothing is selected (including preselections) add a newline as usual.
    -- If something has explicitly been selected by the user, select it.
    ["<Enter>"] = function(fallback)
      -- Don't block <CR> if signature help is active
      -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/13
      if
        not cmp.visible()
        or not cmp.get_selected_entry()
        or cmp.get_selected_entry().source.name == "nvim_lsp_signature_help"
      then
        fallback()
      else
        cmp.confirm({
          -- Replace word if completing in the middle of a word
          -- https://github.com/hrsh7th/nvim-cmp/issues/664
          behavior = cmp.ConfirmBehavior.Replace,
          -- Don't select first item on CR if nothing was selected
          select = false,
        })
      end
    end,

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { "i", "s", "c" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { "i", "s", "c" }),
  }
end

function M.setup_coverage_keymaps()
  map_normal_mode("<leader>tc", ":Coverage<CR>", "[t]est [c]overage in gutter")
  map_normal_mode("<leader>tC", ":CoverageLoad<CR>:CoverageSummary<CR>", "[t]est [C]overage summary")
end

function M.setup_neogit_keymaps()
  local neogit = require("neogit")
  vim.keymap.set("n", "<leader>gn", function()
    neogit.open({ kind = "split" })
  end, { silent = true, noremap = true, desc = "Neogit" })
  vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true, desc = "[g]it [p]ull" })
  vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true, desc = "[g]it [P]ush" })
  -- NOTE: see Telescope git_... commands set by setup_telescope_keymaps
end

function M.setup_copilot_chat_keymaps()
  return {
    { "<leader>aC", ":CopilotChat<CR>", desc = "Copilot Chat" },
  }
end

function M.setup_copilot_keymaps()
  return {
    { "<leader>ap", ":Copilot panel<CR>", desc = "Copilot panel" },
  }
end

function M.setup_telescope_keymaps()
  map_normal_mode("<leader><leader>", require("telescope.builtin").find_files, "Find Files")

  -- file
  map_normal_mode("<leader>fp", "<cmd>Telescope projects<CR>", "File from other project")
  map_normal_mode("<leader>fr", "<cmd>Telescope oldfiles<CR>", "Recent files")

  -- git
  map_normal_mode("<leader>gtc", "<cmd>Telescope git_commits<CR>", "Search git [c]ommits")
  map_normal_mode("<leader>gtC", "<cmd>Telescope git_bcommits<CR>", "Search git branch [C]ommits")
  map_normal_mode("<leader>gts", "<cmd>Telescope git_status<CR>", "Search git [s]tatus changes")
  map_normal_mode("<leader>gtb", "<cmd>Telescope git_branches<CR>", "Search git [b]ranches")

  -- search
  map_normal_mode("<leader>/", require("telescope").extensions.live_grep_args.live_grep_args, "[s]earch [g]rep")
  map_normal_mode('<leader>s"', "<cmd>Telescope registers<cr>", '[s]earch ["]registers')
  map_normal_mode("<leader>sa", "<cmd>Telescope autocommands<cr>", "[s]earch [a]utocommands")
  map_normal_mode("<leader>sb", "<cmd>Telescope buffers<CR>", "[s]earch opened [b]uffers")
  map_normal_mode("<leader>sc", "<cmd>Telescope commands<cr>", "[s]earch [c]ommands")
  map_normal_mode("<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", "[s]earch [d]ocument diagnostics")
  map_normal_mode("<leader>sD", "<cmd>Telescope diagnostics<cr>", "[s]earch [D]iagnostics")
  map_normal_mode("<leader>sh", "<cmd>Telescope help_tags<cr>", "[s]earch [h]elp pages")
  map_normal_mode("<leader>sH", "<cmd>Telescope highlights<cr>", "[s]earch [H]ighlight groups")
  map_normal_mode("<leader>sk", "<cmd>Telescope keymaps<cr>", "[s]earch [k]ey maps")
  map_normal_mode("<leader>sM", "<cmd>Telescope man_pages<CR>", "[s]earch [M]an pages")
  map_normal_mode("<leader>sm", "<cmd>Telescope marks<cr>", "[s]earch [m]arks")
  map_normal_mode("<leader>so", "<cmd>Telescope vim_options<cr>", "[s]earch [o]ptions")
end

function M.setup_trouble_keymaps()
  return {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>:Neotree document_symbols<cr>",
      desc = "Symbols (Neotree)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  }
end

function M.setup_whichkey()
  local wk = require("which-key")
  wk.add({
    { "<leader><tab>", group = "tab" },
    { "<leader>a", group = "ai" },
    { "<leader>c", group = "code" },
    { "<leader>d", group = "debug" },
    { "<leader>f", group = "file" },
    { "<leader>g", group = "git" },
    { "<leader>gb", group = "blame" },
    { "<leader>gd", group = "diffview" },
    { "<leader>gh", group = "hunks" },
    { "<leader>gt", group = "telescope" },
    { "<leader>n", group = "notes" },
    { "<leader>r", group = "run" },
    { "<leader>s", group = "search" },
    { "<leader>sn", group = "noice" },
    { "<leader>t", group = "test" },
    { "<leader>u", group = "ui" },
    { "<leader>w", group = "window" },
    { "<leader>x", group = "diagnostics/quickfix" },
  })
end

function M.setup_whichkey_contextual()
  return {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  }
end

function M.setup_obsidian_keymaps(obsidian_vars)
  return {
    { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "[N]otes: [s]earch text" },
    { "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", desc = "[N]otes: search [f]ilenames" },
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "[N]otes: [n]new" },
    { "<leader>nl", "<cmd>ObsidianQuickSwitch Learning.md<cr><cr>", desc = "[N]otes: [l]earning" },
    { "<leader>ng", "<cmd>ObsidianQuickSwitch Go.md<cr><cr>", desc = "[N]otes: [g]olang learning" },
    { "<leader>nv", "<cmd>ObsidianQuickSwitch Neovim config.md<cr><cr>", desc = "[N]otes: Neo[v]im todo" },

    {
      "<leader>nS",
      function()
        local client = require("obsidian").get_client()
        client:open_note(obsidian_vars.scratchpad_path)
      end,
      desc = "[N]otes: [S]cratchpad",
    },
    {
      "<leader>nm",
      function()
        local client = require("obsidian").get_client()
        -- client.dir is the vault path
        local note = client:create_note({
          title = "Meeting notes",
          dir = vim.fn.expand(obsidian_vars.notes_path),
          -- NOTE: if folder "templates" exist in $cwd,
          -- the template is expected to be found there.
          template = "meeting_notes",
        })
        client:open_note(note)
      end,
      desc = "[N]otes: new [m]eeting agenda from template",
    },
  }
end

function M.setup_yanky_keymaps()
  map_normal_mode("<leader>p", function()
    require("telescope").extensions.yank_history.yank_history({})
  end, "Yanky history")

  -- TODO: review...
  -- keys = {
  -- { "<leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
  -- { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
  -- { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
  -- { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
  -- { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
  -- { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
  -- { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
  -- { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
  -- { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
  -- { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
  -- { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
  -- { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
  -- { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
  -- { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
  -- { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
  -- { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
  -- { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
  -- { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
  -- },
end

return M
