#! /usr/bin/env bash

set -eo pipefail

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.local/share/icons"
fi

SRC_DIR="$(cd "$(dirname "$0")" && pwd)"

THEME_NAME=Uniformity
THEME_VARIANTS=('' '-Purple' '-Pink' '-Red' '-Orange' '-Yellow' '-Green' '-Teal' '-Grey')
SCHEME_VARIANTS=('' '-Nord' '-Dracula' '-Adwaita' '-Everforest' '-Catppuccin')
COLOR_VARIANTS=('-Light' '-Dark' '')

themes=()
schemes=()
colors=()

usage() {
cat << EOF
  Usage: $0 [OPTION]...

  OPTIONS:
    -d, --dest DIR          Specify destination directory (Default: $DEST_DIR)
    -n, --name NAME         Specify theme name (Default: $THEME_NAME)
    -s, --scheme VARIANTS   Specify folder colorscheme variant(s) [default|nord|dracula|Adwaita|everforest|catppuccin|all]
    -t, --theme VARIANTS    Specify folder color theme variant(s) [default|purple|pink|red|orange|yellow|green|teal|grey|all] (Default: blue)
    -notint, --notint       Disable Follow ColorSheme for folders on KDE Plasma
    -r, --remove, -u, --uninstall   Remove/Uninstall $THEME_NAME icon themes
    -h, --help              Show help
EOF
}

