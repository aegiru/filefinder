#!/bin/bash

# ZMIENNE:
CURRENT_INPUT=
SKRYPT2_FILENAME=
SKRYPT2_LOCALE=
SKRYPT2_MIN_SIZE=
SKRYPT2_MAX_SIZE=
SKRYPT2_CONTAINS=

file_finder() {

    SKRYPT2_COMMAND_TO_RUN="find "

    if [ -z "$SKRYPT2_LOCALE" ]; then

        SKRYPT2_COMMAND_TO_RUN+="/ "
        SKRYPT2_LOCALE="/"

    else

        SKRYPT2_COMMAND_TO_RUN+="${SKRYPT2_LOCALE} "

    fi

    SKRYPT2_COMMAND_TO_RUN+="-type f "

    if [ ! -z "$SKRYPT2_FILENAME" ]; then

        SKRYPT2_COMMAND_TO_RUN+="-name ${SKRYPT2_FILENAME} "

    fi

    if [ ! -z "$SKRYPT2_MAX_SIZE" ]; then

        SKRYPT2_COMMAND_TO_RUN+="-size -${SKRYPT2_MAX_SIZE} "

    fi

    if [ ! -z "$SKRYPT2_MIN_SIZE" ]; then

        SKRYPT2_COMMAND_TO_RUN+="-size +${SKRYPT2_MIN_SIZE} "

    fi

    if [ ! -z "$SKRYPT2_CONTAINS" ]; then

        SKRYPT2_COMMAND_TO_RUN+="-exec grep '${SKRYPT2_CONTAINS}' {} \;"

    fi

    RETURN_VALUE=$(eval $SKRYPT2_COMMAND_TO_RUN)

    if [ ! -z "$RETURN_VALUE" ]; then
        echo "Plik znaleziono!"
    else
        echo "Pliku nie znaleziono!"
    fi

}

input_handler() {

    if [ "$CURRENT_INPUT" -eq 1 ]; then
        echo "Podaj nowa nazwe pliku: "
        read SKRYPT2_FILENAME
    elif [ "$CURRENT_INPUT" -eq 2 ]; then
        echo "Podaj nowy katalog: "
        read SKRYPT2_LOCALE
    elif [ "$CURRENT_INPUT" -eq 3 ]; then
        echo "Podaj minimalny rozmiar: "
        read SKRYPT2_MIN_SIZE
    elif [ "$CURRENT_INPUT" -eq 4 ]; then
        echo "Podaj maksymalny rozmiar: "
        read SKRYPT2_MAX_SIZE
    elif [ "$CURRENT_INPUT" -eq 5 ]; then
        echo "Podaj szukana zawartosc: "
        read SKRYPT2_CONTAINS
    elif [ "$CURRENT_INPUT" -eq 6 ]; then
        #     if [ -z $file_finder ]; then
        #         echo "Pliku nie znaleziono."
        #     else
        #         echo "Plik znaleziono."
        #     fi
        #     main_menu
        file_finder
    elif [ "$CURRENT_INPUT" -eq 7 ]; then
        echo "Wychodzenie z programu..."
        exit 0
    else
        echo "Zly numer. Prosimy o wpisanie poprawnej liczby. (1-7)"
    fi

    main_menu
}

main_menu() {

    # 1. Nazwa pliku ( plik.txt )

    if [ -z "$SKRYPT2_FILENAME" ]; then

        echo "1. Nazwa pliku: "

    else

        echo "1. Nazwa pliku: [ $SKRYPT2_FILENAME ]"

    fi
    # 2. Katalog: ( . )

    if [ -z "$SKRYPT2_LOCALE" ]; then

        echo "2. Katalog: "

    else

        echo "2. Katalog: [ $SKRYPT2_LOCALE ]"

    fi

    # 3. Wiekszy niz: 1 (B)

    if [ -z "$SKRYPT2_MIN_SIZE" ]; then

        echo "3. Wiekszy niz: "

    else

        echo "3. Wiekszy niz: [ $SKRYPT2_MIN_SIZE (B) ]"

    fi

    # 4. Mniejszy niz: 1000 (B)

    if [ -z "$SKRYPT2_MAX_SIZE" ]; then

        echo "4. Mniejszy niz: "

    else

        echo "4. Mniejszy niz: [ $SKRYPT2_MAX_SIZE (B) ]"

    fi

    # 5. Zawartosc: abc

    if [ -z "$SKRYPT2_CONTAINS" ]; then

        echo "5. Zawartosc: "

    else

        echo "5. Zawartosc: [ $SKRYPT2_CONTAINS ]"

    fi

    # 6. Szukaj

    echo "6. Szukaj"

    # find . -name ... -exec  grep ... {} \;
    # -n / -z
    # Plik istnieje
    # lub
    # Plik nie istnieje

    # 7. Koniec

    echo "7. Koniec"

    echo "Twoj wybor? (1-7)"

    read CURRENT_INPUT

    input_handler

}

# POCZATEK

main_menu

# man find
# man test
