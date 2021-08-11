#!/usr/bin/env bash

# Set arguments
WEBHOOK_URL="$1"

# Variables
TMPFILE=$(mktemp)
USER_IP=$(echo $SSH_CLIENT | awk '{ print $1}')

# Grab IP information 1 time and cache it
curl -s "http://ip-api.com/json/${USER_IP}" > $TMPFILE

# Execute webhook
discord.sh \
    --webhook-url "$WEBHOOK_URL" \
    --username "DraimCiDo | Alerts" \
    --avatar "https://i.imgur.com/iXIShwr.png" \
    --title "Вход на draim-hist" \
    --description "Кто-то зашел под \`$(basename "$SHELL")\`.\n\n**Детали**\n:small_blue_diamond: Хост: \`$(hostname -f)\`\n:small_blue_diamond: Пользователь: \`$(whoami)\`\n:small_blue_diamond: TTY: \`${SSH_TTY}\`\n\n**Адрес гондона**\n:small_orange_diamond: IP: \`${USER_IP}\`\n:small_orange_diamond: Страна: \`$(cat $TMPFILE | jq -r .country)\`\n:small_orange_diamond: Город: \`$(cat $TMPFILE | jq -r .city)\`\n:small_orange_diamond: Регион: \`$(cat $TMPFILE | jq -r .regionName)\`\n:small_orange_diamond: Провайдер: \`$(cat $TMPFILE | jq -r .isp)\`"
