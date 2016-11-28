require 'test_helper'

class HarambeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @harambee = harambees(:one)
  end

  test "should get index" do
    get harambees_url
    assert_response :success
  end

  test "should get new" do
    get new_harambee_url
    assert_response :success
  end

  test "should create harambee" do
    assert_difference('Harambee.count') do
      post harambees_url, params: { harambee: { description: @harambee.description, target_amount: @harambee.target_amount } }
    end

    assert_redirected_to harambee_url(Harambee.last)
  end

  test "should show harambee" do
    get harambee_url(@harambee)
    assert_response :success
  end

  test "should get edit" do
    get edit_harambee_url(@harambee)
    assert_response :success
  end

  test "should update harambee" do
    patch harambee_url(@harambee), params: { harambee: { description: @harambee.description, target_amount: @harambee.target_amount } }
    assert_redirected_to harambee_url(@harambee)
  end

  test "should destroy harambee" do
    assert_difference('Harambee.count', -1) do
      delete harambee_url(@harambee)
    end

    assert_redirected_to harambees_url
  end
end
