#!/usr/bin/env bash
{ set +x; } 2>/dev/null

! [ -x "${BASH_SOURCE[0]}" ] && ( set -x; chmod +x "${BASH_SOURCE[0]}" )

if [ -t 1 ] && [ -e ~/.command/config.sh ]; then
	{ set -x; . ~/.command/config.sh; { set +x; } 2>/dev/null; }
fi

name="dotfiles.make"
path=~/.sh.automation/"$name"/run/pwd/run.sh
! [ -e "$path" ] && echo "ERROR: $path NOT EXISTS" && exit 1
{ set -x; cd "${BASH_SOURCE[0]%/*/*}" || exit $?; { set +x; } 2>/dev/null; }
( set -x; $SHELL "$path" )

