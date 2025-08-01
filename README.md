## Что надо установить
```bash
sudo apt install clangd-12 ripgrep lazygit
```
- clangd нужен версии >=12, чтобы подсветка синтаксиса работала корректно

Добавляем symlink на установленный clangd
```bash
ln -s /usr/bin/clangd-12 /usr/bin/clangd
```

Также нужны Nerd шрифты для отображения иконок в дереве файлов (например, Jet Brains Nerd Mono https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip)

## Генерация compile_commands.json
Чтобы lsp нормально подхватывал все инклуды, нужно сгенерировать файл `compile_commands.json`.

### В проектах с CMake
Для генерации этого файла  нужно при вызове CMake нужно указать флаг `-DCMAKE_EXPORT_COMPILE_COMMANDS=On`.

### В проетках без CMake
Потребуется сторонняя утилита bear
```bash
sudo apt install bear
```

Для генерации файла compile_commands.json запускаем сборку вот так:
```bash
bear -- make
```

## Сочетания клавиш (leader = пробел)

- leader + q -- поиск по функциям в текущем файле
- leader + f -- поиск по названиям всех файлов в проекте
  - C + t -- открыть файл в новом табе
- leader + k -- поиск по слову с указанием маски фильтрации
- leader + g -- поиск по всем словам в проекте (grep)
- leader + / -- поиск по всем словам в текущем файле (grep)
- leader + e -- открыть/закрыть дерево файлов
- leader + 1, leader + 2, leader + 3, ... -- открыть терминалы рядом (до 9 штук)
- leader + k -- (в Visual режиме) форматирование (cland) выделенного участка кода
- leader + ps -- поиск по слову, на котором стоит курсор
- leader + j -- посмотреть сообщение Warning или Error на строке
- leader + lg -- открыть lazygit окно
- leader + h -- подсветить переменную, на которой стоит курсор

## Комментирование кода
- gl -- закомментировать выделенный кусок кода построчно
- gb -- закомментировать выделенный кусок кода блочно

## Стандартные
- a -- создать файл (в nvim-tree)
- Ctrl + hjkl -- переместить фокус на другое окно (слева, снизу, сверху, справа)
- Ctrl + d/u -- переместить фокус пол страницы вверх/вниз
- leader + t + n -- создать новый таб
- leader + t + c -- закрыть таб
- leader + [ -- перейти к следующему табу
- leader + ] -- перейти к предыдущему табу
- gr -- поиск вызовов функций/методов
- gd -- перейти к определению/объявлению

### Сплит экранов
- Ctrl + w s -- сплит вверх (south)
- Ctrl + w n -- сплит сниз (north)
- Ctrl + w v --сплит вертикальный (vertical)
- Ctrl + w {HJKL} -- Поменять окна местами
- Ctrl + w o -- закрыть все окна, кроме текущего

### Метки
- m lowercase_letter -- поставить метку
- ` lowercase_letter -- прыгнуть к метке
- m UPPERCASE_LETTER -- поставить глобальную метк
- ` UPPERCASE_LETTER -- прыгнуть к глобальной метке
- :marks -- список всех меток
- :delm A-Z0-9 -- удалить метку

### Фолды
- zf -- создать фолт на выделенном куске кода
- za -- свернуть/развернуть фолд
- zc -- свернуть фолд
