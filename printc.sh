#!/bin/bash
###
# Печатает разными цветами.
# printc 'bla-bla-bla' [black|red|green|yellow|blue|magenta|cyan|white] [bold] [underline] [nobr]
# (nobr означает не вставлять в конце перенос строки)
##
PRINTED_TEXT=$1
shift

PRINT_WITH_COLOR=''
PRINT_WITH_DECOR1=''
PRINT_WITH_DECOR2=''
PRINT_WITH_NOBR=0

for COLOR_ARG in $*; do
    case "$COLOR_ARG" in
        # Ищем код цвета
        'black'  ) PRINT_WITH_COLOR="\e[30m" ;;
        'red'    ) PRINT_WITH_COLOR="\e[31m" ;;
        'green'  ) PRINT_WITH_COLOR="\e[32m" ;;
        'yellow' ) PRINT_WITH_COLOR="\e[33m" ;;
        'blue'   ) PRINT_WITH_COLOR="\e[34m" ;;
        'magenta') PRINT_WITH_COLOR="\e[35m" ;;
        'cyan'   ) PRINT_WITH_COLOR="\e[36m" ;;
        'white'  ) PRINT_WITH_COLOR="\e[37m" ;;
        # Ищем код оформления
        'bold'     ) PRINT_WITH_DECOR1="\033[1m" ;;
        'underline') PRINT_WITH_DECOR2="\033[4m" ;;
        # Ищем код запрета переноса в конце
        'nobr') PRINT_WITH_NOBR=1 ;;
    esac
done

WRITE="${PRINT_WITH_COLOR}${PRINT_WITH_DECOR1}${PRINT_WITH_DECOR2}${PRINTED_TEXT}"

if [[ $PRINT_WITH_NOBR == 1 ]]; then
    # без переноса строки в конце
    echo -en "$WRITE"
else
    # добавляем перенос в конце
    echo -e "$WRITE"
fi

echo -en "\033[0m"
# tput sgr0
}

