# maximizer.nvim

Simple window maximizer/restorer. Toggle current window between full viewport size and original dimensions.

## ✨ Features

- Single key toggle `<Space>m`
- Preserves original window size
- Statusline integration (`vim.t.maximized`)
- `:MaximizeToggle` command
- Auto re-maximize after resize

## 📦 Installation

### Lazy.nvim
```lua
{
    'mthnglac/maximizer.nvim',
    config = function()
        require('maximizer').setup()
    end
}
```

## 🚀 Usage

**Default**: `<Space>m` or `:MaximizeToggle`

**Custom keymap**:
```lua
require('maximizer').setup({
    keymap = '<Space>m',
    disable_keymaps = false,
})
```


## ⚙️ Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `keymap` | `string` | `"<Space>m"` | Toggle keymap |
| `disable_keymaps` | `boolean` | `false` | Disable default keymaps |


## ⚙️ Statusline Integration
```lua
-- plugins/lualine-nvim.lua
local function max_status()
    return vim.t.maximized and '󰖭 MAX' or ''
end

require(‘lualine’).setup({
    sections = {
        lualine_a = {
            ‘mode’, max_status
        },
    }
})
```


## Commands

- `:MaximizeToggle` — Toggle maximization of the current window.

---

## Documentation

- `:help maximizer.nvim` for full documentation.

---

## License

MIT

