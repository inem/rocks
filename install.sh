#!/bin/bash

# Make Command Fixer - добавляет отсутствующие make команды из репы
# Использование: curl -sSL <URL>/install.sh | bash

set -e

echo "🔧 Устанавливаю Make Command Fixer..."

# Создаем основной скрипт
cat > ~/.makefixer << 'EOF'
#!/bin/bash

# Make Command Fixer - ищет make команды в репе и добавляет в локальный Makefile
makefixer() {
    # Получаем последнюю команду из истории
    local last_cmd=$(history | tail -2 | head -1 | sed 's/^[ ]*[0-9]*[ ]*//')

    # Проверяем что это была make команда
    if [[ ! "$last_cmd" =~ ^make ]]; then
        echo "❌ Последняя команда не была make командой"
        return 1
    fi

    # Извлекаем цель (target) из команды
    local target=$(echo "$last_cmd" | sed 's/^make[[:space:]]*//' | awk '{print $1}')

    if [[ -z "$target" ]]; then
        echo "❌ Не удалось определить цель make"
        return 1
    fi

    echo "🔍 Ищу команду 'make $target' в makefiles..."

    # Ищем команду во всех Makefile в репе
    local found_files=()
    while IFS= read -r -d '' file; do
        if grep -q "^$target:" "$file"; then
            found_files+=("$file")
        fi
    done < <(find . -name "Makefile" -o -name "makefile" -o -name "*.mk" -print0 2>/dev/null)

    if [[ ${#found_files[@]} -eq 0 ]]; then
        echo "❌ Команда '$target' не найдена в makefiles"
        return 1
    fi

    echo "✅ Найдена команда '$target' в:"
    for file in "${found_files[@]}"; do
        echo "  - $file"
    done

    # Берем первый найденный файл
    local source_file="${found_files[0]}"

    # Извлекаем цель и её команды
    local target_block=$(awk "/^$target:/{flag=1} flag && /^[^[:space:]]/ && !/^$target:/{flag=0} flag" "$source_file")

    if [[ -z "$target_block" ]]; then
        echo "❌ Не удалось извлечь блок для '$target'"
        return 1
    fi

    echo ""
    echo "📝 Найденный блок:"
    echo "$target_block"
    echo ""

    # Проверяем есть ли локальный Makefile
    if [[ ! -f "./Makefile" ]]; then
        echo -n "❓ Локальный Makefile не найден. Создать? (y/N): "
        read -r create_makefile
        if [[ "$create_makefile" =~ ^[Yy]$ ]]; then
            touch "./Makefile"
            echo "✅ Создан Makefile"
        else
            echo "❌ Отменено"
            return 1
        fi
    fi

    # Проверяем есть ли уже такая цель в локальном Makefile
    if grep -q "^$target:" "./Makefile"; then
        echo "⚠️  Цель '$target' уже существует в локальном Makefile"
        echo -n "Перезаписать? (y/N): "
        read -r overwrite
        if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
            echo "❌ Отменено"
            return 1
        fi

        # Удаляем существующую цель
        sed -i "/^$target:/,/^[^[:space:]]/{/^$target:/d; /^[[:space:]]/d; /^[^[:space:]]/!d}" "./Makefile"
    fi

    # Добавляем новую цель
    echo "" >> "./Makefile"
    echo "$target_block" >> "./Makefile"

    echo "✅ Команда '$target' добавлена в локальный Makefile"
    echo "🚀 Теперь можно запустить: make $target"
}

# Алиасы
alias fuck="makefixer"
alias fix="makefixer"
EOF

# Делаем исполняемым
chmod +x ~/.makefixer

# Добавляем в shell config
add_to_config() {
    local config_file="$1"
    if [[ -f "$config_file" ]]; then
        if ! grep -q "makefixer" "$config_file"; then
            echo "" >> "$config_file"
            echo "# Make Command Fixer" >> "$config_file"
            echo "source ~/.makefixer" >> "$config_file"
            echo "✅ Добавлено в $config_file"
        fi
    fi
}

# Настраиваем для текущего shell
case "$SHELL" in
    */zsh) add_to_config "$HOME/.zshrc" ;;
    */bash) add_to_config "$HOME/.bashrc" ;;
esac

echo ""
echo "🎉 Make Command Fixer установлен!"
echo ""
echo "Использование:"
echo "  $ make nonexistent-command"
echo "  $ fuck    # найдет команду в репе и добавит в Makefile"
echo ""
echo "Перезапустите терминал или выполните:"
echo "  source ~/.makefixer"

# Загружаем в текущую сессию
source ~/.makefixer
