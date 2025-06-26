#!/bin/bash

# Ищет make команды в репе и добавляет в локальный Makefile
# Использование: curl -sSL <URL>/install.sh | sh -s "make deploy"

if [[ -n "$1" ]]; then
    echo "🔍 Упавшая команда: $1"

    # Извлекаем target из команды "make deploy" -> "deploy"
    target=$(echo "$1" | sed 's/^make[[:space:]]*//' | awk '{print $1}')

    if [[ -z "$target" ]]; then
        echo "❌ Не удалось определить цель make"
        exit 1
    fi

    echo "🔍 Ищу команду '$target' в makefiles..."

    # Ищем команду во всех Makefile в репе
    found_files=()
    while IFS= read -r -d '' file; do
        if grep -q "^$target:" "$file" 2>/dev/null; then
            found_files+=("$file")
        fi
    done < <(find . -name "Makefile" -o -name "makefile" -o -name "*.mk" -print0 2>/dev/null)

    if [[ ${#found_files[@]} -eq 0 ]]; then
        echo "❌ Команда '$target' не найдена в makefiles"
        exit 1
    fi

    echo "✅ Найдена команда '$target' в:"
    for file in "${found_files[@]}"; do
        echo "  - $file"
    done

    # Берем первый найденный файл
    source_file="${found_files[0]}"

    # Извлекаем цель и её команды (все строки до следующей цели или конца файла)
    target_block=$(awk "/^$target:/{flag=1} flag && /^[^[:space:]]/ && !/^$target:/{flag=0} flag" "$source_file")

    if [[ -z "$target_block" ]]; then
        echo "❌ Не удалось извлечь блок для '$target'"
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
        exit 0
    fi

    # Добавляем новую цель
    echo "" >> "./Makefile"
    echo "$target_block" >> "./Makefile"

    echo "✅ Команда '$target' добавлена в локальный Makefile"
    echo "🚀 Теперь можно запустить: make $target"

else
    echo "❌ Не передан аргумент"
    exit 1
fi
