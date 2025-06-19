# GrenadeLauncher
Armora Server Environtment launcher for deploying all server

---


## README.md: Armora Server Environment Setup Guide

Hey there! This guide walks you through setting up a server infrastructure for the **Armora Server Environment**. We'll cover cloning the repository, downloading OS ISOs, installing a plethora of less common frameworks, and running an installation script.

### Important Disclaimer!

---

**Please read this carefully before proceeding.**

**This setup guide describes a highly experimental and undefined testing environment. It is provided for informational and educational purposes only. The software, scripts, and configurations detailed herein are not guaranteed to be stable, secure, or fit for any particular purpose. Running commands with `sudo` and installing lesser-known frameworks can introduce significant security vulnerabilities and system instability. YOU ARE SOLELY RESPONSIBLE FOR ANY DAMAGE, DATA LOSS, OR OTHER ISSUES THAT MAY ARISE FROM FOLLOWING THESE INSTRUCTIONS. PROCEED AT YOUR OWN RISK. THE AUTHOR AND CONTRIBUTORS OF THIS GUIDE ACCEPT NO RESPONSIBILITY OR LIABILITY FOR ANYTHING THAT OCCURS AS A RESULT OF ITS USE.**

---

### Introduction

This document outlines the steps to build a specialized server environment designed to support the Armora project. It aims to provide a sandbox for exploring unique technology stacks and configurations that might not be found in typical server deployments. The focus is on incorporating diverse operating systems and less commonly adopted programming frameworks to push the boundaries of conventional server infrastructure.

### License Information

**This software and its accompanying code are proprietary. All rights are reserved.**

**The use, reproduction, distribution, or modification of this code is strictly prohibited without explicit written permission from the copyright holder.** This `README.md` and the associated scripts are provided for review purposes only, specifically to demonstrate code safety and functionality. **DO NOT ATTEMPT TO RUN OR DEPLOY THIS CODE WITHOUT PROPER AUTHORIZATION.**

For detailed licensing terms, please refer to the `LICENSE.txt` file in the root directory of this project.

### Initial Preparations

Before you dive in, ensure you have a stable internet connection and sufficient disk space.

---

### Step 0: Clone the Repository

First things first, you need to clone this repository to get all the necessary files, including the `install.sh` script and the `LICENSE.txt` file.

```bash
git clone https://github.com/Armora-Security/GrenadeLauncher.git
cd GrenadeLauncher
```

---

### Step 1: Download Operating System ISOs

We'll grab a few OS ISOs for our experimental setup. Pick one or several based on your needs:

* **Ubuntu Server LTS (Long Term Support)**: A solid choice for servers with long-term support.
    ```bash
    # Example: Downloading Ubuntu 22.04 LTS Server
    wget https://releases.ubuntu.com/jammy/ubuntu-22.04.4-live-server-amd64.iso -P ~/Downloads/ISO/
    ```
* **Debian Netinst**: Lightweight and flexible for minimal installations.
    ```bash
    # Example: Downloading Debian 12 (Bookworm) Netinst
    wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.6.0-amd64-netinst.iso -P ~/Downloads/ISO/
    ```
* **Alpine Linux**: Extremely lightweight, ideal for containers or minimalist environments.
    ```bash
    # Example: Downloading Alpine Linux Standard
    wget https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-standard-3.20.0-x86_64.iso -P ~/Downloads/ISO/
    ```
* **FreeBSD**: If you want to explore a BSD-based OS.
    ```bash
    # Example: Downloading FreeBSD 14.0 RELEASE
    wget https://download.freebsd.org/ftp/releases/VM-IMAGES/14.0-RELEASE/amd64/VIRTUALBOX/FreeBSD-14.0-RELEASE-amd64.vmdk.xz -P ~/Downloads/ISO/
    # Note: This is a VMDK image, not a direct ISO. It can be imported into VirtualBox.
    ```

**Tip**: Create a dedicated directory for your ISOs: `mkdir -p ~/Downloads/ISO/`

---

### Step 2: Install Esoteric Frameworks and Languages

For an advanced challenge, we'll install several programming languages and frameworks that are far from mainstream, offering unique paradigms and limited community support. This is where things get truly experimental!

#### A. **Crystal Language**

Crystal is a compiled language inspired by Ruby, offering performance comparable to C.

1.  **Install Dependencies:**
    ```bash
    sudo apt update
    sudo apt install -y libssl-dev libyaml-dev libgmp-dev libreadline-dev libffi-dev
    ```
