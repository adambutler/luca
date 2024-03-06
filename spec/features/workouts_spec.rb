require "rails_helper"

describe "workouts", type: :feature do
  include CapybaraHelper

  let(:user) { User.create(email: 'user@example.com', password: 'password') }

  before :each do
    sign_in(user)
  end

  it "allows me to create a workout" do
    visit '/workouts/new'
    fill_in "Scheduled at", with: Time.now.strftime("%Y-%m-%dT%H:%M")
    click_button "Add Workout"
    expect(page).to have_content "Activities"
  end

  context "given a workout" do
    let!(:workout) { Workout.create(scheduled_at: Time.now, user: user) }

    it "allows me to add an activity to the workout" do
      visit "/workouts/#{workout.id}"
      click_link "Add Activity"
      fill_in "Search exercises", with: "Romanian Deadlift"
      first("ul li button[type=submit]").click
      expect(page).to have_content "Activity was successfully created"
    end

    context "given an activity" do
      let!(:activity) { Activity.create(workout: workout, exercise: Exercise.find_by_title("Romanian Deadlift")) }

      it "allows me to add a set to the workout" do
        visit "/workouts/#{workout.id}"
        expect(page).to have_content "Romanian Deadlift"
        click_link "Romanian Deadlift"
        click_button "Add Set"
        expect(page).to have_content "W"
        expect(find_field("activity_set[load_goal]").value).to eq "20"
        expect(find_field("activity_set[load_actual]").value).to eq ""
        expect(find_field("activity_set[repetitions_goal]").value).to eq "8-10"
        expect(find_field("activity_set[repetitions_goal]").value).to eq "8-10"
        expect(find_field("activity_set[repetitions_actual]").value).to eq ""
        await_async
        find_set_field(activity_index: 1, set_index: 1, field: "repetitions_actual").fill_in(with: "12")
        await_async
        find_set_field(activity_index: 1, set_index: 1, field: "load_actual").fill_in(with: "25")
        expect(find_field("activity_set[load_actual]").value).to eq "25"
        expect(find_field("activity_set[repetitions_actual]").value).to eq "12"

        click_button "Add Set"


        expect(find_set_field(activity_index: 1, set_index: 2, field: "load_actual").value).to eq "25"
        expect(find_set_field(activity_index: 1, set_index: 2, field: "repetitions_actual").value).to eq "12"

        click_button "Add Set"

        find_set_field(activity_index: 1, set_index: 3, field: "load_goal").fill_in(with: "31")
        blur

        find_set_copy_link(activity_index: 1, set_index: 3, button: "load").click
        await_async
        expect(find_set_field(activity_index: 1, set_index: 3, field: "load_actual").value).to eq "31"
      end
    end
  end
end
