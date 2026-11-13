# Step 2: a safe user for Hermes Agent
#
# Run this ONCE, on the server, logged in as root (ssh root@VPS_IP).
# Tested on Ubuntu 24.04. Ubuntu 22.04 and Debian 12 should work the same.
# Not for AlmaLinux, Rocky, Fedora or CentOS (they have no apt-get or ufw).
#
# 1. Replace <YOUR_USERNAME> with the user name you want, for example hermes. Pick it now, renaming later is painful.
# 2. Replace <YOUR_PUBLIC_KEY> with your public key, the line that starts with ssh-ed25519.
#    Keep the quotes. Never paste your private key.
# 3. Paste the whole block into the root terminal.
# 4. The last line asks for a password for the new user, twice. Nothing shows while you type.

USERNAME=<YOUR_USERNAME>
PUBKEY='<YOUR_PUBLIC_KEY>'

apt-get update && apt-get -y upgrade                                          # update the server
apt-get install -y libatomic1 curl git ufw                                    # small tools; libatomic1 is needed by the Hermes installer
adduser --disabled-password --gecos "" $USERNAME                              # a normal user, no password login
usermod -aG sudo $USERNAME                                                    # allow admin commands with sudo
install -d -m 700 -o $USERNAME -g $USERNAME /home/$USERNAME/.ssh              # the user's key folder
echo "$PUBKEY" > /home/$USERNAME/.ssh/authorized_keys                         # your key is the door key
chown $USERNAME:$USERNAME /home/$USERNAME/.ssh/authorized_keys
chmod 600 /home/$USERNAME/.ssh/authorized_keys
ufw allow OpenSSH                                                             # keep the SSH door open
ufw --force enable                                                            # close every other door
loginctl enable-linger $USERNAME                                              # keep things running after you log out
passwd $USERNAME                                                              # a password for sudo only

# Next: open a NEW terminal on your laptop and run  ssh <YOUR_USERNAME>@VPS_IP
# It should log you in with no password. Then type exit in the root window.
