Please make sure that you test programatically that the task that was asked of you is correctly completed

Directives based on actions:



### When installing plugins
In the case of plugins, make sure that after you install them into the plugin directory, or file, make sure that they are tested to work as according to the documenation of the plugin and that the default keybindings are set for that plugin

### Additional notes
    - The documenation of the plugin can be found by fetching the page https://github.com<plugin-name>
    - The command :checkhealth also provides a lot of useful information about which plugins are installed and working and which have issues
    - Any tests that you write to check that the keymaps have been written correctly please write them out to the file ./lua/plugins/healthcheck.lua and then update the :custom_healthcheck method that exists in the init.lua directory
