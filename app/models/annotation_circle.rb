# == Schema Information
#
# Table name: annotation_circles
#
#  id            :bigint           not null, primary key
#  color         :string
#  height        :decimal(, )
#  width         :decimal(, )
#  x             :decimal(, )
#  y             :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  annotation_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_annotation_circles_on_annotation_id  (annotation_id)
#  index_annotation_circles_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (annotation_id => annotations.id)
#  fk_rails_...  (user_id => users.id)
#
class AnnotationCircle < ApplicationRecord
  before_create :init

  include Movement
  include Rails.application.routes.url_helpers

  belongs_to :annotation
  belongs_to :user 

  def to_svg
    # s = "<rect fill='#{color}' stroke='red' stroke-width='1' fill-opacity='0.3' x='#{x}' y='#{y}' width='#{width}' height='#{height}' class='draggable' data-comment-id='#{id}' data-target='draggable.circle' data-move-draggable-url='#{move_draggable_annotation_comment_path(self)}' />\n"
    s = '<g class="annotation-group">'
    s += "<circle cx='#{x}' cy='#{y}' r='20' stroke='#{color}' stroke-width='4' fill='white' fill-opacity='0' class='draggable' data-circle-id='#{id}' data-user-id='#{user_id}' data-move-draggable-url='#{move_draggable_annotation_circle_path(self)}' />"
    s += "<defs>
      <clipPath id='avatarCircle#{id}'>
        <circle cx='#{x + 25}' cy='#{y - 25}' r='10' fill='#FFFFFF' />
      </clipPath>
    </defs>"
    s += "<image xlink:href='#{Rails.application.routes.url_helpers.rails_blob_path(user.avatar, only_path: true)  if user.avatar.attached?}' x='#{x + 15}' y='#{y - 35}' width='20' height='20' clip-path='url(#avatarCircle#{id})' class='avatar' />\n"
    s += "<a xlink:href='/annotation_circles/#{id}/delete_it'>
    <g transform='translate(#{x - 24}, #{y - 24})' data-target='draggable.closeIcon' data-check-id='#{id}' data-user-id='#{user_id}'>
    <circle class='st0' cx='4' cy='4' r='4' fill='white'/>
    <path d='M4,0C1.8,0,0,1.8,0,4s1.8,4,4,4s4-1.8,4-4S6.2,0,4,0z M6,5C6,5.1,6,5.2,6,5.3L5.3,6C5.2,6,5.1,6,5,6L4,4.9L2.9,6
      C2.9,6,2.8,6,2.7,6L2,5.3C2,5.2,2,5.1,2,5l1.1-1L2,2.9C2,2.9,2,2.8,2,2.7L2.7,2C2.8,2,2.9,2,3,2l1,1.1L5,2C5.1,2,5.2,2,5.3,2L6,2.7
      C6,2.8,6,2.9,6,3L4.9,4L6,5z' stroke='white' stroke-width='0.3'/>
    </g></a>"
    s += '</g>'
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
