require "application_system_test_case"

class WordsTest < ApplicationSystemTestCase
  setup do
    @word = words(:one)
  end

  test "visiting the index" do
    visit words_url
    assert_selector "h1", text: "Words"
  end

  test "creating a Word" do
    visit words_url
    click_on "New Word"

    fill_in "Answer", with: @word.answer
    fill_in "Cand1", with: @word.cand1
    fill_in "Cand2", with: @word.cand2
    fill_in "Cand3", with: @word.cand3
    fill_in "Level", with: @word.level
    fill_in "Question", with: @word.question
    click_on "Create Word"

    assert_text "Word was successfully created"
    click_on "Back"
  end

  test "updating a Word" do
    visit words_url
    click_on "Edit", match: :first

    fill_in "Answer", with: @word.answer
    fill_in "Cand1", with: @word.cand1
    fill_in "Cand2", with: @word.cand2
    fill_in "Cand3", with: @word.cand3
    fill_in "Level", with: @word.level
    fill_in "Question", with: @word.question
    click_on "Update Word"

    assert_text "Word was successfully updated"
    click_on "Back"
  end

  test "destroying a Word" do
    visit words_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Word was successfully destroyed"
  end
end
