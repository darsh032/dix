{ config, lib, ... }: {
    options = {
	moduleGit.enable = lib.mkEnableOption "enables git" // {
      	    default = true;
        };
    };

    config = lib.mkIf config.moduleGit.enable {
    	programs.git = {
  	    enable = true;
  	      settings = {
            user = {
              name = "Darsh yadav";
              email = "darsh.yadav@proton.me";
            };
  	      };
        };
    };
}
