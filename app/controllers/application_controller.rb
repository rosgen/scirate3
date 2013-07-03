class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  before_filter :redirect_https

  before_filter :add_notice

  def redirect_https
    if (!request.ssl? && Rails.env.production?)
      redirect_to protocol: "https://", host: ENV['HOST']
    end
    return true
  end

  def add_notice
    flash[:alert] = 'Notice: arxiv.org is experiencing technical difficulties regarding automated access.  Scirate will be updated once these issues are resolved.'
  end
end
