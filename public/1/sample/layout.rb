RLayout::Container.new({:width=>1114.0157480314808, :height=>1544.8818897637584, :left_margin=>42.5196850393695, :top_margin=>42.5196850393695, :right_margin=>42.5196850393695, :bottom_margin=>42.5196850393695, :stroke_width=>0.5}) do
  rectangle(x: 42.5196850393695, y: 42.5196850393695, width: 1028.9763779527418, height: 139.0326209223828, fill_color: 'lightGray')
  rectangle(x: 42.5196850393695, y: 42.5196850393695, width: 1028.9763779527418, height: 55.613048368953116, fill_color: 'gray')
  rectangle(x: 42.5196850393695, y: 42.5196850393695, width: 1028.9763779527418, height: 41.70978627671484, fill_color: 'darkGray')

  x_position = 42.5196850393695
  7.times do
    rectangle(x: x_position, y: 42.5196850393695, width: 136.0629921259824, height: 1459.8425196850194, stroke_width: 0.5, fill_color: 'clear')
    x_position += 136.0629921259824 + 12.755905511810848
  end
  y = 42.5196850393695
  15.times do |i|
    line(x: 42.5196850393695, y: y , width: 1028.9763779527418, height: 0, stroke_width: 0.6, stroke_color: 'red', fill_color: 'clear')
    line_top = y
    7.times do |j|
      line(x: 42.5196850393695, y: line_top , width: 1028.9763779527418, height: 0, stroke_width: 0.1, stroke_color: 'red', fill_color: 'clear')
      line_top += 13.903262092238279
    end
    y += 97.32283464566795
  end
end
