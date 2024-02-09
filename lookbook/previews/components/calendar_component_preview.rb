class Components::CalendarComponentPreview < ViewComponent::Preview
  # @param date date
  
  def default(date: Date.today.to_s)
    date = Date.parse(date.to_s)
    render CalendarComponent.new(date: date)
  end
end
