RLayout::Container.new(width:158.74015748031,  height: 75) do
  rect(x: 0, y: 10, width:158.74015748031, height: 65, fill_color:"CMYK=0,0,0,10")
  image(local_image: '고인철.eps', from_right: 0, y: 0, width: 60, height: 75, fill_color: 'clear')
  container(x: 0, y: 20, width:100, bottom_margin: 10, fill_color: 'clear') do
    
      
      text('고인철', text_alignment: 'right', from_right: 10, y:17, font: 'KoPubDotumPB', font_size: 9,font_color:"CMYK=0,0,0,10", fill_color: 'clear')
      
      text('한국장애인고용공단', text_alignment: 'right', from_right: 10, y:30, font: 'KoPubDotumPL', font_size: 8, font_color:"CMYK=0,0,0,10", fill_color: 'clear')
      text('노조위원장', text_alignment: 'right', from_right: 10, y:41, font: 'KoPubDotumPL', font_size: 8, font_color:"CMYK=0,0,0,10", fill_color: 'clear')
    
  end
end
