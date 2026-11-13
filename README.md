# Hermes Agent on a VPS: every command

[![Watch the video](https://img.youtube.com/vi/KQLWece-zpI/maxresdefault.jpg)](https://youtu.be/KQLWece-zpI)

The companion files for my video **Install Hermes Agent on Any VPS, Fast (Runs 24/7)**.

Six steps from a fresh Ubuntu server to a Hermes Agent you talk to on Telegram, that keeps running when your laptop is closed.

- Video: [youtu.be/KQLWece-zpI](https://youtu.be/KQLWece-zpI)
- Full written guide, with what every command means: [stackagen.com/guides/hermes-agent-vps-install](https://stackagen.com/guides/hermes-agent-vps-install)
- Next step after the install: [Hermes Agent 7 levels setup](https://github.com/stackagen/hermes-agent-7-levels-setup)

> Watch the video or read the guide first. This repo holds the commands you paste, not the walkthrough.

## What's in this repo

```
commands.md          every command from the video, in order, marked LAPTOP or SERVER
server-setup.sh      the Step 2 block you paste as root (safe user, key, firewall)
troubleshooting.md   fixes for the problems people hit most
```

## What you need

- A Linux server with Ubuntu 24.04. I use 2 vCPUs and 4 GB of memory. Ubuntu 22.04 or Debian 12 use the same commands, but I only tested 24.04.
- A laptop with a terminal (PowerShell on Windows, Terminal on Mac or Linux).
- [Hermes Desktop](https://hermes-agent.nousresearch.com/) on your laptop.
- Telegram on your phone.
- An AI plan or API key. I use a Claude plan. OpenAI, Google, OpenRouter, your own key and local models work too.

## The six steps

1. **Server.** Order a VPS with Ubuntu 24.04. Save the IP address and the root password from the email.
2. **Safe user.** Make an SSH key on your laptop, log in as root once, paste [`server-setup.sh`](server-setup.sh) with your user name and public key filled in.
3. **Install.** As your new user:
   ```bash
   curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- --non-interactive
   source ~/.bashrc
   hermes --version
   ```
4. **Desktop.** Settings > Gateways > Saved connections > Add connection > SSH. Host `<YOUR_USERNAME>@VPS_IP:22`.
5. **Brain and Telegram.** Install a model provider, set the main model, then Messaging > Telegram > Quick setup with the QR code.
6. **Always on.** In the Desktop terminal:
   ```bash
   hermes gateway install
   hermes gateway start
   ```

The details for every step are in [`commands.md`](commands.md).

## Before you rely on it

- **Never share your private key** (the key file without `.pub`), your root password or your server IP.
- **Allowed users.** Hermes can run commands on your server. Keep the Telegram allowed users list to yourself.
- **Set the main model before Telegram**, or the bot replies asking you to set the model.
- **Root login is still on** after this setup. Turn it off only after you have tested a second key login, or you can lock yourself out.

Last checked: 13 November 2026, Hermes Agent v0.23.1 on Ubuntu 24.04.5 LTS. Hermes changes fast. If something looks different, check `hermes --version` first.

## Docs

- [Hermes Agent documentation](https://hermes-agent.nousresearch.com/docs/)
- [Telegram in Hermes](https://hermes-agent.nousresearch.com/docs/user-guide/messaging/telegram)
- [Claude Code setup](https://code.claude.com/docs/en/setup)

## Questions

Leave a comment on the video. It's the fastest way to reach me, and it helps the next person who hits the same problem.
