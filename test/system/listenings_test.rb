require "application_system_test_case"

class ListeningsTest < ApplicationSystemTestCase
  setup do
    @listening = listenings(:one)
  end

  test "visiting the index" do
    visit listenings_url
    assert_selector "h1", text: "Listenings"
  end

  test "creating a Listening" do
    visit listenings_url
    click_on "New Listening"

    fill_in "Answer", with: @listening.answer
    fill_in "Cand1", with: @listening.cand1
    fill_in "Cand2", with: @listening.cand2
    fill_in "Cand3", with: @listening.cand3
    fill_in "Level", with: @listening.level
    fill_in "Question", with: @listening.question
    click_on "Create Listening"

    assert_text "Listening was successfully created"
    click_on "Back"
  end

  test "updating a Listening" do
    visit listenings_url
    click_on "Edit", match: :first

    fill_in "Answer", with: @listening.answer
    fill_in "Cand1", with: @listening.cand1
    fill_in "Cand2", with: @listening.cand2
    fill_in "Cand3", with: @listening.cand3
    fill_in "Level", with: @listening.level
    fill_in "Question", with: @listening.question
    click_on "Update Listening"

    assert_text "Listening was successfully updated"
    click_on "Back"
  end

  test "destroying a Listening" do
    visit listenings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Listening was successfully destroyed"
  end
end
