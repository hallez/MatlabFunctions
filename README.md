1. Clone repository 

1. Create ~/Documents/MATLAB directory (if does not already exist)
mkdir ~/Documents/MATLAB 

1. Add a symbolic link from repository location to matlab folder 
ln -s /Users/<user-name>/workspace/matlabfunctions/my_functions ~/Documents/MATLAB/ 

If need to remove an old symbolic link, use rm -r <MATLAB-dir> with no trailing slash on the directory. 

1. Create a machine-specific startup.m file using startup.m.example as a base. Be sure to replace <USER-NAME>
cp startup.m.example ~/Documents/MATLAB/startup.m 
