return {
  -- Instala e gerencia servidores LSP (a loja de aplicativos)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  
  -- Ponte entre o Mason e o lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
  },

  -- O cérebro da configuração LSP
  {
    "neovim/nvim-lspconfig",

config = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Garante que os servidores listados estejam instalados.
  -- Vi que você tem awk_ls e pyright instalados, então adicionei ambos.
  require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "awk_ls" },
  })

  -- Configuração explícita para cada servidor que você quer usar.
  vim.lsp.config.pyright.setup({
    capabilities = capabilities,
  })

  vim.lsp.config.awk_ls.setup({
    capabilities = capabilities,
  })

  -- Atalhos de Teclado Essenciais para LSP
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
  })
end,
 },
}
