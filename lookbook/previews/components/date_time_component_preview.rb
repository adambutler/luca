class Components::DateTimeComponentPreview < ViewComponent::Preview
  def default
    render DateTimeComponent.new(time: Time.now)
  end
end
