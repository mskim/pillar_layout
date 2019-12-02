RLayout::NewsAdBox.new(is_ad_box: true, column: 3, row: 7, page_heading_margin_in_lines: 3) do
  image(image_path: 'some_path', layout_expand: [:width, :height])
  relayout!
end
