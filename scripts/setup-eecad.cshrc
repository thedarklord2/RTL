# Setup vcs by including the VCS executable in your path
setenv PATH                  /usr/local/synopsys/vcs_2015.09/bin:$PATH

# This is an env argument for some scripts
setenv SIM_ENGINE            synopsys

# VCS_HOME is used by some of the scripts
setenv VCS_HOME              /usr/local/synopsys/vcs_2015.09/ 

# Setup Licenses
setenv SNPSLMD_LICENSE_FILE  27020@enlicense9.eas.asu.edu
setenv LM_LICENSE_FILE       27020@enlicense9.eas.asu.edu

setenv SYNOPSYS              /usr/local/synopsys/starrc_2015.06/linux64/syn/

setenv RTL 					 `pwd`/rtl
setenv TB                    `pwd`/tb
