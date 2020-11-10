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
  belongs_to :user
  
  def to_svg
    # s = "<a xlink:href='/annotation_comments/#{id}/toggle_selected'><rect fill='#{color}' stroke='red' stroke-width='1' fill-opacity='0.3' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
    s = '<g class="annotation-group">'
    s += "<rect fill='#{color}' stroke='red' stroke-width='1' fill-opacity='0.3' x='#{x}' y='#{y}' width='#{width}' height='#{height}' class='draggable' data-comment-id='#{id}' data-user-id='#{user_id}' data-move-draggable-url='#{move_draggable_annotation_comment_path(self)}' />\n"
    s += "<a xlink:href='/annotation_comments/#{id}/delete_it'><g transform='translate(#{x - 4}, #{y - 4})' data-target='draggable.closeIcon' data-comment-id='#{id}' data-user-id='#{user_id}'>
    <circle class='st0' cx='4' cy='4' r='4' fill='white'/>
    <path d='M4,0C1.8,0,0,1.8,0,4s1.8,4,4,4s4-1.8,4-4S6.2,0,4,0z M6,5C6,5.1,6,5.2,6,5.3L5.3,6C5.2,6,5.1,6,5,6L4,4.9L2.9,6
      C2.9,6,2.8,6,2.7,6L2,5.3C2,5.2,2,5.1,2,5l1.1-1L2,2.9C2,2.9,2,2.8,2,2.7L2.7,2C2.8,2,2.9,2,3,2l1,1.1L5,2C5.1,2,5.2,2,5.3,2L6,2.7
      C6,2.8,6,2.9,6,3L4.9,4L6,5z' stroke='white' stroke-width='0.3'/>
  </g></a>"
    s += "<path d='M9.7,2.8L8.8,3.7c-0.1,0.1-0.2,0.1-0.3,0L6.3,1.6c-0.1-0.1-0.1-0.2,0-0.3l0.9-0.9c0.4-0.4,1-0.4,1.3,0l1.2,1.2
    C10.1,1.9,10.1,2.5,9.7,2.8z M5.6,2L0.4,7.1L0,9.5C0,9.8,0.2,10.1,0.6,10.1l2.4-0.4l5.1-5.1c0.1-0.1,0.1-0.2,0-0.3L5.9,2
    C5.8,1.9,5.7,1.9,5.6,2L5.6,2z M2.4,6.7c-0.1-0.1-0.1-0.3,0-0.4l3-3c0.1-0.1,0.3-0.1,0.4,0c0.1,0.1,0.1,0.3,0,0.4l-3,3
    C2.7,6.8,2.5,6.8,2.4,6.7L2.4,6.7z M1.7,8.3h0.9v0.7L1.4,9.3L0.8,8.7L1,7.4h0.7V8.3z' stroke='white' stroke-width='0.3' transform='translate(#{x + (width / 2) - 5}, #{y + (height / 2) -5})' class='cursor-modal' data-toggle='modal' data-comment-id='#{id}' data-target='#comment#{id}Modal, draggable.commentIcon'/>"
    s += "<defs>
        <clipPath id='avatarComment#{id}'>
          <circle cx='#{x + 55}' cy='#{y - 5}' r='10' fill='#FFFFFF' data-target='draggable.mask' data-comment-id='#{id}' />
        </clipPath>
    </defs>"
    s += "<image xlink:href='#{Rails.application.routes.url_helpers.rails_blob_path(user.avatar, only_path: true)  if user.avatar.attached?}' x='#{x + 45}' y='#{y - 15}' width='20' height='20' clip-path='url(#avatarComment#{id})' class='avatar' data-target='draggable.avatar' data-comment-id='#{id}' />\n"
    s += '</g>'
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
    self.user_id = user_id
    self.color = 'red'
    self.x = 100
    self.y = 100
    self.width = 50
    self.height = 20
  end
end
