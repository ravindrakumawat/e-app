require 'test_helper'

class ContactInfosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @business = create(:business)
    @contact_info = create(:contact_info, contact_type: 'phone', contact: '+1 650-618-7714', business: @business)
  end

  def test_index
    get business_contact_infos_url(@business)
    assert_response :success
  end

  def test_new
    get new_business_contact_info_url(@business)
    assert_response :success
  end

  def test_create
    assert_difference('ContactInfo.count') do
      post business_contact_infos_url(@business), params: { contact_info: { contact_type: 'phone', contact: '+1 650-618-7715' } }
    end

    assert_redirected_to business_contact_infos_url(@business)
  end

  def test_create_failure
    assert_no_difference('ContactInfo.count') do
      post business_contact_infos_url(@business), params: { contact_info: { contact_type: '', contact: '+1 650-618-7715' } }
    end
    assert_response :unprocessable_entity
  end

  def test_edit
    get edit_business_contact_info_url(@business,@contact_info)
    assert_response :success
  end

  def test_update
    patch business_contact_info_url(@business,@contact_info), params: { contact_info: { contact: '+1 650-618-7717' } }
    assert_redirected_to business_contact_infos_url(@business)
  end

  def test_update_failure
    patch business_contact_info_url(@business,@contact_info), params: { contact_info: { contact: '' } }
    assert_response :unprocessable_entity
  end

  def test_destroy
    assert_difference('ContactInfo.count', -1) do
      delete business_contact_info_url(@business, @contact_info)
    end
    assert_redirected_to business_contact_infos_url(@business)
  end
end
