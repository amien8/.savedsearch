#!/usr/bin/env bash
{ set +x; } 2>/dev/null

! [ -x "${BASH_SOURCE[0]}" ] && ( set -x; chmod +x "${BASH_SOURCE[0]}" )

if [ -t 1 ] && [ -e ~/.command/config.sh ]; then
	{ set -x; . ~/.command/config.sh; { set +x; } 2>/dev/null; }
fi
# standalone .command version of dotfiles.sh.automation
# (not optimized for performance)
cd "${BASH_SOURCE[0]%/*}"
containter="dotfiles"
container_len=$((${#PWD}+1))
function dst() {
	[[ $1 != */* ]] && [[ $1 != .* ]] && return
	[[ "$r" != .* ]] && echo ~/."$r" || echo ~/"$r"
}

if [[ ${PWD##*/} != "$containter" ]]; then
	echo "ERROR: ${BASH_SOURCE[0]##*/} must be executed only from '$containter' folder"; exit 1
fi
src_files="$(find "$PWD" -type f ! -name .DS_Store ! -name $'Icon\r' | sort)"
[[ -z $src_files ]] && echo "SKIP: 0 files" && exit 0

while IFS= read src; do
  	r="${src:$container_len:${#src}}" # relpath
  	dst="$(dst "$r")"
  	[[ -z $dst ]] && continue
  	if ! [ -e "${dst%/*}" ]; then
  		( set -x; mkdir -p "${dst%/*}" ) || exit $?
   	fi
   	if ! [ -e "$dst" ] || [ "$src" -nt "$dst" ]; then
  		{ set -x; cp "$src" "$dst" || exit $?; { set +x; } 2>/dev/null; }
  	fi
done <<< "$src_files"
:
