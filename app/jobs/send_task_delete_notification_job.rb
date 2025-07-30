class SendTaskDeleteNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer
      
  def perform(task_id, author_id)
    user = User.find_by(id: author_id)
    return if user.blank?
  
    UserMailer.with(user: user, task: task_id).task_deleted.deliver_now
  end
end