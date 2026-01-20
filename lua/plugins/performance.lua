-- Performance optimizations to reduce delays
return {
  -- Disable automatic plugin update checking (causes delays)
  {
    "folke/lazy.nvim",
    opts = {
      checker = {
        enabled = false, -- Was true, causing delays on exit
        frequency = 0,
      },
    },
  },
  
  -- Disable persistence session saving (causes wq delays)
  {
    "folke/persistence.nvim",
    enabled = false,
  },
}
