class ApplicationController < ActionController::Base
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  rescue StandardError
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end
end
