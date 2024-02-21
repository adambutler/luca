require "rails_helper"

RSpec.describe ActivityBuilder, type: :service do
  describe "#build!" do
    let(:user) { FactoryBot.create(:user) }
    let(:workout) { FactoryBot.create(:workout, user: user) }
    let(:exercise) { Exercise.all.sample }

    subject {
      ActivityBuilder.new(workout: workout, exercise: exercise).build!
    }

    it "creates a new activity" do
      expect { subject }.to change(Activity, :count).by(1)
    end

    it "creates new activity sets" do
      expect { subject }.to change(ActivitySet, :count).by(4)
    end

    it "uses the default values" do
      activity = subject
      expect(activity.split).to eq(false)
      expect(activity.sets.map(&:load_goal)).to match_array([20, 40, 40, 40])
      expect(activity.sets.map(&:load_actual)).to match_array([nil, nil, nil, nil])
      expect(activity.sets.map(&:repetitions_goal)).to match_array([4..6, 8..10, 8..10, 8..10])
      expect(activity.sets.map(&:repetitions_actual)).to match_array([nil, nil, nil, nil])
      expect(activity.sets.map(&:warmup)).to match_array([true, false, false, false])
    end

    context "when the workout has a previous activity" do
      let(:split) { false }
      let!(:previous_workout) { FactoryBot.create(:workout, user: user, scheduled_at: workout.scheduled_at - 1.week) }
      let!(:previous_activity) { FactoryBot.create(:activity, workout: previous_workout, exercise: exercise, split: split) }
      
      before do
        FactoryBot.create(:activity_set, :warmup, load_goal: 15, load_actual: 15, repetitions_goal: 5..6, repetitions_actual: 6, activity: previous_activity)
        FactoryBot.create_list(:activity_set, 2, load_goal: 80, load_actual: 80, repetitions_goal: 10..12, repetitions_actual: 12, activity: previous_activity)
        FactoryBot.create(:activity_set, load_goal: 85, load_actual: 85, repetitions_goal: 10..12, repetitions_actual: 11, activity: previous_activity)
      end
      
      it "creates a new activity" do
        expect { subject }.to change(Activity, :count).by(1)
      end
      
      it "creates new activity sets" do
        expect { subject }.to change(ActivitySet, :count).by(4)
      end
      
      it "copies the goal values" do
        activity = subject
        expect(activity.split).to eq(false)
        expect(activity.sets.map(&:load_goal)).to match_array([15, 80, 80, 85])
        expect(activity.sets.map(&:load_actual)).to match_array([nil, nil, nil, nil])
        expect(activity.sets.map(&:repetitions_goal)).to match_array([5..6, 10..12, 10..12, 10..12])
        expect(activity.sets.map(&:repetitions_actual)).to match_array([nil, nil, nil, nil])
        expect(activity.sets.map(&:warmup)).to match_array([true, false, false, false])
      end

      context "in a split workout" do
        let(:split) { true }

        it "copies the split value" do
          activity = subject
          expect(activity.split).to eq(true)
        end
      end
    end
  end
end
