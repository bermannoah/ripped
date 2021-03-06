require "rails_helper"

describe "/exercises/:id/solutions" do
  scenario "instructor sees all solutions for an exercise", :vcr do
    user = create(:user, census_id: 16, role: 1)
    exercise = create(:exercise)
    solution = create(:solution, exercise_id: exercise.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solutions_path(exercise)

    expect(page).to have_content(solution.content)
  end

  scenario "student sees all solutions for an exercise for which they have also submitted a solution", :vcr do
    user = create(:user, census_id: 14)
    exercise = create(:exercise)
    create(:solution, exercise: exercise, user: user)
    solution_1 = create(:solution, exercise_id: exercise.id)
    solution_2 = create(:solution, exercise_id: exercise.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_solutions_path(exercise)

    expect(page).to have_content(solution_1.content)
    expect(page).to have_content(solution_2.content)
  end

  scenario "users can access all solutions with a link on the exercise's show page", :vcr do
    user = create(:user, census_id: 14)
    exercise = create(:exercise)
    solution = create(:solution, exercise: exercise, user: user)
    solution_1 = create(:solution, exercise_id: exercise.id)
    solution_2 = create(:solution, exercise_id: exercise.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit exercise_path(exercise)

    click_on "See all submissions"

    expect(current_path).to eq(exercise_solutions_path(exercise))
    expect(page).to have_content(solution_1.content)
    expect(page).to have_content(solution_2.content)
  end
end
