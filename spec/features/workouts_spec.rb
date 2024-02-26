require "rails_helper"

describe "workouts", type: :feature do
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

        fill_in "activity_set[load_actual]", with: "25"
        fill_in "activity_set[repetitions_actual]", with: "12"

        click_button "Add Set"

        expect(find(:xpath, "(//turbo-frame[@data-test-id='activity_card_frame'][1]//input[@data-test-id='activity_card_set_load_actual_input'])[2]").value).to eq "25"
        expect(find(:xpath, "(//turbo-frame[@data-test-id='activity_card_frame'][1]//input[@data-test-id='activity_card_set_repetitions_actual_input'])[2]").value).to eq "12"
      end
    end
  end
end
