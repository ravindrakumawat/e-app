require 'test_helper'

class SocialAccountsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @business = create(:business)
    @social_account = create(:social_account, social_network: 'facebook', handle: '/facebook', business: @business)
  end

  def test_index
    get business_social_accounts_url(@business)
    assert_response :success
  end

  def test_new
    get new_business_social_account_url(@business)
    assert_response :success
  end

  def test_create
    assert_difference('SocialAccount.count') do
      post business_social_accounts_url(@business), params: { social_account: { social_network: 'facebook', handle: '/facebook' } }
    end

    assert_redirected_to business_social_accounts_url(@business)
  end

  def test_create_failure
    assert_no_difference('SocialAccount.count') do
      post business_social_accounts_url(@business), params: { social_account: { social_network: '', handle: '/facebook' } }
    end
    assert_response :unprocessable_entity
  end

  def test_edit
    get edit_business_social_account_url(@business,@social_account)
    assert_response :success
  end

  def test_update
    patch business_social_account_url(@business,@social_account), params: { social_account: { handle: '/facebook/citybank' } }
    assert_redirected_to business_social_accounts_url(@business)
  end

  def test_update_failure
    patch business_social_account_url(@business,@social_account), params: { social_account: { social_network: '' } }
    assert_response :unprocessable_entity
  end

  def test_destroy
    assert_difference('SocialAccount.count', -1) do
      delete business_social_account_url(@business, @social_account)
    end
    assert_redirected_to business_social_accounts_url(@business)
  end
end
