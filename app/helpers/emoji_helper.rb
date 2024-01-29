module EmojiHelper
  def emoji_key_to_emoji(key)
    case key.to_sym
    when :default then "🫥"
    when :great then "🔥"
    when :strong then "💪"
    when :good then "👍"
    when :bad then "👎"
    when :hard then "😓"
    when :medium then "👌"
    when :pain then "😖"
    when :injury then "🤕"
    when :skip then "🚫"
    when :replaced then "🔄"
    end
  end
end
