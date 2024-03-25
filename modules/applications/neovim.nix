{ config, pkgs, lib, ... }: {

  options = {
    neovim = {
      enable = lib.mkEnableOption {
        description = "Enable neovim";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.neovim.enable) {
    home-manager.users.${config.user} = {
      home.sessionVariables.EDITOR = "nvim";
      programs.neovim = {
        enable = true;
        extraConfig = ''
          " Options
          set background=dark
      	  set clipboard=unnamedplus
	        set completeopt=noinsert,menuone,noselect
	        set cursorline
	        set hidden
	        set inccommand=split
	        set mouse=a
	        set number
	        set relativenumber
	        set splitbelow splitright
	        set title
	        set ttimeoutlen=0
	        set wildmenu
          set t_Co=256

          " Tab size
	        set expandtab
	        set shiftwidth=2
	        set tabstop=2
 
          " Syntax
      	  filetype plugin indent on
	        syntax on

          " Italics
          let &t_ZH="\e[3m"
          let &t_ZR="\e[23m"

          " Colorscheme
          colorscheme carbonfox

          " Airline
          let g:airline_powerline_fonts = 1
          let g:airline#extensions#tabline#enabled = 1

          " File browser
          let NERDTreeShowHidden=1
          command Tree NERDTree

          " Polyglot
          set nocompatible

          " Markdown
          let g:vim_markdown_folding_disabled = 1
	        let g:vim_markdown_frontmatter = 1
	        let g:vim_markdown_conceal = 0
	        let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']

          " tmux
          let g:tmux_navigator_no_mappings = 1

          noremap <silent> {Left-Mapping} :<C-U>TmuxNavigateLeft<cr>
          noremap <silent> {Down-Mapping} :<C-U>TmuxNavigateDown<cr>
          noremap <silent> {Up-Mapping} :<C-U>TmuxNavigateUp<cr>
          noremap <silent> {Right-Mapping} :<C-U>TmuxNavigateRight<cr>
          noremap <silent> {Previous-Mapping} :<C-U>TmuxNavigatePrevious<cr>
        '';

        extraLuaConfig = ''
          
        '';
        plugins = with pkgs.vimPlugins; [
          # Theme
          nightfox-nvim

          # Plugins
          vim-airline
          #tabby-nvim
          #feline-nvim
          vim-devicons
          nerdtree
          vim-polyglot
          auto-pairs
          vim-gitgutter
          vim-lsp
          vim-markdown

          vim-tmux-navigator
        ];
      };
    };
  };
}