install() {
  local dest=${1}
  local name=${2}
  local theme=${3}
  local scheme=${4}
  local color=${5}

  local THEME_DIR=${1}/${2}${3}${4}${5}

  [[ -d "${THEME_DIR}" ]] && rm -rf "${THEME_DIR}"

  echo "Installing '${THEME_DIR}'..."

  mkdir -p                                                                                  "${THEME_DIR}"
  cp -r "${SRC_DIR}"/src/index.theme                                                        "${THEME_DIR}"
  sed -i "s/Uniformity/${2}${3}${4}${5}/g"                                                     "${THEME_DIR}"/index.theme

  if [[ "${color}" == '-Light' ]]; then
    cp -r "${SRC_DIR}"/src/{actions,apps,categories,devices,emblems,mimetypes,places,status} "${THEME_DIR}"

    if [[ "${theme}" == '' && "${scheme}" == '' && "${notint}" == 'true' ]]; then
      cp -r "${SRC_DIR}"/notint/*.svg                                                       "${THEME_DIR}"/places/scalable
    fi

    colors_folder

    if [[ "${scheme}" != '' || "${theme}" != '' ]]; then
      # cp -r "${SRC_DIR}"/notint/*.svg                                                       "${THEME_DIR}"/places/scalable
      sed -i "s/#bde6fb/${theme_color_bgf}/g"                                                   "${THEME_DIR}"/places/scalable/*.svg
      sed -i "s/#7fcef7/${theme_color_bgb}/g"                                                   "${THEME_DIR}"/places/scalable/*.svg
      sed -i "s/#0e9ce4/${theme_color_sym}/g"                                                   "${THEME_DIR}"/places/scalable/*.svg
      
      sed -i "s/#bde6fb/${theme_color_bgf}/g"                                                   "${THEME_DIR}"/apps/scalable/*.svg
      sed -i "s/#7fcef7/${theme_color_bgb}/g"                                                   "${THEME_DIR}"/apps/scalable/*.svg
      sed -i "s/#0e9ce4/${theme_color_sym}/g"                                                   "${THEME_DIR}"/apps/scalable/*.svg

      
    fi

    cp -r "${SRC_DIR}"/links/*                                                               "${THEME_DIR}"
  fi

  if [[ "${color}" == '-Dark' ]]; then
    mkdir -p                                                                                "${THEME_DIR}"/{apps,categories,devices,emblems,mimetypes,places,status}
    cp -r "${SRC_DIR}"/src/actions                                                          "${THEME_DIR}"
    cp -r "${SRC_DIR}"/src/apps/{22,symbolic}                                               "${THEME_DIR}"/apps
    cp -r "${SRC_DIR}"/src/categories/{22,symbolic}                                         "${THEME_DIR}"/categories
    cp -r "${SRC_DIR}"/src/emblems/symbolic                                                 "${THEME_DIR}"/emblems
    cp -r "${SRC_DIR}"/src/mimetypes/symbolic                                               "${THEME_DIR}"/mimetypes
    cp -r "${SRC_DIR}"/src/devices/{16,22,24,32,symbolic}                                   "${THEME_DIR}"/devices
    cp -r "${SRC_DIR}"/src/places/{16,22,24,symbolic}                                       "${THEME_DIR}"/places
    cp -r "${SRC_DIR}"/src/status/{16,22,24,symbolic}                                       "${THEME_DIR}"/status

    # Change icon color for dark theme
    sed -i "s/#363636/#dedede/g" "${THEME_DIR}"/{actions,devices,places,status}/{16,22,24}/*.svg
    sed -i "s/#363636/#dedede/g" "${THEME_DIR}"/{actions,devices}/32/*.svg
    sed -i "s/#363636/#dedede/g" "${THEME_DIR}"/apps/22/*.svg
    sed -i "s/#363636/#dedede/g" "${THEME_DIR}"/categories/22/*.svg
    sed -i "s/#363636/#dedede/g" "${THEME_DIR}"/{actions,apps,categories,devices,emblems,mimetypes,places,status}/symbolic/*.svg

    cp -r "${SRC_DIR}"/links/actions/{16,22,24,32,symbolic}                                 "${THEME_DIR}"/actions
    cp -r "${SRC_DIR}"/links/devices/{16,22,24,32,symbolic}                                 "${THEME_DIR}"/devices
    cp -r "${SRC_DIR}"/links/places/{16,22,24,symbolic}                                     "${THEME_DIR}"/places
    cp -r "${SRC_DIR}"/links/status/{16,22,24,symbolic}                                     "${THEME_DIR}"/status
    cp -r "${SRC_DIR}"/links/apps/{22,symbolic}                                             "${THEME_DIR}"/apps
    cp -r "${SRC_DIR}"/links/categories/{22,symbolic}                                       "${THEME_DIR}"/categories
    cp -r "${SRC_DIR}"/links/mimetypes/symbolic                                             "${THEME_DIR}"/mimetypes

    cd "${dest}"
    ln -sf ../../"${name}${theme}${scheme}"-Light/apps/scalable "${name}${theme}${scheme}"-Dark/apps/scalable
    ln -sf ../../"${name}${theme}${scheme}"-Light/devices/scalable "${name}${theme}${scheme}"-Dark/devices/scalable
    ln -sf ../../"${name}${theme}${scheme}"-Light/places/scalable "${name}${theme}${scheme}"-Dark/places/scalable
    ln -sf ../../"${name}${theme}${scheme}"-Light/categories/32 "${name}${theme}${scheme}"-Dark/categories/32
    ln -sf ../../"${name}${theme}${scheme}"-Light/emblems/16 "${name}${theme}${scheme}"-Dark/emblems/16
    ln -sf ../../"${name}${theme}${scheme}"-Light/emblems/22 "${name}${theme}${scheme}"-Dark/emblems/22
    ln -sf ../../"${name}${theme}${scheme}"-Light/status/32 "${name}${theme}${scheme}"-Dark/status/32
    ln -sf ../../"${name}${theme}${scheme}"-Light/mimetypes/scalable "${name}${theme}${scheme}"-Dark/mimetypes/scalable
  fi

  if [[ "${color}" == '' ]]; then
    cd ${dest}
    ln -sf ../"${name}${theme}${scheme}"-Light/apps "${name}${theme}${scheme}"/apps
    ln -sf ../"${name}${theme}${scheme}"-Light/actions "${name}${theme}${scheme}"/actions
    ln -sf ../"${name}${theme}${scheme}"-Light/devices "${name}${theme}${scheme}"/devices
    ln -sf ../"${name}${theme}${scheme}"-Light/emblems "${name}${theme}${scheme}"/emblems
    ln -sf ../"${name}${theme}${scheme}"-Light/places "${name}${theme}${scheme}"/places
    ln -sf ../"${name}${theme}${scheme}"-Light/categories "${name}${theme}${scheme}"/categories
    ln -sf ../"${name}${theme}${scheme}"-Light/mimetypes "${name}${theme}${scheme}"/mimetypes
    ln -sf ../"${name}${theme}${scheme}"-Dark/status "${name}${theme}${scheme}"/status
  fi

  (
    cd "${THEME_DIR}"
    ln -sf actions actions@2x
    ln -sf apps apps@2x
    ln -sf categories categories@2x
    ln -sf devices devices@2x
    ln -sf emblems emblems@2x
    ln -sf mimetypes mimetypes@2x
    ln -sf places places@2x
    ln -sf status status@2x
  )

  gtk-update-icon-cache "${THEME_DIR}"
}

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

  if [[ "$scheme" == '-Nord' ]]; then
    case "$theme" in
      '')
        theme_color_bgf='#89a3c2'
        theme_color_bgb='#7a9bbf'
        theme_color_sym='#4a6a8d'
        ;;
      -Purple)
        theme_color_bgf='#c89dbf'
        theme_color_bgb='#b78bcf'
        theme_color_sym='#8b5b9e'
        ;;
      -Pink)
        theme_color_bgf='#dc98b1'
        theme_color_bgb='#d68f9e'
        theme_color_sym='#b76a7e'
        ;;
      -Red)
        theme_color_bgf='#d4878f'
        theme_color_bgb='#c76b6b'
        theme_color_sym='#a54a4a'
        ;;
      -Orange)
        theme_color_bgf='#dca493'
        theme_color_bgb='#d69a7a'
        theme_color_sym='#b67a5a'
        ;;
      -Yellow)
        theme_color_bgf='#eac985'
        theme_color_bgb='#d6c76b'
        theme_color_sym='#b6a84a'
        ;;
      -Green)
        theme_color_bgf='#a0c082'
        theme_color_bgb='#8db76b'
        theme_color_sym='#6b9a4a'
        ;;
      -Teal)
        theme_color_bgf='#83b9b8'
        theme_color_bgb='#72a8a7'
        theme_color_sym='#4a7a7a'
        ;;
      -Grey)
        theme_color_bgf='#757a99'
        theme_color_bgb='#6b6f7a'
        theme_color_sym='#4a4e5a'
        ;;
    esac
  fi

 if [[ "$scheme" == '-Dracula' ]]; then
    case "$theme" in
      '')
        theme_color_bgf='#6272a4'
        theme_color_bgb='#5a6584'
        theme_color_sym='#4a4e6a'
        ;;
      -Purple)
        theme_color_bgf='#bd93f9'
        theme_color_bgb='#a76bcf'
        theme_color_sym='#8b5b9e'
        ;;
      -Pink)
        theme_color_bgf='#ff79c6'
        theme_color_bgb='#ff6ab1'
        theme_color_sym='#d65a8d'
        ;;
      -Red)
        theme_color_bgf='#ff5555'
        theme_color_bgb='#ff4a4a'
        theme_color_sym='#d63a3a'
        ;;
      -Orange)
        theme_color_bgf='#ffb86c'
        theme_color_bgb='#ff9a4a'
        theme_color_sym='#d67a3a'
        ;;
      -Yellow)
        theme_color_bgf='#f1fa8c'
        theme_color_bgb='#e6e67a'
        theme_color_sym='#b6b64a'
        ;;
      -Green)
        theme_color_bgf='#50fa7b'
        theme_color_bgb='#4ae66a'
        theme_color_sym='#3ab54a'
        ;;
      -Teal)
        theme_color_bgf='#50fae9'
        theme_color_bgb='#4ae6d3'
        theme_color_sym='#3ab4b8'
        ;;
      -Grey)
        theme_color_bgf='#757a99'
        theme_color_bgb='#6f7584'
        theme_color_sym='#4a4e5a'
        ;;
    esac
  fi

  if [[ "$scheme" == '-Adwaita' ]]; then
    case "$theme" in
      '')
        theme_color_bgf='#3584e4'
        theme_color_bgb='#2a6bbf'
        theme_color_sym='#1e4a99'
        ;;
      -Purple)
        theme_color_bgf='#9141ac'
        theme_color_bgb='#7a2a8d'
        theme_color_sym='#5b1e6a'
        ;;
      -Pink)
        theme_color_bgf='#d56199'
        theme_color_bgb='#c54a7a'
        theme_color_sym='#a63a5a'
        ;;
      -Red)
        theme_color_bgf='#e62d42'
        theme_color_bgb='#d62a36'
        theme_color_sym='#b61e2a'
        ;;
      -Orange)
        theme_color_bgf='#ed5b00'
        theme_color_bgb='#d64a00'
        theme_color_sym='#b63900'
        ;;
      -Yellow)
        theme_color_bgf='#c88800'
        theme_color_bgb='#b76e00'
        theme_color_sym='#a55a00'
        ;;
      -Green)
        theme_color_bgf='#3a944a'
        theme_color_bgb='#2a7a36'
        theme_color_sym='#1e5b2a'
        ;;
      -Teal)
        theme_color_bgf='#2190a4'
        theme_color_bgb='#1a7a8d'
        theme_color_sym='#0e5b6a'
        ;;
      -Grey)
        theme_color_bgf='#6f8396'
        theme_color_bgb='#5a6f84'
        theme_color_sym='#4a5b6f'
        ;;
    esac
  fi

  if [[ "$scheme" == '-Everforest' ]]; then
    case "$theme" in
      '')
        theme_color_bgf='#7fbbb3'
        theme_color_bgb='#6fae9e'
        theme_color_sym='#5a8b8a'
        ;;
      -Purple)
        theme_color_bgf='#D699B6'
        theme_color_bgb='#c68a9e'
        theme_color_sym='#a66a7a'
        ;;
      -Pink)
        theme_color_bgf='#d3869b'
        theme_color_bgb='#c56a7a'
        theme_color_sym='#a54a5a'
        ;;
      -Red)
        theme_color_bgf='#E67E80'
        theme_color_bgb='#d66a6a'
        theme_color_sym='#b54a4a'
        ;;
      -Orange)
        theme_color_bgf='#E69875'
        theme_color_bgb='#d68a5a'
        theme_color_sym='#b66a3a'
        ;;
      -Yellow)
        theme_color_bgf='#DBBC7F'
        theme_color_bgb='#c6a76b'
        theme_color_sym='#a68a4a'
        ;;
      -Green)
        theme_color_bgf='#A7C080'
        theme_color_bgb='#8ab76b'
        theme_color_sym='#6a9a4a'
        ;;
      -Teal)
        theme_color_bgf='#83C092'
        theme_color_bgb='#72b68a'
        theme_color_sym='#5a9a6a'
        ;;
      -Grey)
        theme_color_bgf='#7a8478'
        theme_color_bgb='#6f7a6b'
        theme_color_sym='#5a5b4a'
        ;;
    esac
  fi

    if [[ "$scheme" == '-Catppuccin' ]]; then
    case "$theme" in
      '')
        theme_color_bgf='#8caaee'
        theme_color_bgb='#7a9bdf'
        theme_color_sym='#5a6bbf'
        ;;
      -Purple)
        theme_color_bgf='#ca9ee6'
        theme_color_bgb='#b78bcf'
        theme_color_sym='#8b5b9e'
        ;;
      -Pink)
        theme_color_bgf='#f4b8e4'
        theme_color_bgb='#e68fcb'
        theme_color_sym='#d66a9e'
        ;;
      -Red)
        theme_color_bgf='#ea999c'
        theme_color_bgb='#d68a8a'
        theme_color_sym='#b66a6a'
        ;;
      -Orange)
        theme_color_bgf='#fe8019'
        theme_color_bgb='#d76a00'
        theme_color_sym='#b65a00'
        ;;
      -Yellow)
        theme_color_bgf='#ef9f76'
        theme_color_bgb='#d68a5a'
        theme_color_sym='#b66a3a'
        ;;
      -Green)
        theme_color_bgf='#a6d189'
        theme_color_bgb='#8ab76b'
        theme_color_sym='#6a9a4a'
        ;;
      -Teal)
        theme_color_bgf='#81c8be'
        theme_color_bgb='#72b6a7'
        theme_color_sym='#5a9a8a'
        ;;
      -Grey)
        theme_color_bgf='#7c7f93'
        theme_color_bgb='#6f6f84'
        theme_color_sym='#5a5b6f'
        ;;
    esac
  fi
}

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
    -r|--remove|-u|--uninstall)
      remove='true'
      echo -e "\nUninstall icon themes...\n"
      shift
      ;;
    -notint|--notint)
      notint='true'
      echo -e "\nInstall notint version! that folders will not follow system colorschemes..."
      shift
      ;;
    -s|--scheme)
      shift
      for scheme in "${@}"; do
        case "${scheme}" in
          default)
            schemes+=("${SCHEME_VARIANTS[0]}")
            shift
            ;;
          nord)
            schemes+=("${SCHEME_VARIANTS[1]}")
            echo -e "\nNord ColorScheme version! ...\n"
            shift
            ;;
          dracula)
            schemes+=("${SCHEME_VARIANTS[2]}")
            echo -e "\nDracula ColorScheme version! ...\n"
            shift
            ;;
          Adwaita)
            schemes+=("${SCHEME_VARIANTS[3]}")
            echo -e "\nAdwaita ColorScheme version! ...\n"
            shift
            ;;
          everforest)
            schemes+=("${SCHEME_VARIANTS[4]}")
            echo -e "\nEverforest ColorScheme version! ...\n"
            shift
            ;;
          catppuccin)
            schemes+=("${SCHEME_VARIANTS[5]}")
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

if [[ "${#themes[@]}" -eq 0 ]]; then
  themes=("${THEME_VARIANTS[0]}")
fi

if [[ "${#schemes[@]}" -eq 0 ]]; then
  schemes=("${SCHEME_VARIANTS[0]}")
fi

if [[ "${#colors[@]}" -eq 0 ]]; then
  colors=("${COLOR_VARIANTS[@]}")
fi

clean_old_theme() {
  for theme in '' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-teal' '-grey'; do
    for scheme in '' '-nord' '-dracula'; do
      for color in '' '-light' '-dark'; do
        rm -rf "${dest:-${DEST_DIR}}/${THEME_NAME}${theme}${scheme}${color}"
      done
    done
  done
}

remove_theme() {
  for theme in "${THEME_VARIANTS[@]}"; do
    for scheme in "${SCHEME_VARIANTS[@]}"; do
      for color in "${COLOR_VARIANTS[@]}"; do
        local THEME_DIR="${DEST_DIR}/${THEME_NAME}${theme}${scheme}${color}"
        [[ -d "$THEME_DIR" ]] && echo -e "Removing $THEME_DIR ..." && rm -rf "$THEME_DIR"
      done
    done
  done
}

install_theme() {
  for theme in "${themes[@]}"; do
    for scheme in "${schemes[@]}"; do
      for color in "${colors[@]}"; do
        install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${theme}" "${scheme}" "${color}"
      done
    done
  done
}

clean_old_theme

if [[ "${remove}" == 'true' ]]; then
  remove_theme
else
  install_theme
fi

echo -e "\nFinished!\n"


