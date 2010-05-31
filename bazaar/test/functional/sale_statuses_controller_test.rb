require 'test_helper'

class SaleStatusesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_status" do
    assert_difference('SaleStatus.count') do
      post :create, :sale_status => { }
    end

    assert_redirected_to sale_status_path(assigns(:sale_status))
  end

  test "should show sale_status" do
    get :show, :id => sale_statuses(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sale_statuses(:one).id
    assert_response :success
  end

  test "should update sale_status" do
    put :update, :id => sale_statuses(:one).id, :sale_status => { }
    assert_redirected_to sale_status_path(assigns(:sale_status))
  end

  test "should destroy sale_status" do
    assert_difference('SaleStatus.count', -1) do
      delete :destroy, :id => sale_statuses(:one).id
    end

    assert_redirected_to sale_statuses_path
  end
end
