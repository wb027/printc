#!/bin/bash
###
# Печатает разными цветами.
# nobr — не вставлять в конце перенос строки.
##

function printc()
{
  ( # Выполняем все действия в отдельном subshell,
    # чтобы гарантировать локальность всех переменных
    # (отсутствие конфликтов с глобальными).

    DECOR='' # переменная-накопитель escape-кодов
    NEWLINE="\n" # перенос строки после текста

    for ARG in "$@"
    do
      CODE=
      case "$ARG" in
        # Код цвета текста:
        black)   CODE='30;' ;;
        red)     CODE='31;' ;;
        green)   CODE='32;' ;;
        yellow)  CODE='33;' ;;
        blue)    CODE='34;' ;;
        magenta) CODE='35;' ;;
        cyan)    CODE='36;' ;;
        white)   CODE='37;' ;;
        # Код цвета фона:
        bg[_-]black|bgblack)     CODE='40;' ;;
        bg[_-]red|bgred)         CODE='41;' ;;
        bg[_-]green|bggreen)     CODE='42;' ;;
        bg[_-]yellow|bgyellow)   CODE='43;' ;;
        bg[_-]blue|bgblue)       CODE='44;' ;;
        bg[_-]magenta|bgmagenta) CODE='45;' ;;
        bg[_-]cyan|bgcyan)       CODE='46;' ;;
        bg[_-]white|bgwhite)     CODE='47;' ;;
        # Код начертания:
        b|bold)   CODE='1;' ;;
        i|italic) CODE='3;' ;;
        # Код яркости/мигания:
        light|faint|pale) CODE='2;' ;;
        blink) CODE='5;' ;;
        # Код всевозможных черточек:
        under|underline)       CODE='4;'  ;;
        strike)                CODE='9;'  ;;
        dblunder|dblunderline) CODE='21;' ;;
        over|overline  )       CODE='53;' ;;
        # Код запрета переноса строки:
        nobr) NEWLINE=''; ;;
      esac

      # Если параметр распознан, как ключевое слово,
      # добавляем вычисленный код в escape-последовательность.
      if [ -n "$CODE" ]; then
        DECOR=$DECOR$CODE
      fi

    done



    # Собираем управляющую последовательность (escape code)
    if [ -n "$DECOR" ]; then
      # Последний код в перечне завершается символом m вместо точки с запятой.
      ESC_CODE="\033[${DECOR/%;/m}"
    fi
    

    # Последний параметр считаем текстом для печати, остальное пойдет в мусор.
    n=$#
    for((i=1;i<n;i++)); do
      shift
    done
    TEXT=$@

    # Печатаем. 
    printf "%b" "$ESC_CODE$TEXT$NEWLINE"

    # Сбрасываем все установленные атрибуты
    echo -en "\033[0m"
    # tput sgr0
  )
}
