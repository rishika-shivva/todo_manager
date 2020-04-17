class Todo < ActiveRecord::Base
  belongs_to :user

  def self.of_user(user)
    all.where(user_id: user.id)
    where(user_id: current_user.id)
  end

  def self.overdue
    all.where("due_date < ?", Date.today)
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

  def self.notcompleted
    all.where(completed: false)
  end

  def self.mark_as_complete!(todo_id)
    todo = find(todo_id)
    todo.completed = true
    todo.save
    todo
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts all.overdue.displayable_list
    puts "\n\n"

    puts "Due Today\n"
    puts all.due_today.displayable_list
    puts "\n\n"

    puts "Due Later\n"
    puts all.due_later.displayable_list
    puts "\n\n"
  end
end
