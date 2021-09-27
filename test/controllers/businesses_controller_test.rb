require 'test_helper'

class BusinessesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @business = create(:business, name: 'google', domain: 'google.com')
  end

  def test_index
    get businesses_url
    assert_response :success
  end

  def test_index_with_search
    stub_request(:get, "https://autocomplete.clearbit.com/v1/companies/suggest?query=google").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>'Basic OnA=',
        'User-Agent'=>'Faraday v1.8.0'
        }).
      to_return(status: 200, body: %Q(
        [{
          "name": "Google",
          "domain": "google.com",
          "logo": "https://logo.clearbit.com/google.com"
        }]), headers: {})
    get businesses_url params: {search_str: "google"}
    assert_response :success
  end

  def test_new
    get new_business_url
    assert_response :success
  end

  def test_create
    assert_difference('Business.count') do
      post businesses_url, params: { business: { 
        name: "City Bank",
        address: "Government Hostel, Ground Floor Bhagwati Bhawan Crossing, MI Rd, Gopalbari",
        about: "Citibank is the consumer division of financial services multinational Citigroup.",
        city: "Jaipur",
        state: 'Rajasthan',
        post_code: '301001',
        contact_infos_attributes: [{contact_type: 'email', contact: 'city@gmail.com'}, {contact_type: 'phone', contact: '9995555555'}],
        owner_name: 'Mat',
        founded_year: '2000',
        no_of_employees: 200 } }
    end
    assert_redirected_to business_url(Business.last)
  end

  def test_create_with_failure
    assert_no_difference('Business.count') do
      post businesses_url, params: { business: { 
        name: "",
        owner_name: 'Mat',
        founded_year: '2000',
        no_of_employees: 200 } }
    end
    assert_response :unprocessable_entity    
  end

  def test_show
    get business_url(@business)
    assert_response :success
  end

  def test_show_with_domain
    stub_request(:get, "https://company.clearbit.com/v2/companies/find?domain=facebook.com").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>'Basic OnA=',
        'User-Agent'=>'Faraday v1.8.0'
        }).
      to_return(status: 200, body: File.read("test/fixtures/business.json"), headers: {})
    assert_difference('Business.count') do  
      get business_url(id: 'facebook', query: 'facebook.com')
      assert_response :success
    end  
  end

  def test_edit
    get edit_business_url(@business)
    assert_response :success
  end

  def test_update
    patch business_url(@business), params: { business: { owner_name: 'Mat' } }
    assert_equal @business.reload.owner_name, 'Mat' 
    assert_redirected_to business_url(@business)
  end

  def test_update_failure
    patch business_url(@business), params: { business: { name: '' } }
    assert_response :unprocessable_entity 
  end

  def test_destroy
    assert_difference('Business.count', -1) do
      delete business_url(@business)
    end
    assert_redirected_to businesses_url
  end
end
