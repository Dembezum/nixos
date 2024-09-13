{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zoxide
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      flake = "cd ~/Git/flakes/nixos && el";
      net = "cd ~/Projects/Network/ && el";
      docs = "cd ~/Projects/h1/docs/ && el";
      ccna = "cd ~/Documents/Skole/It/CCNA/";
      todo = "cd ~/Projects/C/todo && el";
      eks = "cd ~/Projects/Eksamen && eza -la";
      cdir = "sbash && cd ~/Projects/C && ls";
      rsdir = "sbash && cd ~/Projects/Rust && ls";
      mddir = "sbash && cd ~/Projects/Markdown && ls";
      tsdir = "sbash && cd ~/Projects/TS && ls";
      shdir = "sbash && cd ~/Projects/Shell && ls";
      swdir = "sbash && cd ~/Projects/Projects.swift/ && ls";
      pydir = "sbash && cd ~/Projects/Python && ls";
      ll = "ls -a";
      el = "sbash && eza -l --icons";
      rgg = "rg --files | rg";
      ela = "sbash && eza -la --icons";
      eda = "sbash && eza -aD -l --icons";
      eta = "sbash && eza -la --sort=type --icons";
      ls = "eza --icons";
      cp = "cp -v";
      mv = "mv -iv";
      tt = "tt -showwpm -blockcursor -t 20 -highlight1 -n 25";
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
      nedit = "fd --type f --hidden --exclude .git | fzf-tmux -p | xargs nvim";
      gs = "git status";
      gp = "git push";
      gpo = "git push origin main";
      gpu = "git push -u origin main";
      gca = "git commit -a";
      gcm = "git commit -m";
      grep = "grep --color=auto";
      netl = "netstat -tulpn | grep LISTEN";
      edmesg = "dmesg -T --level=err,warn,crit,emerg";
      cpu5 = "ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 15";
      mem5 = "ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 15";
      lsablk = "lsblk --output name,type,fstype,size,fsavail,mountpoint";
      screenkey = "screenkey --position fixed --geometry $(slop -n -f '%g')";
      sbash = "source ~/.zshrc";
    };
    initExtra = ''
      HISTFILE=~/.zsh_history
      HISTSIZE=10000
      SAVEHIST=$HISTSIZE
      HISTDUP=erase
      setopt sharehistory
      setopt appendhistory
      setopt hist_ignore_dups   
      setopt hist_ignore_space
      setopt hist_save_no_dups
      setopt hist_find_no_dups
      export TIMEFMT="[Finished in %E]"
      export HISTTIMEFORMAT="%F %T "
      export HISTCONTROL=ignoredups
      setopt appendhistory

      autoload -z edit-command-line
      zle -N edit-command-line

      bindkey "^X^E" edit-command-line
      bindkey '^R' history-incremental-search-backward

      ztyle ':completion:*' menu no

      parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
      }
      setopt PROMPT_SUBST
      PROMPT='%B%F{cyan}[%f%F{green}%n%f%B%F{cyan}]%f%F{red} /%1~%f%F{blue}$(parse_git_branch)%f%F{183} > '

			if [[ "$TERM" == "dumb" ]]
			then
				unsetopt zle
				unsetopt prompt_cr
				unsetopt prompt_subst
				unfunction precmd
				unfunction preexec
				PS1='$ '
			fi

      function cd() {
          if which eza >/dev/null; then 
              if [ $# -eq 0 ]; then
                  builtin cd && eza --group-directories-first
              else
                  builtin cd "$@" && eza --group-directories-first
              fi
          else
              if [ $# -eq 0 ]; then
                builtin cd && ls --group-directories-first
              else
                  builtin cd "$@" && ls --group-directories-first
              fi
          fi
      }
      function f(){
         builtin cd "$(fd -t d --full-path / . | fzf)" && eza --group-directories-first
      }
      function fa(){
         builtin cd "$(fd -t d --full-path / / | fzf)" && eza --group-directories-first
      }
      function fh(){
         builtin cd "$(fd -t d --full-path / ~ | fzf)" && eza --group-directories-first
      }
    '' +
    # Nix Specific
    ''
      export PATH=$HOME/.nix-profile/bin:$PATH
      export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
      eval "$(zoxide init --cmd z zsh)"

      function cd() {
         if [ $# -eq 0 ]; then
            z && eza --group-directories-first
         else
            z "$@" && eza --group-directories-first
         fi
      }
    '' +
    ''
    clear
    echo -e "\033[1;36mNix:\033[0m $(lsb_release -s -d)"
    echo -e "\033[1;36mLoad Average:\033[0m $(cut -d ' ' -f 1-3 /proc/loadavg)"
    echo -e "\033[1;36mAvailable Memory:\033[0m $(free -h | awk '/Mem/ {print $7}')"
    echo -e "\033[1;36mCPU Usage:\033[0m $(top -bn1 | awk '/%Cpu/ {printf("%.2f%", $2 + $4)}')"
    echo ""
    '';
    };

    }
