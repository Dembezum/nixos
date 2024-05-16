{ ... }:

{
  programs.bash = {
    enable = true;

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
      netl = "netstat -tulpn | grep LISTEN";
      edmesg = "dmesg -T --level=err,warn,crit,emerg";
      cpu5 = "ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 5";
      mem5 = "ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 5";
      lsablk = "lsblk --output name,type,fstype,size,fsavail,mountpoint";
      screenkey = "screenkey --position fixed --geometry $(slop -n -f '%g')";
      sbash = "source ~/.bashrc";
    };

    initExtra = ''
      export PATH=$PATH:~/.local/bin
      export HISTSIZE=10000
      export HISTFILESIZE=10000
      export HISTCONTROL=ignoredups
      export HISTTIMEFORMAT="%F %T "
      export NIXPKGS_ALLOW_UNFREE=1
      shopt -s histappend
      grep --color=always
      PS1='\[\e[0;34m\][\[\e[0;34m\]\u\[\e[0;34m\]] \[\e[0;35m\]/\[\e[0;35m\]\W\[\e[0m\]]\[\e[0;32m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2) \[\e[0;37m\]\$ \[\e[0m\]'
                clear
          echo -e "\033[1;32m#####################\033[0m"
          echo -e "\033[1;32m#  NIX Enviornment  #\033[0m"
          echo -e "\033[1;32m#####################\033[0m"
          echo ""
          echo -e "\033[1;36mNix:\033[0m $(lsb_release -s -d)"
          echo -e "\033[1;36mLoad Average:\033[0m $(cut -d ' ' -f 1-3 /proc/loadavg)"
          echo -e "\033[1;36mAvailable Memory:\033[0m $(free -h | awk '/Mem/ {print $7}')"
          echo -e "\033[1;36mCPU Usage:\033[0m $(top -bn1 | awk '/%Cpu/ {printf("%.2f%", $2 + $4)}')"
          echo ""

      '';
  };

}

