# Fixes for common problems

| Problem | Fix |
| --- | --- |
| Typed the password, nothing shows | Normal. SSH shows no dots. Press Enter. |
| "Host identification has changed" | You rebuilt the server. On your laptop: `ssh-keygen -R VPS_IP` |
| Key login still asks for a password | The public key was pasted wrongly. Log in as root again and redo the `authorized_keys` lines from `server-setup.sh`. |
| `apt-get: command not found` | Your server is not Ubuntu or Debian. Check with `cat /etc/os-release` and reinstall it with Ubuntu 24.04. |
| `libatomic.so.1` error during install | `sudo apt-get install -y libatomic1`, then run the installer again. |
| `hermes: command not found` | `source ~/.bashrc`, or log out and back in. |
| `cua-driver` or `libXi.so.6` warning | Optional. Safe to ignore. |
| Desktop: "Hermes not installed on remote host" | Set the Hermes path to `/home/<YOUR_USERNAME>/.local/bin/hermes` |
| Desktop shows no server model or Telegram | Add the server under **Saved connections**, not **This window**. |
| `claude: command not found` | `curl -fsSL https://claude.ai/install.sh \| bash`, then close and reopen the terminal tab. |
| Model shows `provider: "anthropic"` | That one wants an API key. Run `hermes model` and pick Claude Subscription DirectSDK. |
| Bot answers "please set the model" | Settings: set the main model (provider and model), then send `/new` to the bot. |
| Bot log says "Chat not found" | Open the bot in Telegram, press Start, send `hi`. |
| Bot stops when you close the app | `hermes gateway install`, then `hermes gateway start` |
| Gateway is not `active` after a reboot | `systemctl --user is-enabled hermes-gateway` should say `enabled`, and `loginctl show-user <YOUR_USERNAME> -p Linger` should say `Linger=yes`. If not, rerun `hermes gateway install` and `sudo loginctl enable-linger <YOUR_USERNAME>`. |
| Bot goes quiet later | `hermes chat -q "say hello"`, then `hermes doctor`, then `hermes gateway restart` |
| Two bots fight over one token | One bot token works in one place. Stop Hermes on your laptop if the server runs the same bot. |
