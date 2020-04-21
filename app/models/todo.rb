class Todo < ActiveRecord::Base
  validates :todo_text, presence: true, length: { minimum: 2 }
  validates :due_date, presence: true

  belongs_to :user

  def self.of_user(user)
    all.where(user_id: user.id)
  end

  def self.overdue
    all.where("due_date < ? and completed = ?", Date.today, false)
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def due_today?
    due_date == Date.today
  end

  def self.completed
    all.where(completed: true)
  end

  def self.mark_as_complete!(todo_id)
    todo = find(todo_id)
    todo.completed = true
    todo.save
    todo
  end
end
