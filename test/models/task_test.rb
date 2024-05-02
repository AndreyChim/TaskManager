require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'create' do
    author = create(:user)
    task = create(:task, author: author, state: 'new_task')
    assert task.persisted?
  end
end
