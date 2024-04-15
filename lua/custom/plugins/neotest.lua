return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    require('neotest'):setup {
      -- your neotest config here
      adapters = {
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = '[T]est [F]unction' })
    vim.keymap.set('n', '<leader>tc', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = '[T]est [C]urrent file' })
  end,
}
