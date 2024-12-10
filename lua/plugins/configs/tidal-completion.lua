local source = {}
local has_cmp, cmp = pcall(require, 'cmp')
if not has_cmp then return end

source.new = function()
    return setmetatable({}, { __index = source })
end

source.name = 'tidal'

-- Tidal-specific completion items with documentation
local tidal_items = {
    -- Basic Pattern Functions
    { 
        label = 'sound',
        kind = cmp.lsp.CompletionItemKind.Function,
        documentation = {
            kind = 'markdown',
            value = '# sound "name"\nPlays a sample or synth sound\n\nExample:\n```tidal\nd1 $ sound "bd hh sn hh"\n```'
        }
    },
    { 
        label = 's',
        kind = cmp.lsp.CompletionItemKind.Function,
        documentation = {
            kind = 'markdown',
            value = '# s\nShorthand for sound\n\nExample:\n```tidal\nd1 $ s "bd*4"\n```'
        }
    },
    
    -- Effects
    { 
        label = 'gain',
        kind = cmp.lsp.CompletionItemKind.Property,
        documentation = {
            kind = 'markdown',
            value = '# gain\nControls volume (0-2)\n\nExample:\n```tidal\nd1 $ sound "bd" # gain 1.5\n```'
        }
    },
    { 
        label = 'pan',
        kind = cmp.lsp.CompletionItemKind.Property,
        documentation = {
            kind = 'markdown',
            value = '# pan\nStereo panning (0-1)\n\nExample:\n```tidal\nd1 $ sound "bd" # pan 0.5\n```'
        }
    },
    
    -- Pattern Transformations
    { 
        label = 'fast',
        kind = cmp.lsp.CompletionItemKind.Function,
        documentation = {
            kind = 'markdown',
            value = '# fast\nSpeeds up a pattern\n\nExample:\n```tidal\nd1 $ fast 2 $ sound "bd sn"\n```'
        }
    },
    { 
        label = 'slow',
        kind = cmp.lsp.CompletionItemKind.Function,
        documentation = {
            kind = 'markdown',
            value = '# slow\nSlows down a pattern\n\nExample:\n```tidal\nd1 $ slow 2 $ sound "bd sn"\n```'
        }
    },
    -- Add more items as needed
}

-- Scan SuperCollider samples directory
local function scan_sc_samples()
    local samples = {}
    local sc_samples = os.getenv("HOME") .. "/.local/share/SuperCollider/downloaded-quarks/Dirt-Samples"
    
    if vim.fn.isdirectory(sc_samples) == 1 then
        local handle = io.popen('ls "' .. sc_samples .. '"')
        if handle then
            for dir in handle:lines() do
                -- Create completion item for each sample directory
                table.insert(samples, {
                    label = dir,
                    kind = cmp.lsp.CompletionItemKind.Value,
                    documentation = {
                        kind = 'markdown',
                        value = string.format("# %s\nSample from Dirt-Samples\n\nExample:\n```tidal\nd1 $ sound \"%s\"\n```", dir, dir)
                    }
                })
            end
            handle:close()
        end
    end
    return samples
end

-- Cache for samples
local samples_cache = nil
local last_scan_time = 0
local SCAN_INTERVAL = 5000 -- milliseconds

source.complete = function(self, request, callback)
    local current_time = vim.loop.now()
    local items = {}
    
    -- Add Tidal functions and effects
    for _, item in ipairs(tidal_items) do
        table.insert(items, item)
    end
    
    -- Add samples with caching
    if not samples_cache or (current_time - last_scan_time > SCAN_INTERVAL) then
        samples_cache = scan_sc_samples()
        last_scan_time = current_time
    end
    
    for _, sample in ipairs(samples_cache or {}) do
        table.insert(items, sample)
    end
    
    callback({ items = items })
end

return source