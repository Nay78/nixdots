{ pkgs, lib, ... }:
{

  home.packages = with pkgs; [
    (unstable.python312.withPackages (
      ps: with ps; [
        requests
        ipython
        attrs
        cattrs
        click
        colorama
        pyyaml
        keyutils
        pynacl # qute-keepassxc
        grip
      ]
    ))
  ];
}
