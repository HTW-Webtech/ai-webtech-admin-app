require 'rails_helper'

describe User::Appraisal do
  let(:course) { double('Course', total_points: 100) }
  let(:user)   { double('User') }
  subject { described_class.new(user, course: course) }

  describe '#percentage' do
    it 'for a user with 0 total_points it equals 0' do
      allow(user).to receive(:total_points).and_return(0)
      expect(subject.percentage).to eq 0
    end

    it 'for a user with 79 total_points it equals 79' do
      allow(user).to receive(:total_points).and_return(79)
      expect(subject.percentage).to eq 79
    end

    it 'for a user with 150 total_points it equals 100' do
      allow(user).to receive(:total_points).and_return(150)
      expect(subject.percentage).to eq 100
    end

    it 'rounds the percentage down in case of a fraction' do
      allow(course).to receive(:total_points).and_return(11)
      allow(user).to receive(:total_points).and_return(4)
      expect(subject.percentage).to eq 36
    end
  end

  describe '#grade' do
    it 'returns 5.0 for percentage < 50' do
      allow(subject).to receive(:percentage).and_return(48)
      expect(subject.grade).to eq 5.0
    end

    it 'returns 4.0 for 50 >= percentage < 55' do
      allow(subject).to receive(:percentage).and_return(50)
      expect(subject.grade).to eq 4.0
    end

    it 'returns 3.7 for 55 >= percentage < 60' do
      allow(subject).to receive(:percentage).and_return(55)
      expect(subject.grade).to eq 3.7
    end

    it 'returns 3.3 for 60 >= percentage < 65' do
      allow(subject).to receive(:percentage).and_return(60)
      expect(subject.grade).to eq 3.3
    end

    it 'returns 3.0 for 65 >= percentage < 70' do
      allow(subject).to receive(:percentage).and_return(65)
      expect(subject.grade).to eq 3.0
    end

    it 'returns 2.7 for 70 >= percentage < 75' do
      allow(subject).to receive(:percentage).and_return(70)
      expect(subject.grade).to eq 2.7
    end

    it 'returns 2.3 for 75 >= percentage < 80' do
      allow(subject).to receive(:percentage).and_return(75)
      expect(subject.grade).to eq 2.3
    end

    it 'returns 2.0 for 80 >= percentage < 85' do
      allow(subject).to receive(:percentage).and_return(80)
      expect(subject.grade).to eq 2.0
    end

    it 'returns 1.7 for 85 >= percentage < 90' do
      allow(subject).to receive(:percentage).and_return(85)
      expect(subject.grade).to eq 1.7
    end

    it 'returns 1.3 for 90 >= percentage < 95' do
      allow(subject).to receive(:percentage).and_return(90)
      expect(subject.grade).to eq 1.3
    end

    it 'returns 1.0 for 95 >= percentage <= 100' do
      allow(subject).to receive(:percentage).and_return(95)
      expect(subject.grade).to eq 1.0
    end
  end
end
