## <img src="../assets/img/HooperLab.png" alt="Hooper Lab Icon" align="right" width="150"> Kaya-HooperLab-Get-Started

### Setting up a good connection

If you're new and have KAYA log-in details, you're in the right place. We recommend [VS Code](https://code.visualstudio.com/) for its compatibility with PC and macOS.

**VS Code** is versatile with many plugins, including the `ssh` extension for secure server connections. Install it via the **Extensions** menu (click the cog icon bottom left). *SSH* (**S**ecure **SH**ell) creates secure "tunnels" to servers in remote locations.


**Connect to KAYA**  
To access KAYA, you **must be connected to UNIconnect** or within the UWA network.  

If you encounter issues with VS Code or want to verify your connection, follow these steps in a terminal (or PowerShell):  

1. Use the log-in details provided and run:  
   ```bash
   ssh username@kaya.hpc.uwa.edu.au
   ```  
   Replace `username` with your actual username.  

2. Enter your temporary password when prompted.  

3. The system may ask if you want to save the server information for future connections. Type `yes`.  

4. You’ll likely need to enter your temporary password again and then create a new password. Follow the prompts to complete this setup.

#### Setting Up a Config File

On your local computer, you can create configurations to quickly access remote servers, like a quick-dial directory. This can also connect to VS Code, enabling you to log in with just a click. Here's how you can organize your server connections in your home directory:

```bash
mkdir -p ~/.ssh             # Create a hidden folder for SSH configurations
chmod 700 ~/.ssh            # Set proper permissions
cd ~/.ssh                   # Navigate to the SSH folder
touch config                # Create a config file
```

The `.ssh` folder can store certificates and other settings. The `config` file is like a phone book, storing server details and nicknames (Hosts) to simplify connections. Here's an example configuration for KAYA; replace `user_name` with your username:

For password-based logins, the config file should include:

```bash
# Default settings for all hosts
Host *
    AddKeysToAgent yes
    UseKeychain yes

# Specific configuration for KAYA
Host kaya
    HostName kaya.hpc.uwa.edu.au
    User user_name  # Replace with your username
    PreferredAuthentications password
```

Once you’re tired of typing passwords, check the next section to set up a key-based login.

#### Switching to SSH Key Setup for New Users

##### **1. Log into the server with your username and password.**  
From your **local machine**, open a terminal and log into Kaya:

```bash
ssh username@kaya
```
Replace `username` with your actual username. Enter your password when prompted.

##### **2. Create the `.ssh` folder on Kaya.**  
Once logged in, ensure the `.ssh` folder exists and set correct permissions. Then exit the server:

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
```

Disconnect from Kaya:

```bash
exit
```

##### **3. Generate SSH Key Pair on your **local machine**.**  
Run the following command on your **local machine** in your terminal:

```bash
ssh-keygen -t ed25519 -C "your_username@kaya" -f ~/.ssh/kaya_key
```

- **Files created:**
  - **Private key**: `~/.ssh/kaya_key` (keep this secure, do not share).
  - **Public key**: `~/.ssh/kaya_key.pub`.

##### **4. Copy the Public Key to Kaya.**  
Use the following command (**on your local machine**) to append your **public key** to `authorized_keys` on Kaya:

```bash
ssh-copy-id -i ~/.ssh/kaya_key.pub username@kaya
```

##### **5. Test Key-Based Authentication.**  
Log in again, this time without entering your password:

```bash
ssh username@kaya
```

##### **6. Update SSH Config for Convenience.**  
Modify your local `~/.ssh/config` file to automate key-based authentication:

```bash
Host *
    AddKeysToAgent yes
    UseKeychain yes

Host kaya
    HostName kaya.hpc.uwa.edu.au
    User your_username  # replace with your username
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/kaya_key  # Reference private key
```

---

Now you're set up for password-less SSH connections.

#### Connect VS code to your config
This is where it all comes together. You can connect VS code to your config once and then you can add many many servers by just adding the key and 'telephone' entry into your config file. 

Find instructions on how to install remote ssh and connect VS code [here](https://code.visualstudio.com/blogs/2019/10/03/remote-ssh-tips-and-tricks). In short: 

In VS code go to the arrow on the left bottom corner and choose `ssh remote - open ssh config file`. Make sure it is connected to the right config file. In future you can connect to host and your servers saved in the config file will appear directly in the drop down menu. 

### Making Yourself at Home

#### Key Directories on Kaya

- **`/home/user_name`**  
  Your personal home directory. Use it sparingly for small files like configuration and connection settings. Avoid storing large files or data here.

- **`/group/peb005/`**  
  The main workspace for your group. It houses software, raw data, and intermediate results. **Important:** Ensure critical data is backed up elsewhere, as this is not a permanent storage solution.  

  - **`/group/peb005/user_name`**:  
    Your private folder. Only you can access this. Be cautious with file permissions when moving files to shared areas as each file has only your permission to view.

  - **`/group/peb005/data/`**:  
    Shared space for raw data and group-accessible results.
  - **`/group/peb005/projects/`**:  
    Shared space for work in progress form your project and hand over once you have finished.

- **`/scratch/peb005/`**  
  Temporary storage for processing files. **Not for long-term storage.** Move or delete files promptly after processing.


#### Connecting Folders

##### **`.kaya_env.sh`**

This hidden file stores user-defined environment variables, serving as shortcuts to frequently used directories. By default, it points to your group and scratch folders.

When opened (e.g., in VSCode), it might look like this:

```bash
export KAYA_PROJECT="peb005"
export MYGROUP="/group/peb005/username"
export MYSCRATCH="/scratch/peb005/username"
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=2000
export PS1='${CONDA_PROMPT_MODIFIER}\[\e[32m\]\u\[\e[m\]@\h[\[\e[36m\]\W\[\e[m\]]\$ '
```

You can add custom shortcuts, like:

```bash
export DATA="/group/peb005/data"
export PROJECTS="/group/peb005/projects"
```

Save and apply changes by either restarting your terminal or running:

```bash
source ~/.kaya_env.sh
```

### Connecting to Group Modules

Easily access group-specific software by linking your profile to group installations. 

#### **Steps:**

1. Open your **`~/.bash_profile`** in your home directory and ensure it includes:  

   ```bash
   # Kaya environment file
   if [ -f ~/.kaya_env.sh ]; then
   . ~/.kaya_env.sh
   fi
   if [ -f ~/.bashrc ]; then
   . ~/.bashrc
   fi
   ```

2. Add the path to your group's modules:

   ```bash
   # Connect to group environments and modules
   module use -p /group/peb005/modules
   ```

3. Save the file and refresh your environment:

   ```bash
   source ~/.bash_profile
   ```

---

You're all set—time to compute! 🚀