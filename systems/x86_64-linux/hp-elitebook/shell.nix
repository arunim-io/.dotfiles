{ pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  # The code below executes fish using bash.
  # See https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell for more info.
  programs.bash.interactiveShellInit =
    let
      ps = lib.getExe' pkgs.procps "ps";
      fish = lib.getExe pkgs.fish;
    in
    ''
      if [[ $(${ps} --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${fish} $LOGIN_OPTION
      fi
    '';
}
