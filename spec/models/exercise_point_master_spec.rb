require 'rails_helper'

# TODO: Fix tests
RSpec.describe ExercisePointMaster do
  let(:course) do
    Module.new do
      module_function

      def exercises
        {
          1 => [ 2, Date.new(2015, 11, 27)],
          2 => [ 4, Date.new(2015, 12, 14)],
        }
      end

      def points
        {
          1 => (0..2),
          2 => (0..4),
        }
      end
    end
  end
  subject { described_class.new(course) }

  describe '.points(exercise_result)' do

    let(:first)  { ExerciseResult.new(exercise_id: 1) }
    let(:second) { ExerciseResult.new(exercise_id: 2) }

    it 'returns the correct points' do
      expect(subject.points(first)).to eq 2
      expect(subject.points(second)).to eq 4
    end
  end

  describe '.deadline(exercise_result)' do
    let(:first_exercise_result) { ExerciseResult.new(exercise_id: 1) }
    let(:second_exercise_result) { ExerciseResult.new(exercise_id: 2) }

    it 'returns the correct deadlines' do
      expect(subject.deadline(first_exercise_result)).to eq Date.parse('2015-11-27')
      expect(subject.deadline(second_exercise_result)).to eq Date.parse('2015-12-14')
    end
  end

  describe '.reached_deadline?(exercise_result)' do
    let(:sunday_night) { Date.parse('2015-11-22 23:55') }
    let(:in_time) { FactoryGirl.build_stubbed(:exercise_result, exercise_id: 1, created_at: sunday_night) }

    let(:saturday) { Date.parse('2015-11-28 08:00') }
    let(:too_late) { FactoryGirl.build_stubbed(:exercise_result, exercise_id: 1, created_at: saturday) }

    it 'returns true when the deadline is matched' do
      expect(subject.reached_deadline?(in_time)).to eq true
      expect(subject.reached_deadline?(too_late)).to eq false
    end
  end

  describe '.evaluate!(exercise_result)' do
    let(:sunday_night) { Date.parse('2015-11-22 23:55') }
    let(:in_time) { FactoryGirl.create(:exercise_result, exercise_id: 1, created_at: sunday_night) }

    let(:saturday) { Date.parse('2015-11-28 08:00') }
    let(:too_late) { FactoryGirl.create(:exercise_result, exercise_id: 1, created_at: saturday) }

    it 'adds the given points to the app' do
      pending 'Fixme'
      expect(in_time.app.exercise_points).to eq 0
      expect(too_late.app.exercise_points).to eq 0

      subject.evaluate!(in_time)
      subject.evaluate!(too_late)

      expect(in_time.app.exercise_points).to eq 2
      expect(too_late.app.exercise_points).to eq 0
    end
  end
end

