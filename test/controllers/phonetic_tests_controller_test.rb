require 'test_helper'

class PhoneticTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phonetic_test = phonetic_tests(:one)
  end

  test "should get index" do
    get phonetic_tests_url
    assert_response :success
  end

  test "should get new" do
    get new_phonetic_test_url
    assert_response :success
  end

  test "should create phonetic_test" do
    assert_difference('PhoneticTest.count') do
      post phonetic_tests_url, params: { phonetic_test: { answer: @phonetic_test.answer, cand1: @phonetic_test.cand1, cand2: @phonetic_test.cand2, cand3: @phonetic_test.cand3, question: @phonetic_test.question } }
    end

    assert_redirected_to phonetic_test_url(PhoneticTest.last)
  end

  test "should show phonetic_test" do
    get phonetic_test_url(@phonetic_test)
    assert_response :success
  end

  test "should get edit" do
    get edit_phonetic_test_url(@phonetic_test)
    assert_response :success
  end

  test "should update phonetic_test" do
    patch phonetic_test_url(@phonetic_test), params: { phonetic_test: { answer: @phonetic_test.answer, cand1: @phonetic_test.cand1, cand2: @phonetic_test.cand2, cand3: @phonetic_test.cand3, question: @phonetic_test.question } }
    assert_redirected_to phonetic_test_url(@phonetic_test)
  end

  test "should destroy phonetic_test" do
    assert_difference('PhoneticTest.count', -1) do
      delete phonetic_test_url(@phonetic_test)
    end

    assert_redirected_to phonetic_tests_url
  end
end
