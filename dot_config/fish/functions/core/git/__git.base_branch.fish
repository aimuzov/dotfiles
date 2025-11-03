function __git.base_branch -d "Определяет базовую ветку, от которой ответвилась текущая"
    # Логика определения базовой ветки (по приоритету):
    # 1. Проверяем upstream ветку (HEAD@{upstream})
    # 2. Ищем среди стандартных веток (main, master, develop, development)
    # 3. Возвращаем 'main' как дефолтное значение

    set -l upstream (git rev-parse --abbrev-ref HEAD@{upstream} 2>/dev/null)

    if test -n "$upstream"
        echo (string replace 'origin/' '' $upstream)
        return 0
    end

    set -l common_branches main master develop development

    for branch in $common_branches
        if git show-ref --verify --quiet refs/heads/$branch
            echo $branch
            return 0
        end
    end

    # Fallback: если не найдено ни одной стандартной ветки, возвращаем 'main'
    echo main

    return 0
end
