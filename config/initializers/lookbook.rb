Rails.application.configure do
  config.lookbook.project_name = "Luca"
  config.view_component.show_previews = true
  config.view_component.default_preview_layout = "view_component_preview"
  config.view_component.preview_paths = ["lookbook/previews"]
  config.lookbook.page_paths = ["lookbook/docs"]
end
