#!/bin/bash

    # Настройка владельца и прав доступа в каталоге
    # ЗАПУСКАТЬ ИЗ-ПОД ROOT или через sudo!

    #ASSIGNED_FOLDERS — массив, можно добавлять любое количество каталогов.
    # Скрипт проверяет, существует ли на диске каждый каталог из ASSIGNED_FOLDERS, чтобы не ругаться.

    # На каталоги добавлен setgid-бит (2 в chmod 2775), чтобы новые файлы и подпапки автоматически наследовали группу sudo

USER_NAME='astenix'
GROUP_NAME='sudo'
ASSIGNED_FOLDERS=(
    "/home/astenix"
    "/home/renegade"
)

# Проверяем, что скрипт запущен от root
if [[ $EUID -ne 0 ]]; then
   echo "Скрипт нужно запускать от root или через sudo"
   exit 1
fi

for FOLDER in "${ASSIGNED_FOLDERS[@]}"; do
    if [[ ! -d "$FOLDER" ]]; then
        echo "Каталог $FOLDER не найден, пропускаем"
        continue
    fi

	# Установить владельца и группу
    echo -e "\nНазначить $USER_NAME:$GROUP_NAME для $FOLDER (рекурсивно)"
    chown -R "$USER_NAME:$GROUP_NAME" "$FOLDER"

        # Права для каталогов: rwx (владелец, группа), r-x (остальные)
    echo -e "\nВыставить права для каталогов (рекурсивно)\n\tвладелец: rwx\n\tостальные: r-x\n\t+ setgid 2, чтобы новые файлы наследовали группу sudo"
    find "$FOLDER" -type d -exec chmod 2775 {} +

        # Права для обычных файлов: rw (владелец, группа), r (остальные)
    echo -e "Выставляю права для файлов рекурсивно\n\tвладелец: rw\n\tостальные: r"
    find "$FOLDER" -type f -exec chmod 664 {} +

        # Права для исполняемых файлов (*.sh): rwx (владелец, группа), r-x (остальные)
    echo -e "Выставляю права для всех скриптов (*.sh)\n\tвладелец: rwx\n\tостальные: r-x"
    find "$FOLDER" -type f -name "*.sh" -exec chmod 775 {} +    

echo -e "\n\tDone\n"

done
