require 'rails_helper'

RSpec.describe ExercisePointMaster do
  describe '.points(exercise_result)' do
    let(:first_exercise_result) { ExerciseResult.new(exercise_id: 1) }
    let(:third_exercise_result) { ExerciseResult.new(exercise_id: 3) }

    it 'returns the correct points' do
      expect(described_class.points(first_exercise_result)).to eq 2
      expect(described_class.points(third_exercise_result)).to eq 4
    end
  end

  describe '.deadline(exercise_result)' do
    let(:first_exercise_result) { ExerciseResult.new(exercise_id: 1) }
    let(:third_exercise_result) { ExerciseResult.new(exercise_id: 3) }

    it 'returns the correct deadlines' do
      expect(described_class.deadline(first_exercise_result)).to eq Date.parse('2015-11-24')
      expect(described_class.deadline(third_exercise_result)).to eq Date.parse('2015-12-14')
    end
  end

  describe '.reached_deadline?(exercise_result)' do
    let(:sunday_night) { Date.parse('2015-11-22 23:55') }
    let(:in_time) { FactoryGirl.build_stubbed(:exercise_result, exercise_id: 1, created_at: sunday_night) }

    let(:wednesday) { Date.parse('2015-11-25 08:00') }
    let(:too_late) { FactoryGirl.build_stubbed(:exercise_result, exercise_id: 1, created_at: wednesday) }

    it 'returns true when the deadline is matched' do
      expect(described_class.reached_deadline?(in_time)).to eq true
      expect(described_class.reached_deadline?(too_late)).to eq false
    end
  end

  describe '.evaluate!(exercise_result)' do
    let(:sunday_night) { Date.parse('2015-11-22 23:55') }
    let(:in_time) { FactoryGirl.create(:exercise_result, exercise_id: 1, created_at: sunday_night) }

    let(:wednesday) { Date.parse('2015-11-25 08:00') }
    let(:too_late) { FactoryGirl.create(:exercise_result, exercise_id: 1, created_at: wednesday) }

    it 'adds the given points to the app' do
      expect(in_time.app.exercise_points).to eq 0
      expect(too_late.app.exercise_points).to eq 0

      described_class.evaluate!(in_time)
      described_class.evaluate!(too_late)

      expect(in_time.app.exercise_points).to eq 2
      expect(too_late.app.exercise_points).to eq 0
    end
  end
end

