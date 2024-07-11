{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  # The code below executes fish using bash. See https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell for more info.
  programs.bash.interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
}
