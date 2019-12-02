RLayout::Container.new(width:158.737,  height: 165.182) do
  line(x: 0 , y:1, width: 158.737, stroke_width: 2, height:0, stroke_color:"CMYK=0,0,0,100")
  text('경제시평', x: 0, y:5, font: 'KoPubDotumPB', font_size: 12, width: 170, text_color:"CMYK=0,0,0,100")
  rect(x: 0, y: 70, width:158.737, height: 65,  fill_color:"CMYK=0,0,0,10")
  
    image(local_image: '이원섭.eps', y: 60, width: 60, height: 75, fill_color: 'clear')
  
  container(x: 70, y: 80, width:150, bottom_margin: 10, fill_color: 'clear') do
    
      
        text('이원섭', y:17, font: 'KoPubDotumPB', font_size: 9, fill_color: 'clear', text_color:"CMYK=0,0,0,100")
      
      text('중소기업중앙회 ', y:30, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:"CMYK=0,0,0,100")
      text('회원지원본부장', y:41, font: 'KoPubDotumPL', font_size: 8, fill_color: 'clear', text_color:"CMYK=0,0,0,100")
    
  end
end
