RLayout::Container.new({:width=>1114.0158780000002, :height=>1544.88207, :left_margin=>42.519690000000004, :top_margin=>42.519690000000004, :right_margin=>42.519690000000004, :bottom_margin=>42.519690000000004, :stroke_width=>0.5}) do
  rectangle(x: 42.519690000000004, y: 42.519690000000004, width: 1028.976498, height: 139.03263714285714, fill_color: 'lightGray')
  rectangle(x: 42.519690000000004, y: 42.519690000000004, width: 1028.976498, height: 55.613054857142856, fill_color: 'gray')
  rectangle(x: 42.519690000000004, y: 42.519690000000004, width: 1028.976498, height: 41.70979114285714, fill_color: 'darkGray')

  x_position = 42.519690000000004
  7.times do
    rectangle(x: x_position, y: 42.519690000000004, width: 136.063008, height: 1459.84269, stroke_width: 0.5, fill_color: 'clear')
    x_position += 136.063008 + 12.755905511811
  end
  y = 42.519690000000004
  15.times do |i|
    line(x: 42.519690000000004, y: y , width: 1028.976498, height: 0, stroke_width: 0.6, stroke_color: 'red', fill_color: 'clear')
    line_top = y
    7.times do |j|
      line(x: 42.519690000000004, y: line_top , width: 1028.976498, height: 0, stroke_width: 0.1, stroke_color: 'red', fill_color: 'clear')
      line_top += 13.903263714285714
    end
    y += 97.322846
  end
end
