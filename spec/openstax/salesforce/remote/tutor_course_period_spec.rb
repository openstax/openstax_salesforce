require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Remote::TutorCoursePeriod do

  subject { described_class.new }

  it 'can reset stats' do
    subject.num_periods = 1
    subject.num_students = 8
    subject.num_students_comped = 7
    subject.num_students_dropped = 6
    subject.num_students_paid = 5
    subject.num_students_refunded = 4
    subject.num_students_with_work = 3
    subject.num_teachers = 2

    subject.reset_stats

    expect(subject.num_periods).to eq 0
    expect(subject.num_students).to eq 0
    expect(subject.num_students_comped).to eq 0
    expect(subject.num_students_dropped).to eq 0
    expect(subject.num_students_paid).to eq 0
    expect(subject.num_students_refunded).to eq 0
    expect(subject.num_students_paid).to eq 0
    expect(subject.num_students_with_work).to eq 0
    expect(subject.num_teachers).to eq 0
  end

end
