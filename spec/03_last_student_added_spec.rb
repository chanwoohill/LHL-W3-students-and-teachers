require_relative 'spec_helper'

describe Student do

  before :each do
    @student = Student.new
    @student.assign_attributes(
      first_name: 'Kreay',
      last_name: 'Shawn',
      birthday: Date.new(1989, 9, 24),
      gender: 'female',
      email: 'kreayshawn@oaklandhiphop.net',
      phone: '(510) 555-1212 x4567',
      teacher_id: 1
    )
    @teacher = Teacher.new
    @teacher.assign_attributes(
      name: 'Garrett Paul', 
      email: 'g_funk222@hotmail.com', 
      address: '304-1005 McKenzie Ave', 
      phone: '250-507-5610'
      )
  end

  context 'teacher sees date added' do
    
    it 'should check if student has a teacher' do
      expect(@student.teacher_id).to eq(1)
    end

    it 'teacher should see when student was added' do
      expect(@teacher.last_student_added_at).to eq(Date.today)
    end
  end
end
