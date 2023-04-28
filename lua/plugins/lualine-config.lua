local lualine = require 'lualine'

-- Kanagawa colors
local colors = {
  red = '#e82424',
  grey = '#727169',
  black = '#1f1f28',
  white = '#dcd7ba',
  light_green = '#98BB6C',
  orange = '#ffa066',
  green = '#76946a',
}


-- Config for basic lualine
require('lualine').setup {
  options = {
    theme = 'kanagawa',
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
