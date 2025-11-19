{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.java = {
    enable = lib.mkEnableOption "enable java module";
    javaPackage = lib.mkPackageOption pkgs "java package" {
      default = "temurin-bin-25";
    };
    jdtlsDataPath = lib.mkOption {
      type = lib.types.str;
    };
  };
  config = lib.mkIf config.java.enable {
    autoCmd = [
      {
        command = "lua vim.lsp.buf.format()";
        event = [ "BufWritePre" ];
        pattern = [ "*.java" ];
      }
    ];
    extraFiles = {
      "lua/jdtls-utils.lua".source = ./jdtls-utils.lua;
    };
    extraPackages = [
      config.java.javaPackage
    ];
    plugins = {
      jdtls = {
        enable = true;
        settings = {
          capabilities = lib.mkIf config.plugins.cmp-nvim-lsp.enable {
            __raw = "require('jdtls-utils').get_capabilities()";
          };
          cmd =
            let
              jdtls-path = "${pkgs.jdt-language-server}/share/java/jdtls";
              platform = if pkgs.stdenv.hostPlatform.isDarwin then "mac" else "linux";
              launcher = pkgs.runCommandLocal "jdtls-launcher" { } ''
                mkdir -p $out
                ln -s ${jdtls-path}/plugins/org.eclipse.equinox.launcher_*.jar $out/jdtls_launcher.jar
              '';
            in
            [
              "java"
              "-Declipse.application=org.eclipse.jdt.ls.core.id1"
              "-Dosgi.bundles.defaultStartLevel=4"
              "-Declipse.product=org.eclipse.jdt.ls.core.product"
              "-Dlog.protocol=true"
              "-Dlog.level=ALL"
              "-Xmx1g"
              "--add-modules=ALL-SYSTEM"
              "--add-opens"
              "java.base/java.util=ALL-UNNAMED"
              "--add-opens"
              "java.base/java.lang=ALL-UNNAMED"
              "-jar"
              "${launcher}/jdtls_launcher.jar"
              "-configuration"
              "${jdtls-path}/config_${platform}"
              "-data"
              config.java.jdtlsDataPath
            ];
          init_options =
            let
              extPath =
                ext:
                if ext == "debug" then
                  pkgs.vscode-extensions.vscjava.vscode-java-debug
                else
                  pkgs.vscode-extensions.vscjava.vscode-java-test;
              jarsPath = ext: "${extPath ext}/share/vscode/extensions/vscjava.vscode-java-${ext}/server";
              bundles = pkgs.runCommandLocal "jdtls-bundles" { } ''
                mkdir -p $out
                ln -s ${jarsPath "debug"}/com.microsoft.java.debug.plugin-*.jar $out
                regex="(jacocoagent.jar|com.microsoft.java.test.runner-jar-with-dependencies.jar)"
                for jar in ${jarsPath "test"}/*.jar; do
                  if ! [[ $jar =~ $regex ]]; then
                    ln -s $jar $out
                  fi
                done
              '';
            in
            {
              bundles.__raw = ''require('jdtls-utils').get_bundles("${bundles}")'';
              extendedClientCapabilities = {
                actionableRuntimeNotificationSupport = false;
                advancedExtractRefactoringSupport = true;
                advancedGenerateAccessorsSupport = false;
                advancedIntroduceParameterRefactoringSupport = false;
                advancedOrganizeImportsSupport = true;
                advancedUpgradeGradleSupport = false;
                classFileContentsSupport = true;
                clientDocumentSymbolProvider = false;
                clientHoverProvider = false;
                executeClientCommandSupport = true;
                extractInterfaceSupport = false;
                generateConstructorsPromptSupport = true;
                generateDelegateMethodsPromptSupport = true;
                generateToStringPromptSupport = true;
                gradleChecksumWrapperPromptSupport = false;
                hashCodeEqualsPromptSupport = true;
                inferSelectionSupport = [
                  "extractConstant"
                  "extractMethod"
                  "extractVariable"
                  "extractVariableAllOccurrence"
                ];
                moveRefactoringSupport = true;
                overrideMethodsPromptSupport = true;
                snippetEditSupport = false;
              };
            };
          on_attach.__raw = "require('jdtls-utils').on_attach";
          root_dir.__raw = ''
            require('jdtls.setup').find_root({
              '.git', 'mvnw', 'gradlew', 'pom.xml', 'settings.gradle', 'build.gradle'
            })
          '';
          settings.java = {
            codeGeneration = {
              addFinalForNewDeclaration = "all";
              hashCodeEquals.useJava7Objects = true;
              useBlocks = true;
            };
            contentProvider.preferred = "fernflower";
            format.enabled = false;
            import = {
              gradle.enabled = false;
              maven.enabled = false;
            };
            saveActions.organizeImports = true;
            signatureHelp.enabled = true;
            telemetry.enabled = false;
          };
        };
      };
      none-ls.sources.formatting.google_java_format.enable = true;
      treesitter.grammarPackages = [ pkgs.vimPlugins.nvim-treesitter.builtGrammars.java ];
    };
  };
}
