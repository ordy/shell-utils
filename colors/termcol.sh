rgbtohex () {
  # usage) `rgbtohex 17 0 26` ==> 1001A
  # usage) `rgbtohex -h 17 0 26` ==> #1001A
  addleadingzero () { awk '{if(length($0)<2){printf "0";} print $0;}';}
  if [[ ${1} == "-h" ]]; then
    r=${2}; g=${3}; b=${4};h='#';
  else
    r=${1}; g=${2}; b=${3};h='';
  fi
  r=`echo "obase=16; ${r}" | bc | addleadingzero`
  g=`echo "obase=16; ${g}" | bc | addleadingzero`
  b=`echo "obase=16; ${b}" | bc | addleadingzero`
  echo "${h}${r}${g}${b}"
}

rgbto256 () {
  # usage: `rgbto256 0 95, 135` ==> 22
  echo "define trunc(x){auto os;os=scale;scale=0;x/=1;scale=os;return x;};" \
    "16 + 36 * trunc(${1}/51) + 6 * trunc(${2}/51) +" \
    " trunc(${3}/51)" | bc
  # XTerm Color Number = 16 + 36 * R + 6 * G + B | 0 <= R,G,B <= 5
}

hextorgb () {
  # usage) `hexttorgb "11001A" ==> 17 0 26
  # usage) `hexttorgb "#11001A" ==> 17 0 26
  hexinput=`echo ${1} | tr '[:lower:]' '[:upper:]'`  # uppercase-ing
  hexinput=`echo ${hexinput} | tr -d '#'`          # remove Hash if needed
  a=`echo ${hexinput} | cut -c-2`
  b=`echo ${hexinput} | cut -c3-4`
  c=`echo ${hexinput} | cut -c5-6`
  r=`echo "ibase=16; ${a}" | bc`
  g=`echo "ibase=16; ${b}" | bc`
  b=`echo "ibase=16; ${c}" | bc`
  echo ${r} ${g} ${b}
}

trueHexPrint () {
  # Generates Truecolor Escape Sequences from Hex Strings. (remove '\\' to use)
  # -fg     Prints as a foreground color. (default)
  # -bg     Prints as a background color.
  # usage) `trueHexPrint -fg "11001A" ==> '\e[38;2;17;0;26m'
  # usage) `trueHexPrint -bg "11001A" ==> '\e[48;2;17;0;26m'
  if [[ ${1} =~ "-fg" || ${1} =~ "-f" ]]; then
    fgbg=38; hexinput=${2};
  elif [[ ${1} =~ "-bg" || ${1} =~ "-b" ]]; then
    fgbg=48; hexinput=${2};
  else
    fgbg=38; hexinput=${1}
  fi
  hexinput=`echo ${hexinput} | tr '[:lower:]' '[:upper:]'`  # uppercase-ing
  hexinput=`echo ${hexinput} | tr -d '#'`               # remove Hash if needed
  a=`echo ${hexinput} | cut -c-2`
  b=`echo ${hexinput} | cut -c3-4`
  c=`echo ${hexinput} | cut -c5-6`
  r=`echo "ibase=16; ${a}" | bc`
  g=`echo "ibase=16; ${b}" | bc`
  b=`echo "ibase=16; ${c}" | bc`
  printf "\\\\e[${fgbg};2;${r};${g};${b}m" # Remove one set of '\\' to utilize
}

XColorTable () {
  i=16
  for ((r = 0; r <= 255; r+=40)); do # Do Tricolor
    for ((g = 0; g <= 255; g+=40)); do
      for ((b = 0; b <= 255; b+=40)); do
    echo "Color$((i++)) = (${r}, ${g}, ${b})"
        if ((b == 0)); then b=55; fi
      done
      if ((b == 0)); then g=55; fi
    done
    if ((r == 0)); then r=55; fi
  done
  for ((m = 8; m <= 238; m+=10)); do # Do Monochrome
    echo "Color$((i++)) = (${m}, ${m}, ${m})"
  done
}

XColorTable
