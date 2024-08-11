{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  keymaps = [

    {
      action = "nzzzv";
      key = "n";
      mode = "n";
      options = { desc = "Next search result and center"; };
    }
    {
      action = "Nzzzv";
      key = "N";
      mode = "n";
      options = { desc = "Previous search result and center"; };
    }
    {
      # Neotree
      action = "<cmd>Neotree toggle<CR>";
      key = "<space>n"; # this line is changed
      mode = "n";
      options = { desc = "Toggle Tree View."; };
    }
    {
      #info
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      key = "<space>k"; # this line is changed
      mode = "n";
      options = { desc = "info about things"; };
    }
    {
      # Neoformat
      action = "<cmd>Neoformat<CR>";
      key = "<space>="; # this line is changed
      mode = [ "n" ];
      options = { desc = "formatting"; };
    }
    {
      #opening a terminal in neovim
      action = "<cmd>ToggleTerm<CR>";
      key = "<space>t"; # this line is changed
      mode = [ "n" ];
      options = { desc = "open terminal"; };
    }
    {
      # running a single code using SnipRun
      action = "<cmd>SnipRun<CR>";
      key = "<space>r"; # this line is changed
      mode = [ "v" "n" ];
      options = { desc = "run's the selected code"; };
    }
    {
      action = "<cmd>write<CR>";
      key = "<leader>w";
      options = { desc = "write file"; };
    }
    {
      action = "<cmd>quit<CR>";
      key = "<leader>q";
      options = { desc = "exit file"; };
    }
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>ps";
      options = { desc = "telescope live_grep"; };
    }
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader>pf";
      options = { desc = "telescope file finding"; };
    }
    {
      action = "<cmd>Telescope buffers<CR>";
      key = "<leader>pg";
      options = { desc = "telescope buffer finding"; };
    }
    {
      action = "<cmd>Telescope file_browser <CR>";
      key = "<leader>fb";
      options = { desc = "telescope file browsing"; };
    }
    {
      action = "<cmd>bd#<CR>";
      key = "<leader>cb";
      options = { desc = "killing opened output buffer"; };
    }
    {
      action = "<cmd>Neorg<CR>";
      key = "<leader>o";
      options = { desc = "opening neorg with telesope"; };
    }
    {
      action = "<cmd>!chmod +x %<CR>";
      key = "<leader>x";
      mode = "n";
      options = { desc = "Make this executable"; };
    }
    {
      action = ":m '>+1<CR>gv=gv";
      key = "J";
      mode = "v";
      options = { desc = "Move selected text down"; };
    }
    {
      action = ":m '<-2<CR>gv=gv";
      key = "K";
      mode = "v";
      options = { desc = "Move selected text up"; };
    }
    {
      action = ":BufferLineCyclePrev<CR>";
      key = "<leader>,";
      mode = "n";
      options = { desc = "Buffer Previous"; };
    }
    {
      action = ":BufferLineCycleNext<CR>";
      key = "<leader>.";
      mode = "n";
      options = { desc = "Buffer Next"; };
    }
    {
      action = ":MarkdownPreviewToggle<CR>";
      key = "<leader>mdt";
      mode = "n";
      options = { desc = "Toggle Markdown Preview"; };
    }
    {
      action = ":MarkdownPreview<CR>";
      key = "<leader>md";
      mode = "n";
      options = { desc = "Start Markdown Preview"; };
    }
  ];
}
