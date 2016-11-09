require 'telegram'

class NoticesController < ApplicationController
  def incoming
    chat_id = params["message"]["chat"]["id"]
    message = params["message"]["text"]

    render json: params
    user = User.where telegram_id: chat_id.to_s
    if !user.nil? && user.
      Telegram.send_message(chat_id, "Hi. If you are logged in to the site,
        please send your email address for verification.", true, [])
      verified_user = User.where email: message
      if !verified_user.nil?
        # update user record with telegram_id if email exists
        verified_user.first.update telegram_id: chat_id.to_s
        Telegram.send_message(chat_id, "telegram id updated", true, [])
      elsif verified_user.nil?
        Telegram.send_message(chat_id, "email not found. Send /start to try again.", true, [])
      end
    end
  end
end
