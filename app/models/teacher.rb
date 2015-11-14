class Teacher < ActiveRecord::Base
  
  has_many :students

  validates :hire_date, :retirement_date, presence: true
  validate :hired_before_retired

  after_save :teacher_loses_students

  def hired_before_retired
    if retirement_date < hire_date
      errors[:retirement_date, "You can't work after you retire."]
    elsif retirement_date > Date.today
      errors[:retirement_date, "Your retirement date is in the future."]
    end
  end

  def teacher_loses_students
    :teacher_id = nil if retirement_date <= Date.today
  end
end
