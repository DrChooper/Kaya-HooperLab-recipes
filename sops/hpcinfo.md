# Checking Partitions, Nodes and System Information

To see what partitions and nodes are available and check the architecture of the system.

## Available partitions

List all partitions and their status:

```bash
sinfo

#or short 
sinfo -s
```

this will  show you:
```bash
PARTITION    AVAIL  TIMELIMIT  NODES  STATE NODELIST
ondemand        up   12:00:00      1    mix k011
ondemand-gpu    up   12:00:00      3   mix- k[028-029,035]
ondemand-gpu    up   12:00:00      1    mix k041
ondemand-gpu    up   12:00:00     12  alloc k[026,030-034,036-040,042]
amdgpu          up 3-00:00:00      2    mix k[014-015]
work*           up 3-00:00:00      3    mix k[001,008,010]
work*           up 3-00:00:00      9  alloc k[002-007,009,012-013]
gpu             up 3-00:00:00      3   mix- k[028-029,035]
gpu             up 3-00:00:00      1    mix k041
gpu             up 3-00:00:00     13  alloc k[026-027,030-034,036-040,042]
```
From what HPC staff tells me the nodes are all julia compatible. It also tells you the max time you can request it for.

## Available nodes

Display node information:
```bash
#for example k009
scontrol show node k009
```

Shows you:
```bash
NodeName=k009 Arch=x86_64 CoresPerSocket=48 
   CPUAlloc=96 CPUEfctv=96 CPUTot=96 CPULoad=95.78
   AvailableFeatures=(null)
   ActiveFeatures=(null)
   Gres=(null)
   NodeAddr=k009 NodeHostName=k009 Version=24.11.5
   OS=Linux 5.14.0-503.38.1.el9_5.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Apr 16 16:38:39 UTC 2025 
   RealMemory=1544000 AllocMem=1048576 FreeMem=459956 Sockets=2 Boards=1
   MemSpecLimit=2000
   State=ALLOCATED ThreadsPerCore=1 TmpDisk=0 Weight=10 Owner=N/A MCS_label=N/A
   Partitions=work 
   BootTime=2026-02-10T11:34:28 SlurmdStartTime=2026-06-11T13:17:17
   LastBusyTime=2026-06-11T15:59:29 ResumeAfterTime=None
   CfgTRES=cpu=96,mem=1544000M,billing=96
   AllocTRES=cpu=96,mem=1T
   CurrentWatts=0 AveWatts=0
```
*"So this one has 1.5TB RAM....that is a bit nice..."*


You can ask for specific nodes in your slurm but I haven't since they all work with julia.

## CPU architecture

Check the architecture and processor details of the current node (once you have been granted a node using `salloc`)

```bash
lscpu
```


