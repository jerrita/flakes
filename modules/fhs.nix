{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
        pkgs.buildFHSUserEnv (
          base
          // {
            name = "fhs";
            targetPkgs = pkgs: (
              # pkgs.buildFHSUserEnv 只提供一个最小的 FHS 环境，缺少很多常用软件所必须的基础包
              # 所以直接使用它很可能会报错
              #
              # pkgs.appimageTools 提供了大多数程序常用的基础包，所以我们可以直接用它来补充
              (base.targetPkgs pkgs)
              ++ (with pkgs; [
                pkg-config
                ncurses
              ])
            );
            profile = "export FHS=1";
            runScript = "bash";
            extraOutputsToInstall = ["dev"];
          }
        )
    )
  ];
}
