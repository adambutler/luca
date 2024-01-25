module ApplicationHelper
  def greet
    case Time.zone.now.hour
    when 4..11 then "Good morning"
    when 12..17 then "Good afternoon"
    when 18..23 then "Good evening"
    else
      "Welcome"
    end
  end

  def gravitar_url(user, size: 256)
    email = user.email.downcase.strip
    hash = Digest::SHA2.hexdigest(email)
    "https://gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
