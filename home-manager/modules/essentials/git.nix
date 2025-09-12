{ ... }:

{
    options = {
	essentialsGit.enable = lib.mkEnableOption "enables git";
    };

    config = lib.mkIf config.essentialsGit.enable {
    	programs.git = {
	    enable = true;
            userName = "Darsh yadav";
            userEmail = "darsh.yadav@proton.me";
        };
    };
}
