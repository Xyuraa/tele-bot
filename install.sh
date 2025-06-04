# Isi dari install.sh
install_sh =
#!/bin/bash

echo "🔧 Mengupdate dan menginstall Metasploit..."
pkg update -y && pkg upgrade -y
pkg install -y unstable-repo
pkg install -y metasploit python

echo "📦 Menginstall dependensi Python..."
pip install pyTelegramBotAPI

echo "✅ Instalasi selesai. Untuk menjalankan:"
echo "1. Jalankan Metasploit: msfconsole"
echo "2. Jalankan bot: python bot.py"
echo "3. Jalankan executor: bash executor.sh"


# Simpan file-file tersebut
with open(f"{base_path}/bot.py", "w") as f:
    f.write(bot_py)

with open(f"{base_path}/executor.sh", "w") as f:
    f.write(executor_sh)

with open(f"{base_path}/install.sh", "w") as f:
    f.write(install_sh)

# Buat zip
zip_path = "/mnt/data/metatele_package.zip"
with zipfile.ZipFile(zip_path, 'w') as zipf:
    zipf.write(f"{base_path}/bot.py", arcname="bot.py")
    zipf.write(f"{base_path}/executor.sh", arcname="executor.sh")
    zipf.write(f"{base_path}/install.sh", arcname="install.sh")

zip_path
