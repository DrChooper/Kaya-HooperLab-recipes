# Interactive Pipeline Development

For pipeline development, use **tmux** together with an **interactive Slurm allocation**. It might be easier to assess what goes wrong while you are running a new pipeline and you are looking at it. Especially testing new modules or different scripts piping in a row.

Best to use a small or dummy data set. Using tmux i really great as this ensures your work continues even if your terminal disconnects.

## 1. Start a tmux session

Create a new session:

```bash
tmux new -s pipeline
```

Detach from the session at any time without stopping your work:

```text
Ctrl+b
d
```

Reconnect later:

```bash
tmux attach -t pipeline
```

List existing sessions:

```bash
tmux ls
```

---

## 2. Request an interactive compute node

From within the tmux session, request compute resources (example below):

```bash
salloc -p work -t 08:00:00 -c 8 --mem=32G
```

options depends on what you need:

* `-p work`
* `-t 08:00:00` – 8 hour allocation
* `-c 8` – 8 CPU cores
* `--mem=32G` – 32 GB RAM

Wait until you see:

```text
salloc: Granted job allocation XXXXX
```

You are now running on a compute node and can develop and test your pipeline interactively.

---

## 3. Load software

Load any required shared modules, for example:

```bash
module purge
module load julia_s/1.11.2
```

or

```bash
module load repeatmodeler_s
```

---

## 4. Useful tmux commands

Detach from the session:

```text
Ctrl+b d
```

Reconnect:

```bash
tmux attach -t pipeline
```

List sessions:

```bash
tmux ls
```

Kill the session when finished ...or type exit:

```bash
tmux kill-session -t pipeline
```
As with slurm scripts you can build slurm flags into the salloc command. Once you are happy with the pipeline you can write a slurm wrapper to call your script or pipeline.