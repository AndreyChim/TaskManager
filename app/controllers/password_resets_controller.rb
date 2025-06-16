class Web::PasswordResetsController < Web::ApplicationController
    def new
    end
  
    def create
      form = PasswordResetRequestForm.new(email: params[:email])
  
      if form.save
        redirect_to root_path, notice: 'Instructions sent if email exists'
      else
        flash.now[:alert] = form.errors.full_messages.join(', ')
        render :new
      end
    end

    def edit
      form = PasswordResetForm.new(token: params[:id])
      form.valid? # Trigger validation to check token
      
      if form.errors.empty?
        @reset = form.reset
      else
        redirect_to new_password_reset_path, alert: form.errors.full_messages.join(', ')
      end
    end
  
    def update
      form = PasswordResetForm.new(
        token: params[:id],
        password: params[:user][:password],
        password_confirmation: params[:user][:password_confirmation]
      )
  
      if form.save
        redirect_to login_path, notice: 'Password updated successfully'
      else
        @reset = form.reset
        flash.now[:alert] = form.errors.full_messages.join(', ')
        render :edit
      end
    end
  end