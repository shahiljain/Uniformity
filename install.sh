#! /usr/bin/env bash

ROOT_UID=0
DEST_DIR=

# Destination Directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.local/share/icons"
fi

SRC_DIR="$(cd "$(dirname "$0")" && pwd)"

THEME_NAME=Uniformity
THEME_VARIANTS=('' '-Purple' '-Pink' '-Red' '-Orange' '-Yellow' '-Green' '-Teal' '-Grey')
SCHEME_VARIANTS=('' '-Catppuccin')

themes=()
schemes=()

usage() {
cat << EOF
  Usage: $0 [OPTION]...

  OPTIONS:
    -d, --dest DIR          Specify destination directory (Default: $DEST_DIR)
    -n, --name NAME         Specify theme name (Default: $THEME_NAME)
    -t, --theme VARIANTS    Specify folder color theme variant(s) [default|purple|pink|red|orange|yellow|green|teal|grey|all] (Default: blue)
    -s, --scheme VARIANTS   Specify folder colorscheme variant(s) [default|catppuccin|all]
    -h, --help              Show help
EOF
}

install() {
    local dest=${1}
    local name=${2}
    local theme=${3}
    local scheme=${4}

    local THEME_DIR=${1}/${2}${3}${4}
    local THEME_DIR_DARK="${1}/${2}${3}${4}-Dark"
    local THEME_DIR_LIGHT="${1}/${2}${3}${4}-Light"

    [[ -d "${THEME_DIR}" ]] && rm -rf "${THEME_DIR}"
    [[ -d "${THEME_DIR_DARK}" ]] && rm -rf "${THEME_DIR_DARK}"
    [[ -d "${THEME_DIR_LIGHT}" ]] && rm -rf "${THEME_DIR_LIGHT}"

    echo "Installing '${THEME_DIR}'..."
    echo "Installing '${THEME_DIR_DARK}'..."
    echo "Installing '${THEME_DIR_LIGHT}'..."

    # Making Directories and Copying Icons
    mkdir -p "${THEME_DIR}"
    mkdir -p "${THEME_DIR_DARK}"
    mkdir -p "${THEME_DIR_LIGHT}"

    cp -r "${SRC_DIR}"/Uniformity/*                                                             "${THEME_DIR}"
    cp -r "${SRC_DIR}"/Uniformity-Dark/*                                                        "${THEME_DIR_DARK}"
    cp -r "${SRC_DIR}"/Uniformity-Light/*                                                       "${THEME_DIR_LIGHT}"

    # Renaming the Theme in the Index File
    	sed -i "s/Uniformity/${2}${3}${4}/g"                                                            "${THEME_DIR}"/index.theme
    	sed -i "s/Uniformity-Dark/${2}${3}${4}-Dark/g"                                                  "${THEME_DIR_DARK}"/index.theme
    	sed -i "s/Uniformity-Light/${2}${3}${4}-Light/g"                                                "${THEME_DIR_LIGHT}"/index.theme
    # Grabbing the Color Scheme & replacing the colors
    colors_folder

      sed -i "s/#bde6fb/${theme_color_bgf}/g"                                                   "${THEME_DIR}"/22x22/places/*.svg
      sed -i "s/#7fcef7/${theme_color_bgb}/g"                                                   "${THEME_DIR}"/22x22/places/*.svg
      sed -i "s/#0e9ce4/${theme_color_sym}/g"                                                   "${THEME_DIR}"/22x22/places/*.svg

      sed -i "s/#bde6fb/${theme_color_bgf}/g"                                                   "${THEME_DIR}"/16x16/apps/*.svg
      sed -i "s/#7fcef7/${theme_color_bgb}/g"                                                   "${THEME_DIR}"/16x16/apps/*.svg
      sed -i "s/#0e9ce4/${theme_color_sym}/g"                                                   "${THEME_DIR}"/16x16/apps/*.svg

    # Fixing Links
    cd ${THEME_DIR_DARK}
        ln -sf ../"${name}${theme}${scheme}"/8x8
        ln -sf ../"${name}${theme}${scheme}"/32x32
        ln -sf ../"${name}${theme}${scheme}"/42x42
        ln -sf ../"${name}${theme}${scheme}"/48x48
        ln -sf ../"${name}${theme}${scheme}"/64x64
        ln -sf ../"${name}${theme}${scheme}"/84x84
        ln -sf ../"${name}${theme}${scheme}"/96x96
        ln -sf ../"${name}${theme}${scheme}"/128x128

    cd ${THEME_DIR_LIGHT}
        ln -sf ../"${name}${theme}${scheme}"/8x8
        ln -sf ../"${name}${theme}${scheme}"/32x32
        ln -sf ../"${name}${theme}${scheme}"/42x42
        ln -sf ../"${name}${theme}${scheme}"/48x48
        ln -sf ../"${name}${theme}${scheme}"/64x64
        ln -sf ../"${name}${theme}${scheme}"/84x84
        ln -sf ../"${name}${theme}${scheme}"/96x96
        ln -sf ../"${name}${theme}${scheme}"/128x128
}

# Color Scheme (Can be used to add more schemes in the future)
colors_folder() {
    case "$theme" in
        '')
        theme_color_bgf='#bde6fb'
        theme_color_bgb='#7fcef7'
        theme_color_sym='#0e9ce4'
        ;;
        -Purple)
        theme_color_bgf='#d8c4f1'
        theme_color_bgb='#c1a1e9'
        theme_color_sym='#935cd8'
        ;;
        -Pink)
        theme_color_bgf='#fbbde6'
        theme_color_bgb='#f77fdb'
        theme_color_sym='#e40ec4'
        ;;
        -Red)
        theme_color_bgf='#fdb4b4'
        theme_color_bgb='#fc8c8c'
        theme_color_sym='#fa3636'
        ;;
        -Orange)
        theme_color_bgf='#fcc8b4'
        theme_color_bgb='#faaa8a'
        theme_color_sym='#f76d37'
        ;;
        -Yellow)
        theme_color_bgf='#fae6ac'
        theme_color_bgb='#f7d570'
        theme_color_sym='#dda70b'
        ;;
        -Green)
        theme_color_bgf='#86e6c2'
        theme_color_bgb='#5fddad'
        theme_color_sym='#2ac88d'
        ;;
        -Teal)
        theme_color_bgf='#b8f6f0'
        theme_color_bgb='#72e1d3'
        theme_color_sym='#0fb8a4'
        ;;
        -Grey)
        theme_color_bgf='#dcdcdc'
        theme_color_bgb='#bbbbbb'
        theme_color_sym='#797979'
        ;;
      esac

      if [[ "$scheme" == '-Catppuccin' ]]; then
          case "$theme" in
              '')
              theme_color_bgf='#89b4fa'
              theme_color_bgb='#4a8cf7'
              theme_color_sym='#2d7af6'
              ;;
              -Purple)
              theme_color_bgf='#d8c4f1'
              theme_color_bgb='#c1a1e9'
              theme_color_sym='#935cd8'
              ;;
              -Pink)
              theme_color_bgf='#fbbde6'
              theme_color_bgb='#f77fdb'
              theme_color_sym='#e40ec4'
              ;;
              -Red)
              theme_color_bgf='#fdb4b4'
              theme_color_bgb='#fc8c8c'
              theme_color_sym='#fa3636'
              ;;
              -Orange)
              theme_color_bgf='#fcc8b4'
              theme_color_bgb='#faaa8a'
              theme_color_sym='#f76d37'
              ;;
              -Yellow)
              theme_color_bgf='#fae6ac'
              theme_color_bgb='#f7d570'
              theme_color_sym='#dda70b'
              ;;
              -Green)
              theme_color_bgf='#86e6c2'
              theme_color_bgb='#5fddad'
              theme_color_sym='#2ac88d'
              ;;
              -Teal)
              theme_color_bgf='#b8f6f0'
              theme_color_bgb='#72e1d3'
              theme_color_sym='#0fb8a4'
              ;;
              -Grey)
              theme_color_bgf='#dcdcdc'
              theme_color_bgb='#bbbbbb'
              theme_color_sym='#797979'
              ;;
        esac
    fi
}

# While Loop that grabs the command and sets the variables
while [[ "$#" -gt 0 ]]; do
  case "${1:-}" in
    -d|--dest)
      dest="$2"
      mkdir -p "$dest"
      shift 2
      ;;
    -n|--name)
      name="${2}"
      shift 2
      ;;
    -s|--scheme)
     shift
        for scheme in "${@}"; do
          case "${scheme}" in
            default)
              schemes+=("${SCHEME_VARIANTS[0]}")
              shift
              ;;
            catppuccin)
              schemes+=("${SCHEME_VARIANTS[1]}")
              echo -e "\nCatppuccin ColorScheme version! ...\n"
              shift
              ;;
            all)
              schemes+=("${SCHEME_VARIANTS[@]}")
              echo -e "\All ColorSchemes version! ...\n"
              shift
              ;;
            -*|--*)
              break
              ;;
            *)
              echo "ERROR: Unrecognized color schemes variant '$1'."
              echo "Try '$0 --help' for more information."
              exit 1
              ;;
          esac
        done
        ;;
    -t|--theme)
      shift
      for theme in "${@}"; do
        case "${theme}" in
          default)
            themes+=("${THEME_VARIANTS[0]}")
            shift
            ;;
          purple)
            themes+=("${THEME_VARIANTS[1]}")
            shift
            ;;
          pink)
            themes+=("${THEME_VARIANTS[2]}")
            shift
            ;;
          red)
            themes+=("${THEME_VARIANTS[3]}")
            shift
            ;;
          orange)
            themes+=("${THEME_VARIANTS[4]}")
            shift
            ;;
          yellow)
            themes+=("${THEME_VARIANTS[5]}")
            shift
            ;;
          green)
            themes+=("${THEME_VARIANTS[6]}")
            shift
            ;;
          teal)
            themes+=("${THEME_VARIANTS[7]}")
            shift
            ;;
          grey)
            themes+=("${THEME_VARIANTS[8]}")
            shift
            ;;
          all)
            themes+=("${THEME_VARIANTS[@]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized theme color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

# Fallback for when there is no theme selected
if [[ "${#themes[@]}" -eq 0 ]]; then
  themes=("${THEME_VARIANTS[0]}")
fi

if [[ "${#schemes[@]}" -eq 0 ]]; then
  schemes=("${SCHEME_VARIANTS[0]}")
fi

# Removing old Icons before installing
clean_old_theme() {
    for theme in "${themes[@]}"; do
        for scheme in "${schemes[@]}"; do
            rm -rf "${dest:-${DEST_DIR}}/${THEME_NAME}${theme}"
            rm -rf "${dest:-${DEST_DIR}}/${THEME_NAME}${theme}-Dark"
            rm -rf "${dest:-${DEST_DIR}}/${THEME_NAME}${theme}-Light"
        done
    done
}

clean_old_theme

# Running the install command with the variables
install_theme() {
    for theme in "${themes[@]}"; do
        for scheme in "${schemes[@]}"; do
            install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${theme}" "${scheme}"
        done
    done
}

install_theme

# Updating the icon cache
gtk-update-icon-cache -f -t "${DEST_DIR}/${THEME_NAME}${theme}"
gtk-update-icon-cache -f -t "${dest:-${DEST_DIR}}/${name:-${THEME_NAME}}${theme}-Dark"
gtk-update-icon-cache -f -t "${dest:-${DEST_DIR}}/${name:-${THEME_NAME}}${theme}-Light"

echo -e "\nFinished!\n"
