class RegistrationsController < Devise::RegistrationsController


  def new
    super
  end

  def index
    super
  end

  def show
    super
  end

  def edit
    super
  end

  def create
    super
  end


  def update
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :user_type)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :user_type)
  end

end