local dap = require('dap')

dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {'/Users/vipul/projects/vscode-go/dist/debugAdapter.js'};
}

dap.configurations.go = {
  {
    type = 'go';
    name = 'Debug';
    request = 'launch';
    showLog = false;
    program = "${file}";
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
}

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
