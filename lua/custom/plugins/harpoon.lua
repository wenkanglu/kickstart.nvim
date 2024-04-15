return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- Set buffers
    vim.keymap.set('n', '<leader>hs1', function()
      harpoon:list():replace_at(1)
    end, { desc = '[H]arpoon [S]et to [1]st' })
    vim.keymap.set('n', '<leader>hs2', function()
      harpoon:list():replace_at(2)
    end, { desc = '[H]arpoon [S]et to [2]nd' })
    vim.keymap.set('n', '<leader>hs3', function()
      harpoon:list():replace_at(3)
    end, { desc = '[H]arpoon [S]et to [3]rd' })
    vim.keymap.set('n', '<leader>hs4', function()
      harpoon:list():replace_at(4)
    end, { desc = '[H]arpoon [S]et to [4]th' })

    -- Get buffers
    vim.keymap.set('n', '<leader>h1', function()
      harpoon:list():select(1)
    end, { desc = '[H]arpoon select [1]st' })
    vim.keymap.set('n', '<leader>h2', function()
      harpoon:list():select(2)
    end, { desc = '[H]arpoon select [2]nd' })
    vim.keymap.set('n', '<leader>h3', function()
      harpoon:list():select(3)
    end, { desc = '[H]arpoon select [3]rd' })
    vim.keymap.set('n', '<leader>h4', function()
      harpoon:list():select(4)
    end, { desc = '[H]arpoon select [4]th' })

    vim.keymap.set('n', '<leader>hc', function()
      harpoon:list():clear()
    end, { desc = '[H]arpoon [C]lear' })

    vim.keymap.set('n', '<leader>ht', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon [T]oggle Telecope menu' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon previous buffer' })
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon next buffer' })
  end,
}