2.  **Add Key and Repository:**
    ```bash
    curl -fsSL https://dist.crystal-lang.org/apt/setup.sh | sudo bash
    ```
3.  **Install Crystal:**
    ```bash
    sudo apt install -y crystal
    ```
4.  **Verify Installation:**
    ```bash
    crystal -v
    ```

#### B. **Elixir with Phoenix Framework**

Elixir is a functional language running on the Erlang VM, excellent for distributed systems. Phoenix is its web framework.

1.  **Install Erlang (via `asdf` version manager for flexibility):**
    ```bash
    # Install asdf if not already installed
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
    echo ". \"$HOME/.asdf/asdf.sh\"" >> ~/.bashrc
    echo ". \"$HOME/.asdf/completions/asdf.bash\"" >> ~/.bashrc
    source ~/.bashrc

    # Add Erlang and Elixir plugins
    asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
    asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git

    # Install Erlang (latest version)
    asdf install erlang latest
    asdf global erlang latest

    # Install Elixir (latest version)
    asdf install elixir latest
    asdf global elixir latest
    ```
2.  **Install Phoenix (if Elixir is installed):**
    ```bash
    mix local.hex --force
    mix archive.install hex phx_new 1.7.12 --force # Adjust to a recent Phoenix version
    ```
3.  **Verify Installation:**
    ```bash
    elixir -v
    mix phx.new --version
    ```

#### C. **Nim Language**

Nim is a statically typed, compiled language that offers the power of C/C++ with a Python-like syntax.

1.  **Install Nimble (Nim's package manager) and Nim:**
    ```bash
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh
    source ~/.nimble/bin/choosenim.sh # Add this to your shell profile (~/.bashrc or ~/.zshrc)
    choosenim update stable
    ```
2.  **Verify Installation:**
    ```bash
    nim -v
    ```

#### D. **Pony Language**

Pony is an actor-model, capability-secure, object-oriented, type-safe, and memory-safe language with garbage collection that doesn't stop the world. Very unique!

1.  **Install Dependencies:**
    ```bash
    sudo apt update
    sudo apt install -y build-essential libssl-dev libncurses-dev
    ```
2.  **Download and Build from Source (preferred method for latest stable):**
    ```bash
    git clone https://github.com/ponylang/ponyc.git
    cd ponyc
    make
    sudo make install # Installs to /usr/local/bin
    cd ..
    ```
3.  **Verify Installation:**
    ```bash
    ponyc --version
    ```

#### E. **Hare Language**

Hare is a new systems programming language that is designed to be simple, stable, and performant. It's relatively young and highly opinionated.

1.  **Install Dependencies:**
    ```bash
    sudo apt update
    sudo apt install -y build-essential bison flex libssl-dev
    ```
2.  **Clone and Build from Source:**
    ```bash
    git clone https://git.sr.ht/~sircmpwn/hare
    cd hare
    make
    sudo make install
    cd ..
    ```
3.  **Verify Installation:**
    ```bash
    hare version
    ```

#### F. **Racket Language**

Racket is a multi-paradigm, general-purpose Lisp-family language. It's incredibly powerful for language creation and complex systems, but less common for typical server apps.

1.  **Install Racket (via `asdf` for version management):**
    ```bash
    # Ensure asdf is installed (see Elixir section)
    asdf plugin add racket https://github.com/asdf-community/asdf-racket.git
    asdf install racket latest
    asdf global racket latest
    ```
2.  **Verify Installation:**
    ```bash
    racket --version
    ```

---

### Step 3: Run the `install.sh` Script

**IMPORTANT: Before proceeding, ensure you have reviewed and fully understand the contents of the `install.sh` script. This script can significantly modify your system. Given its proprietary nature, we cannot display its content here. Verify its safety and purpose before execution.**

**How to Run the Script:**

1.  **Ensure the `install.sh` file is present** in your working directory (which it will be if you cloned the repo).
2.  **Grant execute permissions** to the script:
    ```bash
    chmod +x install.sh
    ```
3.  **Execute the script** with `sudo`:
    ```bash
    sudo ./install.sh
    ```

---

### Post-Installation

* **Reboot your system** after running `install.sh` to ensure all changes, especially user additions to the Docker group, take effect.
* **Verify installations** of Nginx, Docker, and the various languages/frameworks using their respective version commands (e.g., `nginx -v`, `docker run hello-world`, `crystal -v`, `elixir -v`, `nim -v`, `ponyc --version`, `hare version`, `racket --version`).
* **Further explore** by creating sample projects using the installed frameworks. Dive deep into their unique features and see how they fit into your experimental Armora environment.

---
