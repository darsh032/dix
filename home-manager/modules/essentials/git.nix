{ config, lib, ... }: {
    options = {
	moduleGit.enable = lib.mkEnableOption "enables git" // {
      	    default = true;
        };
    };

    config = lib.mkIf config.essentialsGit.enable {
    	programs.git = {
	    enable = true;
            userName = "Darsh yadav";
            userEmail = "darsh.yadav@proton.me";
        };
    };
}
