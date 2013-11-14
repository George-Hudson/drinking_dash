module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_order
    @current_order ||= Order.find_or_create_by(id: session[:order_id])

  end

  def admin?
    self.current_user.present? && self.current_user.admin_role
  end

  def cart_empty?
    current_order.order_items.count == 0
  end


end
