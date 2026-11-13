# Every command, in order

`VPS_IP` is your server's IP address from the provider's email. `<YOUR_USERNAME>` is the user name you pick in Step 2 (I used `hermes`). Replace both with your own.

**LAPTOP** = the terminal on your computer. **SERVER** = a terminal logged in to the server. **DESKTOP TERMINAL** = the terminal inside Hermes Desktop (`Ctrl+P` or `Cmd+P`, search "terminal"). It also runs on the server.

## Step 1: Server

No commands. Order a VPS with Ubuntu 24.04 and save two things from the email: the IP address and the root password.

## Step 2: Safe user

Make a key. LAPTOP, same on Windows, Mac and Linux:

```bash
ssh-keygen -t ed25519 -C "my-laptop"
```

Press Enter three times. If it asks `Overwrite (y/n)?`, type `n` and use the key you already have.

Show the public key and copy the whole line:

```powershell
# LAPTOP, Windows PowerShell
type $env:USERPROFILE\.ssh\id_ed25519.pub
```

```bash
# LAPTOP, Mac and Linux
cat ~/.ssh/id_ed25519.pub
```

Log in as root (type `yes` the first time, then the root password, nothing shows while you type):

```bash
# LAPTOP
ssh root@VPS_IP
```

Paste the block from [`server-setup.sh`](server-setup.sh) with your public key filled in. SERVER, as root:

```bash
USERNAME=<YOUR_USERNAME>
PUBKEY='<YOUR_PUBLIC_KEY>'

apt-get update && apt-get -y upgrade
apt-get install -y libatomic1 curl git ufw
adduser --disabled-password --gecos "" $USERNAME
usermod -aG sudo $USERNAME
install -d -m 700 -o $USERNAME -g $USERNAME /home/$USERNAME/.ssh
echo "$PUBKEY" > /home/$USERNAME/.ssh/authorized_keys
chown $USERNAME:$USERNAME /home/$USERNAME/.ssh/authorized_keys
chmod 600 /home/$USERNAME/.ssh/authorized_keys
ufw allow OpenSSH
ufw --force enable
loginctl enable-linger $USERNAME
passwd $USERNAME
```

Open a new terminal and log in as your user. No password should be asked:

```bash
# LAPTOP
ssh <YOUR_USERNAME>@VPS_IP
```

Then type `exit` in the root window. You don't need root again.

## Step 3: Install Hermes Agent

SERVER, as your user:

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- --non-interactive
source ~/.bashrc
hermes --version
```

## Step 4: Hermes Desktop

No commands. In the app: **Settings > Gateways > Saved connections > Add connection > SSH**.

| Field | Value |
| --- | --- |
| Name | anything, for example `hermes` |
| SSH host | `<YOUR_USERNAME>@VPS_IP:22` |
| Hermes path | blank (auto-detect). If the app says Hermes is not found: `/home/<YOUR_USERNAME>/.local/bin/hermes` |

Save, make it primary, press **Test SSH**, then pick it in the gateway picker at the bottom left.

## Step 5: Brain and Telegram

In the app: **Capabilities > Plugins**, install and enable **Claude Subscription DirectSDK**. (Skip this part if you use another provider.)

DESKTOP TERMINAL:

```bash
claude --version                              # is Claude Code on the server?
curl -fsSL https://claude.ai/install.sh | bash   # install it if not
claude auth login                             # open the link, sign in, paste the code back
```

Then **Settings**: set the main model (provider **Claude Subscription DirectSDK**, then the model) and apply.

Telegram: **Messaging > Telegram > Quick setup**. Scan the QR code with your phone camera, name the bot, connect. Check that allowed users shows only your ID, then **Save and restart**.

## Step 6: Always on

DESKTOP TERMINAL:

```bash
hermes gateway install      # answer Y to both questions
hermes gateway start
systemctl --user is-active hermes-gateway    # should say: active
```

Close the app, close the laptop, and message your bot from your phone.

## If the bot goes quiet later

SERVER or DESKTOP TERMINAL, in this order:

```bash
hermes chat -q "say hello"    # does the brain answer at all?
hermes doctor                 # general health check
hermes gateway restart        # restart the Telegram part
```
