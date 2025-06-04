class UserMailer < ApplicationMailer
    def task_created
      user = params[:user]
      @task = params[:task]
  
      mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'New Task Created')
    end

    def task_updated
      user = params[:user]
      @task = params[:task]
      @changes = params[:changes] 
    
      mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'Task Updated')
    end

    def task_deleted
      user = params[:user]
      @task_name = params[:task_name]  # Use name since task object might be destroyed
      @task_id = params[:task_id]      # Preserve ID for reference
      
      mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'Task Deleted')
    end

    def password_reset(user, reset)
      @user = user
      @reset = reset
      mail to: user.email, subject: 'Password Reset Instructions'
    end
end
