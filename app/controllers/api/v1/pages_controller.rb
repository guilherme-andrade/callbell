class Api::V1::PagesController < ActionController::Base
  def index
    render file: Rails.root.join('public/packs/index.html')
  end
end
