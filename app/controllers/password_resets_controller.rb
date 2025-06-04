class Web::PasswordResetsController < Web::ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
      if user
        reset = user.password_resets.create!(
          expires_at: 24.hours.from_now,
          used: false
        )
        UserMailer.password_reset(user, reset).deliver_now
      end
      redirect_to root_path, notice: 'Instructions sent if email exists'
    end

    def edit
      @reset = PasswordReset.find_by(token: params[:id])
      redirect_to new_password_reset_path, alert: 'Invalid token' unless @reset&.still_valid?
    end
  
    def update
      @reset = PasswordReset.find_by(token: params[:id])
      
      unless @reset&.still_valid?
        redirect_to new_password_reset_path, alert: 'Invalid or expired token'
        return
      end
  
      if params[:user][:password] == params[:user][:password_confirmation]
        @reset.user.update!(password: params[:user][:password])
        @reset.mark_used!
        redirect_to login_path, notice: 'Password updated successfully'
      else
        flash.now[:alert] = 'Passwords do not match'
        render :edit
      end
    end
  end