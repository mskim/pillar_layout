 module WorkingArticleSaveXml
  extend ActiveSupport::Concern

  def eliminate_size_option(string)
    string = string.sub(/\{\s?(-?\d)\s?\}\s?$/, "\r\n") if string =~/\{\s?(-?\d)\s?\}\s?$/
  end

  def covert_to_multiple_line(string)
    return "" unless string
    if string.include?("\r\n")
        multiline              = string.split("\r\n")
        return multiline
    end
    string
  end

 end

__END__
sample_title = "this a {-5}"

result = eliminate_size_option(sample_title)

 a = "my string"
 result =covert_to_multiple_line(a)
 if result.class == string
    title1 = a
 else
    title1 = result[0]
    title2 = result[1]
 end