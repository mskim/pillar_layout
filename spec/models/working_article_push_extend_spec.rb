
require 'rails_helper'

RSpec.describe WorkingArticle, type: :model do
  subject{WorkingArticle.create(grid_x:0,  grid_y:0, column:2, row:3, pushed_line_count:13)}
  it "shoud update ext and pushed value" do
    subject.update_extended_and_pushed
    expect(subject.grid_y).to eq(1)
    expect(subject.y_in_lines).to eq(13)
  end
end