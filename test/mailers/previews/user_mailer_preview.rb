class UserMailerPreview < ActionMailer::Preview
    def task_created
      user = User.first
      task = Task.first
      params = { user: user, task: task }
  
      UserMailer.with(params).task_created
    end

    def task_updated
        user = User.first
        task = Task.first
        
        task.name = "Updated Name"
        task.description = "Updated Description"
        
        changes = {
          "name" => ["Original Name", "Updated Name"],
          "description" => ["Original Description", "Updated Description"],
          "due_date" => [3.days.ago, Date.today]
        }
        
        UserMailer.with(user: user, task: task, changes: changes).task_updated
      end
    
      def task_deleted
        user = User.first
        task = Task.first
        
        UserMailer.with(
          user: user, 
          task_name: task.name,
          task_id: task.id
        ).task_deleted
      end
  end