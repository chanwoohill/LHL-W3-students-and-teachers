class Student < ActiveRecord::Base

  belongs_to :teacher

  validates :birthday, presence: true
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validate :not_toddler?
  validate :teacher_not_retired

  after_save :new_student, if: :teacher

  def name
    "#{first_name} #{last_name}"
  end

  def age
    Date.today.year - birthday.year
  end

  def not_toddler?
    if Date.today.year - birthday.year <= 3
      errors.add(:birthday, "Still a toddler, can't go to school yet.")
    end
  end

  def new_student
    teacher.last_student_added_at = Date.today
    teacher.save
  end

  def teacher_not_retired
    if teacher.retirement_date <= Date.today
      errors.add(:teacher_id, "This teacher is retired so you must choose another.")
    end
  end
end
