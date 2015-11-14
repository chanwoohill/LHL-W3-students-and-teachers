class Student < ActiveRecord::Base

  belongs_to :teacher

  validates :birthday, presence: true
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validate :not_toddler?

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
end
