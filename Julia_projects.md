# Intalling Julia Projects
This includes installing julia and juliaup. Both can be converted into julia modules.When installing packages (e.g. chloe) then you can call the julia verison you want.

## First install juliaup
It generally refuses to intall in a given directory so just install it in the home drive and then move the `.julia` and `.juliaup` folders into the data directory to have e.g. `/group/peb005/.julia` amd `.juliaup`. The juliaup subdirectory is then connected to the juliaup5 module that can be called from the homedrive on kaya.

## Creating julia verions using juliaup
Create a folder for modules if you haven't yet. (e.g. `group/peb005/modules`) Make sure the source files in your home contain the path to the modules. Here the source files:
*This is a setup for being the manager of peb005 and peb007*

```bash
#content of .bash_profile
#######

# Kaya environment file
if [ -f ~/.kaya_env5.sh ]; then
. ~/.kaya_env5.sh
fi
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

#connect to group set ups (environments and module packages)
module use -p /group/peb005/modules
module use -p /group/peb007/modules

```


For using Juliaup create a file in `modules` called `juliaup5`. In this text file add the variables and paths etc etc:
```bash
#%Module1.0

proc ModulesHelp {} {
    puts stderr "put julia 1.10.4 on PATH for [uname machine]."
}

# for module whatis
module-whatis "Adds julia 1.10.4 to PATH"

setenv JULIA_DEPOT_PATH "/group/peb005/.julia"
setenv JULIAUP_DEPOT_PATH "/group/peb005/.julia"

prepend-path PATH "/group/peb005/.juliaup/bin"
```

Save and try by typing  `module load juliaup5` then you can go to `juliaup --help` to look at the menu, `juliaup list` to look at the available versions and use it to install the version you want. E.g. I installed 1.11 the beta verison by typing `juliaup add 1.11`. This installs the exc into the `.julia` folder.

### Creating Julia version modules
In modules create a `julia5` folder and within you create a file called `1.10.4` or whatever verison. In the file you add the path and env variables. E.g. for 1.10.4:

```bash
#%Module1.0

proc ModulesHelp {} {
    puts stderr "put julia 1.10.4 on PATH for [uname machine]."
}

# for module whatis
module-whatis "Adds julia 1.10.4 to PATH"

setenv JULIA_DEPOT_PATH "/group/peb005/.julia"
setenv JULIAUP_DEPOT_PATH "/group/peb005/.julia"

prepend-path PATH "/group/peb005/.julia/juliaup/julia-1.10.4+0.x64.linux.gnu/bin"
prepend-path JULIA_LOAD_PATH "@stdlib"
prepend-path JULIA_LOAD_PATH "@v#.#"
```
To load the module you would type `module load julia5/1.10.4`

---- 
I generated a module that will look through the bin and collect the newest version. You can also use juliaup to set a default version (see --help menu). If you always want the newest version you can add a module file `julia5/latest` with the content:

```bash
#%Module1.0

proc ModulesHelp {} {
    puts stderr "Load the latest version of Julia available in the juliaup directory."
}

# for module whatis
module-whatis "Loads the latest version of Julia available in the juliaup directory."

setenv JULIA_DEPOT_PATH "/group/peb005/.julia"
setenv JULIAUP_DEPOT_PATH "/group/peb005/.julia"

# Use shell command to find the latest version of Julia
set latest_julia_dir [exec bash -c "ls -d /group/peb005/.julia/juliaup/julia-* | sort -V | tail -n 1"]
set julia_bin_dir "$latest_julia_dir/bin"

# Prepend the bin directory of the latest Julia version to the PATH
prepend-path PATH $julia_bin_dir
prepend-path JULIA_LOAD_PATH "@stdlib"
prepend-path JULIA_LOAD_PATH "@v#.#"

# Inform the user of the executable path and version to be loaded
puts stderr "Julia executable path set to: $julia_bin_dir"
puts stderr "To see the version of Julia loaded, run: $julia_bin_dir/julia --version after loading the module."
```
It will echo out the version it found so you know.

## Generating the Chloe module
I think there will be a few Julia modules so I am making a folder for all the julia projects called `/group/peb005/julia_projects/`. 

In this folder clone chloe:
```bash
git clone https://github.com/ian-small/chloe.git /group/peb005/julia_projects/chloe
```
Then we need to instantiate the project to install all the dependencies

```bash
cd chloe
julia --project -e 'using Pkg; Pkg.instantiate()'
```
We also need to download the reference genomes
```bash
git clone https://github.com/ian-small/chloe_references.git
```

The you have to activate the project in julia. Open the REPL
```bash
import Pkg
Pkg.activate(".")
```

You can check the status `Pkg.status(".")`

To clear an environment; unset 


### Creating the module file
In the module folder generate a `chloe5` file for loading the module:

```bash
#%Module1.0

proc ModulesHelp {} {
    puts stderr "put julia 1.10.4 on PATH for [uname machine]."
}

# for module whatis
module-whatis "Adds julia 1.10.4 to PATH and sets up the Chloe project environment."

setenv JULIA_DEPOT_PATH "/group/peb005/.julia"
setenv JULIAUP_DEPOT_PATH "/group/peb005/.julia"
setenv JULIA_PROJECT "/group/peb005/julia_projects/chloe"

prepend-path PATH "/group/peb005/.julia/juliaup/julia-1.10.4+0.x64.linux.gnu/bin"

prepend-path JULIA_LOAD_PATH "/group/peb005/julia_projects/chloe"
prepend-path JULIA_LOAD_PATH "@stdlib"
prepend-path JULIA_LOAD_PATH "@v#.#"
```

Then this can be run like this:

Don't forget to request the julia-compatible nodes

```bash
salloc -N 1 -n 8 -p work -t 2:00:00 --nodelist=n014,n015,n016,n017,n018,n019,n036,n037,n038,n039,n040,n041,n042,n043,n044
```

```bash
julia --project=. -e 'using Chloe; chloe_main()' -- \annotate --reference=/group/peb005/julia_projects/chloe_references /group/peb005/julia_projects/chloe/testfa/NC_020019.1.fa
```
I need to have a more refined way of pointing to the references...Pending
