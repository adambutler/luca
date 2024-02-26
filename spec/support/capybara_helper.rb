module CapybaraHelper
  def blur
    find("body").click
  end

  def await_async
    sleep 0.1
  end

  def find_set_field(activity_index: 1, set_index: 1, field:)
    find(:xpath, [
      "(",
        "//turbo-frame[@data-test-id='activity_card_frame'][#{activity_index}]",
        "//input[@data-test-id='activity_card_set_#{field}_input']",
      ")[#{set_index}]"
    ].join)
  end

  def find_set_copy_link(activity_index: 1, set_index: 1, button:)
    find(:xpath, [
      "(",
        "//turbo-frame[@data-test-id='activity_card_frame'][#{activity_index}]",
        "//a[@data-test-id='activity_card_set_copy_#{button}']",
      ")[#{set_index}]"
    ].join)
  end
end
