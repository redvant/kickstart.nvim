-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local utils = require 'custom.utils'
local language_plugins = utils.loader('custom.plugins.languages', LANGUAGES_ENABLED)
return language_plugins
