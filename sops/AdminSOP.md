# Admin Page
This page contains some things for setting up software on kaya for the whole group

## Table of Contents
- [Julia Programming](#julia-programming)
- [Anaconda Environments](#anaconda-environments)

---
### Julia Programming
Julia is installed in the root directory of the group and can be updated and reached using modules. Julia versions are managed by `juliaup`. Below for group peb007. Substitute 7 with 5 for updating peb005.

#### updating julia
1. load in juliaup7 to update the modules
```bash
module load juliaup7
juliaup update #for updating to the newest stable version
juliaup status #for checking the current status
which julia #for checking which depot
```

2. generate a new module file
Create a new file in `peb007/modules/julia7/` with the version you updated with e.g. `1.11.3`. Then paste the following into the file:

```
#%Module1.0

proc ModulesHelp {} {
    puts stderr "put julia 1.13 on PATH for [uname machine]."
}

# for module whatis
module-whatis "Adds julia 1.13 to PATH"

setenv JULIA_DEPOT_PATH "/group/peb007/.julia"
setenv JULIAUP_DEPOT_PATH "/group/peb007/.julia"

prepend-path PATH "/group/peb007/.julia/juliaup/julia-1.11.3+0.x64.linux.gnu/bin"
```
For change the version in the file and the executive filename e.g. `julia-1.11.1+0.x64.linux.gnu` to the correct version. in this case `julia-1.11.3+0.x64.linux.gnu`. Now you can load in the new version using `module load julia7/1.11.3`


3. update packages from github (e.g. Chloe)
```julia
using Pkg
Pkg.rm("Chloe")
Pkg.add(url="https://github.com/ian-small/Chloe.jl")
```
---

### Anaconda Environments
Kaya has micromamba installed in both groups. You can add an environment and plub it into the modules.

