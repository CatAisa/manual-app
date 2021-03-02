class Users::SessionsController < Devise::SessionsController
  def new_guest
    guest_id = params[:guest_id]
    user = User.guest("guest#{guest_id}")
    sign_in user
    redirect_to root_path
  end
end
