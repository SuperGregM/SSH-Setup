#!/usr/bin/env bash
# shellcheck disable=SC2034  # Unused variables left for readability

set -e # -e: exit on error

##################################################################################################################
# tput Text Colors

#tput setaf 0 = Black
#tput setaf 1 = Dark Red                    Warning
#tput setaf 2 = Dark Green                  Command Completed
#tput setaf 3 = Dark Yellow                 Recommended Commands / Extras
#tput setaf 4 = Dark Blue
#tput setaf 5 = Dark Magenta/Dark Pink
#tput setaf 6 = Dark Cyan                   Info Needs
#tput setaf 7 = Dark White/Light Grey
#tput setaf 8 = Light Black/Dark Grey
#tput setaf 9 = Light Red                   Warning
#tput setaf 10 = Light Green                Command Completed
#tput setaf 11 = Light Yellow               Recommended Commands / Extras
#tput setaf 12 = Light Blue
#tput setaf 13 = Light Magenta/Light Pink
#tput setaf 14 = Light Cyan                 Info Needs
#tput setaf 15 = Light White

# tput sgr0 = reset color

# tput setaf 1; echo "This text is Dark Red."; tput sgr0

##################################################################################################################
# printf Colors and Formats

# General Formatting
FORMAT_RESET="\x1B[0m"
FORMAT_BRIGHT="\x1B[1m"
FORMAT_DIM="\x1B[2m"
FORMAT_ITALICS="\x1B[3m"
FORMAT_UNDERSCORE="\x1B[4m"
FORMAT_BLINK="\x1B[5m"
FORMAT_REGULAR="\x1B[6m"
FORMAT_REVERSE="\x1B[7m"
FORMAT_HIDDEN="\x1B[8m"

# Foreground Colors
TEXT_BLACK="\x1B[30m"
TEXT_RED="\x1B[31m"    #Warning
TEXT_GREEN="\x1B[32m"  #Command Completed
TEXT_YELLOW="\x1B[33m" #Recommended Commands / Extras
TEXT_BLUE="\x1B[34m"
TEXT_MAGENTA="\x1B[35m"
TEXT_CYAN="\x1B[36m" #Info Needs
TEXT_WHITE="\x1B[37m"

# Background Colors
BACKGROUND_BLACK="\x1B[40m"
BACKGROUND_RED="\x1B[41m"
BACKGROUND_GREEN="\x1B[42m"
BACKGROUND_YELLOW="\x1B[43m"
BACKGROUND_BLUE="\x1B[44m"
BACKGROUND_MAGENTA="\x1B[45m"
BACKGROUND_CYAN="\x1B[46m"
BACKGROUND_WHITE="\x1B[47m"

# printf "$TEXT_RED\n%s\n$FORMAT_RESET" "This text is Dark Red."

##################################################################################################################

# * ArchLinux OpenSSH Setup

# * Test if the script needs sudo
printf "$TEXT_GREEN\n%s\n$FORMAT_RESET" "Checking if needs sudo"
sudo_if_user() {
    if [ "$(id -u)" -ne 0 ]; then
        sudo "$@"
    else
        "$@"
    fi
}

# * Install OpenSSH
printf "$TEXT_GREEN\n%s\n$FORMAT_RESET" "Installing OpenSSH"
sudo_if_user pacman -Syyu openssh --needed --noconfirm

# * Setup SSH config
printf "$TEXT_GREEN\n%s\n$FORMAT_RESET" "Setting up SSH config"
ssh_config_path="/etc/ssh/sshd_config.d"
ssh_config_file="${ssh_config_path}/000-Personal-Settings.conf"
if [ ! -d "${ssh_config_path}" ]; then
    printf "$TEXT_RED\n%s\n$FORMAT_RESET" "SSH config path $ssh_config_path does not exist"
    printf "$TEXT_RED\n%s\n$FORMAT_RESET" "Exiting"
    exit 1
else
    if [ ! -d "${ssh_config_file}" ]; then
        printf "$TEXT_GREEN\n%s\n$FORMAT_RESET" "Setup SSH conf file"
        sudo_if_user cat <<EOF >"${ssh_config_file}"
# Personal SSH config

# Enable root login
PermitRootLogin yes
# Enable password authentication
PasswordAuthentication yes
# Enable public key authentication
PubkeyAuthentication yes

EOF
    fi
fi

# * Enable SSH service
printf "$TEXT_GREEN\n%s\n$FORMAT_RESET" "Enabling SSH service"
sudo_if_user systemctl enable --now sshd.service

# * Comment out remote-login.sh for SSH connections
# run remote-login.sh on ssh connection
# if [[ -z "${STY}" && -n "${SSH_TTY}" && "$(grep -w 'archboot' /etc/hostname)" ]]; then
#     /usr/bin/remote-login.sh
#     exit 0
# fi

# /etc/profile.d/custom-bash-options.sh

if [ -f "/etc/profile.d/custom-bash-options.sh" ]; then
    printf "$TEXT_GREEN\n%s\n$FORMAT_RESET" "Commenting out remote-login.sh on ssh connection"
    awk '
          BEGIN { block=0 }
          /^# run remote-login\.sh on ssh connection$/ { block=1 }
          block && /^fi$/ { print "#" $0; block=0; next }
          block { print "#" $0; next }
          { print }
      ' "/etc/profile.d/custom-bash-options.sh" >"/etc/profile.d/arch_boot_ssh_bug"
    sudo_if_user mv "/etc/profile.d/arch_boot_ssh_bug" "/etc/profile.d/custom-bash-options.sh"
fi
