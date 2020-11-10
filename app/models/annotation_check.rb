# == Schema Information
#
# Table name: annotation_checks
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
#  index_annotation_checks_on_annotation_id  (annotation_id)
#  index_annotation_checks_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (annotation_id => annotations.id)
#  fk_rails_...  (user_id => users.id)
#
class AnnotationCheck < ApplicationRecord
  before_create :init

  include Movement
  include Rails.application.routes.url_helpers

  belongs_to :annotation
  belongs_to :user

  def to_svg
    # class='draggable' transform='translate(#{x}, #{y})' data-check-id='#{id}' data-move-draggable-url='#{move_draggable_annotation_check_path(self)}'
    s = "<g class='annotation-group'>"
    s += "<path d='M6.8,17.2l-6.5-6.5c-0.4-0.4-0.4-1,0-1.4l1.4-1.4c0.4-0.4,1-0.4,1.4,0l4.4,4.4l9.4-9.4c0.4-0.4,1-0.4,1.4,0l1.4,1.4
    c0.4,0.4,0.4,1,0,1.4L8.2,17.2C7.8,17.6,7.2,17.6,6.8,17.2L6.8,17.2z' fill='crimson' stroke='white' stroke-width='0.3' class='draggable' transform='translate(#{x}, #{y})' data-check-id='#{id}' data-user-id='#{user_id}' data-move-draggable-url='#{move_draggable_annotation_check_path(self)}'/>"
    s += "<defs>
      <clipPath id='avatarCheck#{id}'>
        <circle cx='#{x + 25}' cy='#{y - 10}' r='10' fill='#FFFFFF' data-target='draggable.mask' data-check-id='#{id}' />
      </clipPath>
    </defs>"
    s += "<image xlink:href='#{Rails.application.routes.url_helpers.rails_blob_path(user.avatar, only_path: true) if user.avatar.attached?}' x='#{x + 15}' y='#{y - 20}' width='20' height='20' clip-path='url(#avatarCheck#{id})' class='avatar' data-target='draggable.avatar' data-check-id='#{id}' />\n"
    s += "<a xlink:href='/annotation_checks/#{id}/delete_it'>
    <g transform='translate(#{x - 4}, #{y - 4})' data-target='draggable.closeIcon' data-check-id='#{id}' data-user-id='#{user_id}'>
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
