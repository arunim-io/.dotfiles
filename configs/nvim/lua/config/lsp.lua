local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local maps = vim.lsp.buf

    local function set(keymap, cmd, desc)
      vim.keymap.set("n", keymap, cmd, { buffer = event.buf, desc = desc })
    end

    set("K", maps.hover, "Show information about the symbol under the cursor")
    set("gd", maps.definition, "Show definition for the symbol under the cursor")
    set("gD", maps.declaration, "Go to the declaration of the symbol under the cursor")
    set("gi", maps.implementation, "Show implementation of the symbol under the cursor")
    set("gt", maps.type_definition, "Jump to definition of the symbol under the cursor")
    set("gr", maps.references, "List all the references of the symbol under the cursor")
    set("gs", maps.signature_help, "Show signature information about the symbol under the cursor")
    set("<leader>ca", maps.code_action, "Open code action menu")
    set("<leader>rn", maps.rename, "Rename current word")
  end,
})

---@param lsp string
---@param config lspconfig.Config?
local function setup_lsp(lsp, config)
  config = config or {}
  config.capabilities = require("cmp_nvim_lsp").default_capabilities()
  lspconfig[lsp].setup(config)
end

setup_lsp("lua_ls")
setup_lsp("nil_ls")
setup_lsp("taplo", {
  settings = {
    formatter = {
      allowed_blank_lines = 1,
    },
  },
})
setup_lsp("dockerls")
setup_lsp("bashls")
setup_lsp("html", {
  filetypes = { "html", "htmldjango", "djangohtml" },
  init_options = {
    provideFormatter = false,
  },
})
setup_lsp("emmet_language_server")
setup_lsp("cssls", {
  init_options = {
    provideFormatter = false,
  },
})
setup_lsp("tailwindcss", {
  on_attach = function()
    local plugin_name = "tailwind-tools"

    if not package.loaded[plugin_name] then
      require("lazy").load({ plugins = { plugin_name } })
    end
  end,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})
setup_lsp("astro")
setup_lsp("svelte")
setup_lsp("biome")
setup_lsp("htmx")

setup_lsp("basedpyright", {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
    },
  },
})
setup_lsp("ruff")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP: Disable hover capability from Ruff",
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
})

setup_lsp("eslint", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "html",
    "markdown",
    "json",
    "jsonc",
    "yaml",
    "toml",
    "xml",
    "gql",
    "graphql",
    "astro",
    "svelte",
    "css",
    "less",
    "scss",
    "pcss",
    "postcss",
  },
  settings = {
    rulesCustomizations = {
      { rule = "style/*", severity = "off", fixable = true },
      { rule = "format/*", severity = "off", fixable = true },
      { rule = "*-indent", severity = "off", fixable = true },
      { rule = "*-spacing", severity = "off", fixable = true },
      { rule = "*-spaces", severity = "off", fixable = true },
      { rule = "*-order", severity = "off", fixable = true },
      { rule = "*-dangle", severity = "off", fixable = true },
      { rule = "*-newline", severity = "off", fixable = true },
      { rule = "*quotes", severity = "off", fixable = true },
      { rule = "*semi", severity = "off", fixable = true },
    },
  },
})
