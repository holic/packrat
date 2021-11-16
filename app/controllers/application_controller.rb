class ApplicationController < ActionController::Base

  def current_wallet
    return unless session[:wallet]
    @current_wallet ||= Wallet.find_or_create_by(address: session[:wallet])
  end

end