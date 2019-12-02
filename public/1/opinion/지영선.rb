RLayout::Container.new(width:158.737,  height: 166.836) do
  line(x: 0 , y:1, width: 158.737, stroke_width: 2, height:0, storke_color:"CMYK=0,0,0,100")
  text('지영선의 초록희망', x: 0, y:5, font: 'KoPubDotumPB', font_size: 12, width: 170, text_color:"CMYK=0,0,0,100")
  rect(x: 0, y: 70, width:158.737, height: 65,  fill_color:"CMYK=0,0,0,10")
  
    image(local_image: '지영선.eps', y: 60, width: 60, height: 75, fill_color: 'clear')
  
  container(x: 70, y: 80, width:150, bottom_margin: 10, fill_color: 'clear') do
    
      
        text('지영선', y:17, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:"CMYK=0,0,0,100")
      
      text('언론인', y:30, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:"CMYK=0,0,0,100")
      text('생명의숲 공동대푱', y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:"CMYK=0,0,0,100")
    
  end
end
