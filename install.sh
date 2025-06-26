#!/bin/bash

# Ищет make команды в удаленном репе и добавляет в локальный Makefile
# Использование: curl -sSL <URL>/install.sh | sh -s "make deploy"
# Updated: force cache invalidation

REPO_URL="https://github.com/inem/makefiles.git"
TEMP_DIR="/tmp/makefiles-$$"

if [[ -n "$1" ]]; then
    echo "🔍 Упавшая команда: $1"

    # Извлекаем target из команды "make deploy" -> "deploy"
    target=$(echo "$1" | sed 's/^make[[:space:]]*//' | awk '{print $1}')

    if [[ -z "$target" ]]; then
        echo "❌ Не удалось определить цель make"
        exit 1
    fi

    echo "📥 Клонирую репозиторий с makefiles..."

    # Клонируем репозиторий временно
    if ! git clone --quiet "$REPO_URL" "$TEMP_DIR" 2>/dev/null; then
        echo "❌ Не удалось клонировать репозиторий $REPO_URL"
        exit 1
    fi

    echo "🔍 Ищу команду '$target' в makefiles..."

    # Ищем команду во всех *.mk файлах в клонированном репо
    found_files=""
    for file in $(find "$TEMP_DIR" -name "*.mk" 2>/dev/null); do
        if grep -q "^$target:" "$file" 2>/dev/null; then
            found_files="$found_files $file"
        fi
    done

    if [[ -z "$found_files" ]]; then
        echo "❌ Команда '$target' не найдена в makefiles"
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    echo "✅ Найдена команда '$target' в:"
    for file in $found_files; do
        echo "  - $(basename "$file")"
    done

    # Берем первый найденный файл
    source_file=$(echo "$found_files" | awk '{print $1}')

    # Извлекаем цель и её команды
    target_block=$(awk "/^$target:/{flag=1} flag && /^[^[:space:]]/ && !/^$target:/{flag=0} flag" "$source_file")

    if [[ -z "$target_block" ]]; then
        echo "❌ Не удалось извлечь блок для '$target'"
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    echo ""
    echo "📝 Найденный блок:"
    echo "$target_block"
    echo ""

    # Проверяем есть ли локальный Makefile
    if [[ ! -f "./Makefile" ]]; then
        echo "✅ Создаю локальный Makefile"
        touch "./Makefile"
    fi

    # Проверяем есть ли уже такая цель в локальном Makefile
    if grep -q "^$target:" "./Makefile" 2>/dev/null; then
        echo "⚠️  Цель '$target' уже существует в локальном Makefile - пропускаю"
        rm -rf "$TEMP_DIR"
        exit 0
    fi

    # Добавляем новую цель
    echo "" >> "./Makefile"
    echo "$target_block" >> "./Makefile"

    echo "✅ Команда '$target' добавлена в локальный Makefile"
    echo "🚀 Теперь можно запустить: make $target"

    # Удаляем временный репозиторий
    rm -rf "$TEMP_DIR"

else
    echo "❌ Не передан аргумент"
    exit 1
fi
