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

