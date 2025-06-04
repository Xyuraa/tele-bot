#!/bin/bash
echo "🔧 Mengupdate dan menginstall Metasploit..."
pkg update && pkg upgrade -y
pkg install unstable-repo -y
pkg install metasploit -y

echo "📦 Menginstall dependensi Python..."
pip install pyTelegramBotAPI requests

echo "✅ Instalasi selesai. Untuk menjalankan:"
echo "1. Jalankan Metasploit: msfconsole"
echo "2. Jalankan bot: python bot.py"
echo "3. Jalankan executor: bash executor.sh"
