RLayout::Container.new(width: 1028.976498, height: 41.70979114285714, layout_direction: 'horinoztal') do
  image(local_image: 'even.pdf', x: 0, y: 0, width: 1028.976498, height: 41.70979114285714, fit_type: 0)
  t = text('정 치', x: 464.0, y: -4, width: 100, font: 'KoPubBatangPM',  font_size: 20, text_color: "CMYK=0,0,0,100", fill_color:'clear', text_fit_type: 'fit_box_to_text', anchor_type: 'center', stroke_width: 1, stroke_sides:[1,1,1,1])
  line(x: t.x, y:22.8, width: t.width, stroke_width: 1, height:0, storke_color:"CMYK=0,0,0,100")
  text('2', tracking: -0.2, x: 3.7, y: -10.97, font: 'KoPubDotumPL', font_size: 33, text_color: "CMYK=0,0,0,100", width: 50, height: 44, fill_color: 'clear')
  text('0000년 0월 0일 0요일', tracking: -0.7, x: 46.505, y: 7.56, width: 200, font: 'KoPubDotumPL', font_size: 9.5, text_color: "CMYK=0,0,0,100", text_alignment: 'left', fill_color: 'clear')
end