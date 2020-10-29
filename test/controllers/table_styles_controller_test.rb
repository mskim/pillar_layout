require 'test_helper'

class TableStylesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @table_style = table_styles(:one)
  end

  test "should get index" do
    get table_styles_url
    assert_response :success
  end

  test "should get new" do
    get new_table_style_url
    assert_response :success
  end

  test "should create table_style" do
    assert_difference('TableStyle.count') do
      post table_styles_url, params: { table_style: { category_level: @table_style.category_level, column: @table_style.column, heading_level: @table_style.heading_level, layout: @table_style.layout, name: @table_style.name, row: @table_style.row } }
    end

    assert_redirected_to table_style_url(TableStyle.last)
  end

  test "should show table_style" do
    get table_style_url(@table_style)
    assert_response :success
  end

  test "should get edit" do
    get edit_table_style_url(@table_style)
    assert_response :success
  end

  test "should update table_style" do
    patch table_style_url(@table_style), params: { table_style: { category_level: @table_style.category_level, column: @table_style.column, heading_level: @table_style.heading_level, layout: @table_style.layout, name: @table_style.name, row: @table_style.row } }
    assert_redirected_to table_style_url(@table_style)
  end

  test "should destroy table_style" do
    assert_difference('TableStyle.count', -1) do
      delete table_style_url(@table_style)
    end

    assert_redirected_to table_styles_url
  end
end
