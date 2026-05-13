# v19-project

Учебный проект по дисциплине «Технологии распространения, развёртывания и сопровождения ПО».
**Вариант 19.**

> ⚠️ Курс изначально предполагал GitLab, однако при регистрации у меня просили ввести кредитную карту, которой у меня разумеется нет.
> Поэтому весь CI/CD реализован на **GitHub Actions** — функциональный аналог GitLab CI/CD.
> Соответствие этапов:
> - `.gitlab-ci.yml` → `.github/workflows/ci-cd.yml`
> - GitLab Runner → GitHub-hosted runners
> - GitLab Registry → GitHub Container Registry (`ghcr.io`)
> - GitLab Releases → GitHub Releases

---

## Задача (вариант 19)

Программа на C++. Даны два массива `X(10)` и `Y(10)`. Создать новый массив `Z`, включив в него:
- все элементы из `X`, которые больше максимального элемента `Y`,
- все элементы из `Y`, которые меньше минимального элемента `X`.

## Структура проекта

```
v19-project/
├── .github/workflows/
│   └── ci-cd.yml          # пайплайн (build → test → package → deploy → release)
├── DEBIAN/
│   └── control            # описание deb-пакета + зависимости
├── cicd/
│   └── run_tests.sh       # юнит-тесты (5 кейсов)
├── src/
│   └── main.cpp           # исходник программы
├── Dockerfile             # для практической №3
├── Makefile               # сборка и .deb
├── .gitignore
└── README.md
```

## Сборка локально

```bash
make          # проверка зависимостей + сборка
make run      # запуск
make test     # тесты
make deb      # сборка .deb пакета
make clean    # очистка

# Установка
sudo dpkg -i build/v19-project.deb
v19
```

## Пайплайн CI/CD

Запускается автоматически при `git push` в `main` или при создании тега `v*`.

| Stage     | Что делает                                                  |
|-----------|-------------------------------------------------------------|
| `build`   | `make build` → собирает бинарник, сохраняет как артефакт    |
| `test`    | Гоняет `cicd/run_tests.sh` против бинарника из артефакта    |
| `package` | `make deb` → собирает .deb, сохраняет как артефакт          |
| `deploy`  | Собирает Docker-образ с .deb внутри, пушит в `ghcr.io`      |
| `release` | (Только по тегу) Создаёт GitHub Release с .deb-файлом       |

### Создание релиза

```bash
git tag v1.1
git push origin v1.1
```

## Docker

После прохождения пайплайна образ доступен в GitHub Container Registry:

```bash
docker pull ghcr.io/USERNAME/v19-project:latest

echo "1 2 3 4 5 6 7 8 9 100
10 20 30 40 50 -5 -10 0 25 35" | docker run -i --rm ghcr.io/USERNAME/v19-project:latest
```

Ожидаемый вывод: `Array Z: 100 -5 -10 0`

## Зависимости

**Сборка:** `g++` (≥ 9), `make`, `dpkg-dev`
**Запуск:** `libc6 (>= 2.31)`, `libstdc++6`

## Версия

**1.1** — добавлен Docker-деплой в `ghcr.io`.
**1.0** — первый релиз с пайплайном build/test/package.
