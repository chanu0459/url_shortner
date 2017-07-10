require 'test_helper'

class UrlShortnersControllerTest < ActionController::TestCase
  setup do
    @url_shortner = url_shortners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:url_shortners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create url_shortner" do
    assert_difference('UrlShortner.count') do
      post :create, url_shortner: { clicks: @url_shortner.clicks, unique_code: @url_shortner.unique_code, url: @url_shortner.url }
    end

    assert_redirected_to url_shortner_path(assigns(:url_shortner))
  end

  test "should show url_shortner" do
    get :show, id: @url_shortner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @url_shortner
    assert_response :success
  end

  test "should update url_shortner" do
    put :update, id: @url_shortner, url_shortner: { clicks: @url_shortner.clicks, unique_code: @url_shortner.unique_code, url: @url_shortner.url }
    assert_redirected_to url_shortner_path(assigns(:url_shortner))
  end

  test "should destroy url_shortner" do
    assert_difference('UrlShortner.count', -1) do
      delete :destroy, id: @url_shortner
    end

    assert_redirected_to url_shortners_path
  end
end
