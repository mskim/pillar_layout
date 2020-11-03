# == Schema Information
#
# Table name: annotation_comments
#
#  id            :bigint           not null, primary key
#  color         :string
#  comment       :text
#  height        :integer
#  selected      :boolean
#  shape         :string
#  width         :integer
#  x             :integer
#  y             :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  annotation_id :bigint           not null
#  user_id       :bigint
#
# Indexes
#
#  index_annotation_comments_on_annotation_id  (annotation_id)
#  index_annotation_comments_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (annotation_id => annotations.id)
#
class AnnotationComment < ApplicationRecord
  before_create :init

  include Movement
  include Rails.application.routes.url_helpers
  
  belongs_to :annotation
  
  def to_svg
    # s = "<a xlink:href='/annotation_comments/#{id}/toggle_selected'><rect fill='#{color}' stroke='red' stroke-width='1' fill-opacity='0.3' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
    s = "<rect fill='#{color}' stroke='red' stroke-width='1' fill-opacity='0.3' x='#{x}' y='#{y}' width='#{width}' height='#{height}' class='draggable' data-comment-id='#{id}' data-move-draggable-url='#{move_draggable_annotation_comment_path(self)}' />\n"
    if selected
      sel_with = 4
      h_width = sel_with/2
      #top
      s += "<rect fill='black' stroke='black' stroke-width='1' fill-opacity='1' x='#{x - h_width}' y='#{y - h_width}' width='#{sel_with}' height='#{sel_with}' />\n"
      s += "<rect fill='black' stroke='black' stroke-width='1' fill-opacity='1' x='#{x+width - h_width}' y='#{y - h_width}' width='#{sel_with}' height='#{sel_with}' />\n"
      #bottom
      s += "<rect fill='black' stroke='black' stroke-width='1' fill-opacity='1' x='#{x - h_width}' y='#{y+height - h_width}' width='#{sel_with}' height='#{sel_with}' />\n"
      s += "<rect fill='black' stroke='black' stroke-width='1' fill-opacity='1' x='#{x+width - h_width}' y='#{y+height - h_width}' width='#{sel_with}' height='#{sel_with}' />\n"
    end
    s
  end

  private

  def init
    # self.user = current_user
    self.user_id = User.first.id
    self.color = 'red'
    self.x = 100
    self.y = 100
    self.width = 50
    self.height = 20
  end
end
