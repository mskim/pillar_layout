# == Schema Information
#
# Table name: annotation_removes
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
#  index_annotation_removes_on_annotation_id  (annotation_id)
#  index_annotation_removes_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (annotation_id => annotations.id)
#  fk_rails_...  (user_id => users.id)
#
class AnnotationRemove < ApplicationRecord
  before_create :init

  include Movement
  include Rails.application.routes.url_helpers

  belongs_to :annotation
  belongs_to :user

  def to_svg
    s = '<g class="annotation-group">'
    s += "<path d='M0.45,17.55L0,16.42l0.23,0.57L0,16.42c0.01,0,1.03-0.42,2.2-1.5c0.98-0.9,1.78-1.97,2.38-3.19
    c-0.02,0.01-0.03,0.01-0.05,0.02c-1.1,0.33-2.05,0.27-2.83-0.19C0.56,10.89,0.28,9.6,0.27,9.55C0.26,9.5-0.11,7.9,0.77,6.68
    c0.53-0.74,1.38-1.17,2.52-1.27c1.77-0.16,3.01,0.64,3.4,2.19c0.09,0.37,0.13,0.77,0.1,1.18c1.36-1.62,2.29-4.29,1.89-8.21L9.9,0.45
    C10.46,6,8.54,9.34,6.26,10.91C4.44,15.91,0.63,17.48,0.45,17.55z M3.74,6.61c-0.11,0-0.23,0.01-0.35,0.02
    C2.63,6.69,2.08,6.95,1.77,7.39c-0.55,0.76-0.31,1.89-0.3,1.9c0,0.02,0.2,0.83,0.87,1.23c0.47,0.27,1.09,0.29,1.85,0.06
    c0.35-0.11,0.71-0.26,1.07-0.47c0.08-0.25,0.16-0.5,0.22-0.76c0.14-0.51,0.15-1.01,0.04-1.44C5.29,7.03,4.72,6.61,3.74,6.61z' fill='crimson' stroke='white' stroke-width='0.3' class='draggable' transform='translate(#{x}, #{y})' data-remove-marker-id='#{id}' data-user-id='#{user_id}' data-move-draggable-url='#{move_draggable_annotation_remove_path(self)}' />"
    s += "<a xlink:href='/annotation_removes/#{id}/delete_it'>
    <g transform='translate(#{x - 5}, #{y - 5})' data-target='draggable.closeIcon' data-remove-marker-id='#{id}' data-user-id='#{user_id}'>
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
