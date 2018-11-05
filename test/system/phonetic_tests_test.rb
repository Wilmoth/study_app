require "application_system_test_case"

class PhoneticTestsTest < ApplicationSystemTestCase
  setup do
    @phonetic_test = phonetic_tests(:one)
  end

  test "visiting the index" do
    visit phonetic_tests_url
    assert_selector "h1", text: "Phonetic Tests"
  end

  test "creating a Phonetic test" do
    visit phonetic_tests_url
    click_on "New Phonetic Test"

    fill_in "Answer", with: @phonetic_test.answer
    fill_in "Cand1", with: @phonetic_test.cand1
    fill_in "Cand2", with: @phonetic_test.cand2
    fill_in "Cand3", with: @phonetic_test.cand3
    fill_in "Question", with: @phonetic_test.question
    click_on "Create Phonetic test"

    assert_text "Phonetic test was successfully created"
    click_on "Back"
  end

  test "updating a Phonetic test" do
    visit phonetic_tests_url
    click_on "Edit", match: :first

    fill_in "Answer", with: @phonetic_test.answer
    fill_in "Cand1", with: @phonetic_test.cand1
    fill_in "Cand2", with: @phonetic_test.cand2
    fill_in "Cand3", with: @phonetic_test.cand3
    fill_in "Question", with: @phonetic_test.question
    click_on "Update Phonetic test"

    assert_text "Phonetic test was successfully updated"
    click_on "Back"
  end

  test "destroying a Phonetic test" do
    visit phonetic_tests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Phonetic test was successfully destroyed"
  end
end
