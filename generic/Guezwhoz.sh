#!/bin/sh
# Guezwhoz

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "33/33/33"
put_template 1  "e8/51/81"
put_template 2  "7a/d6/94"
put_template 3  "b7/d0/74"
put_template 4  "5a/a0/d6"
put_template 5  "9a/90/e0"
put_template 6  "58/d6/ce"
put_template 7  "d9/d9/d9"
put_template 8  "80/80/80"
put_template 9  "e8/51/81"
put_template 10 "af/d7/af"
put_template 11 "d1/ed/85"
put_template 12 "64/b2/ed"
put_template 13 "a3/98/ed"
put_template 14 "61/ed/e4"
put_template 15 "ed/ed/ed"

color_foreground="d9/d9/d9"
color_background="1d/1d/1d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d9d9d9"
  put_template_custom Ph "1d1d1d"
  put_template_custom Pi "d9d9d9"
  put_template_custom Pj "245354"
  put_template_custom Pk "58d6ce"
  put_template_custom Pl "99d4b1"
  put_template_custom Pm "1d1d1d"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
