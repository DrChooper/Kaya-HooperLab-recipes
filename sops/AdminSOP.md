# Admin Page
This page contains some things for setting up software on kaya for the whole group. In order to access bespoke group modules don't forget to add the path to your `~/.bash_profile`. **It must contain:**

```bash
#connect to group set ups (environments and module packages)
module use -p /group/shooshared/modules
```
This can be substituted for any group you might have this set up.

## Table of Contents
- [Julia Programming](#julia-programming)
- [Anaconda Environments](#anaconda-environments)

---
### Julia Programming
Julia is installed in the root directory of the group and can be updated and reached using modules. Julia versions are managed by `juliaup`. Below for group shooshared with _s for the group module suffix ID. the peb005 and peb007 contain a 5 and 5 respectively.

#### updating julia
1. load in juliaup_s to install versions of julia
```bash
module load juliaup_s
juliaup update #for updating to the newest stable version
which julia #for checking which depot
```

Now you can update or check julia installations using juliaup:
```bash
# See what is installed
juliaup status

# See available channels
juliaup list

# Install Julia 1.11.4
juliaup add 1.11.4

# Make something the default (not sure this is great in a group environment unless we all use the same)
juliaup default 1.11.4
```

2. If you generate a new module file to call a particular version

Create a new file in `/group/shooshared/modules/julia_s/1.11.3` with the version you updated with e.g. `1.11.3`. Then paste the following into the file:

```
#%Module1.0

proc ModulesHelp {} {
    puts stderr "put julia 1.11.3 on PATH for [uname machine]."
}

# for module whatis
module-whatis "Adds julia 1.11.3 to PATH"

setenv JULIA_DEPOT_PATH "/group/shooshared/.julia"
setenv JULIAUP_DEPOT_PATH "/group/shooshared/.julia"

prepend-path PATH "/group/shooshared/.julia/juliaup/julia-1.11.3+0.x64.linux.gnu/bin"
prepend-path JULIA_LOAD_PATH "@stdlib"
prepend-path JULIA_LOAD_PATH "@v#.#"

```
For change the version in the file and the executive filename e.g. `julia-1.11.1+0.x64.linux.gnu` to the correct version. in this case `julia-1.11.3+0.x64.linux.gnu`. Now you can load in the new version using `module load julia_s/1.11.3`


3. update packages from github (e.g. Chloe)

You can install packages into the shared julia version for others to you. E.g. if we all use Chloe then it is in julia 1.11.x 

If you have your bespoke projects that you don't want to put into there I might have to try remember how I did that. This would be important for package development. Maybe... to come.  

```julia
using Pkg
Pkg.rm("Chloe")
Pkg.add(url="https://github.com/ian-small/Chloe.jl")
```
---

### Anaconda Environments
KAYA has micromamba installed in some shared groups (e.g. shooshared). You can add an environment and turn it into a module. The you and everyone in the group can use it. In brief: you activate the micromamba environment and install the package as a new environment. You then purge the micromamba module and create the package module file. The file contains the directive to activate the right conda environemnt and package. Each group has its own "helper" loading in the right shell hooks.

To install:

1. load in micromamba as a module in the group 
Here and example using shooshared and installing a package called [repeatmodeler](https://anaconda.org/bioconda/repeatmodeler)

```bash 
module loade micromamba_s
micromamba create -n repeatmodeler -c conda-forge -c bioconda repeatmodeler
```
Follow the instruction until you see "Transaction finished To activate this environement ....." **!!!Do not initiate the package!** Purge the micromamba module 
```bash
module purge
```

2. generate the module file

The module files are stored in `/group/shooshared/modules/`. Add a text file and copy one of the others across and only change your conda package. You can just do it in VS code in the side bar and copy paste or use command: 

```bash 
touch /group/shooshared/modules/repeatmodeler_s
nano /group/shooshared/modules/repeatmodeler_s
...
```
Then add into the module file the conda environment name and the activator (so micromamba gets activated and the hooks lead to shooshared)
```bash
#%Module1.0
setenv CONDA_DEFAULT_ENV repeatmodeler
module load activate-env_s
```

Then save and exit the file. Now you can load the module and use it on a node. You test with the help menu or a simple call to see if it runs. 

```bash
module load repeatmodeler_s
```

Tadaa! (Hopefully)





