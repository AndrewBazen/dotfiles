return {
  "vinnymeller/swagger-preview.nvim",   -- Swagger preview plugin for Neovim
  dependencies = { "nvim-lua/plenary.nvim" },  -- Dependency for the plugin
  build = "npm install -g swagger-ui-watcher",  -- Build command to install Swagger UI watcher
  config = true,  -- Enable the plugin
  cmd = { "SwaggerPreview" },  -- Command to trigger the Swagger preview
}
