require 'test_helper'

class BusinessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business = create(:businesse)
  end

  test "should get index" do
    get businesses_url
    assert_response :success
  end

  test "should get new" do
    get new_business_url
    assert_response :success
  end

  test "should create business" do
    assert_difference('Business.count') do
      post businesses_url, params: { business: { 
        name: "City Bank",
        address: "Government Hostel, Ground Floor Bhagwati Bhawan Crossing, MI Rd, Gopalbari",
        about: "Citibank is the consumer division of financial services multinational Citigroup.",
        city: "Jaipur",
        state: 'Rajasthan',
        post_code: '301001',
        contact_email: 'city@gmail.com',
        phone_number: '9995555555',
        owner_name: 'Mat',
        founded_date: '2000-01-01',
        no_of_employees: 200 } }
    end
    assert_redirected_to business_url(Business.last)
  end

  test "should show business" do
    get business_url(@business)
    assert_response :success
  end

  test "should get edit" do
    get edit_business_url(@business)
    assert_response :success
  end

  test "should update business" do
    patch business_url(@business), params: { business: { owner_name: 'Mat' } }
    assert_equal @business.reload.owner_name, 'Mat' 
    assert_redirected_to business_url(@business)
  end

  test "should destroy business" do
    assert_difference('Business.count', -1) do
      delete business_url(@business)
    end

    assert_redirected_to businesses_url
  end
end
