RLayout::Container.new(width:158.74015748031, height: 162.83914494488) do
  line(x: 0 , y: 1.35, width: 158.74015748031, stroke_width: 3.5, height:0, stroke_color:'CMYK=0,0,0,100')
  text('신문로', x: 0, y:8, font: 'KoPubDotumPB', font_size: 12, width: 170, text_color:'CMYK=0,0,0,100')
  rect(x: 0, y: 70, width:158.74015748031, height: 65,  fill_color:'CMYK=0,0,0,10')
  
    image(local_image: '안종주.eps', y: 60, width: 60, height: 75, fill_color: 'clear')
  
  container(x: 70, y: 80, width:150, bottom_margin: 10, fill_color: 'clear') do
    
      
        text('안종주', y:17, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
      
      text('언론인', y:30, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
      text('단국대 보건복지대학원 초빙교수', tracking:-1.2, y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:'CMYK=0,0,0,100')
    
  end
end
