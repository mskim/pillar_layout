# == Schema Information
#
# Table name: annotation_underlines
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
#  index_annotation_underlines_on_annotation_id  (annotation_id)
#  index_annotation_underlines_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (annotation_id => annotations.id)
#  fk_rails_...  (user_id => users.id)
#
class AnnotationUnderline < ApplicationRecord
  before_create :init

  include Movement
  include Rails.application.routes.url_helpers

  belongs_to :annotation
  belongs_to :user

  def to_svg
    s = '<g class="annotation-group">'
    s += "<path d='M48.4,2.9c-0.96,0-1.91-0.21-2.79-0.64l-3.67-1.81c-1.47-0.72-3.22-0.72-4.69,0l-3.67,1.81c-1.74,0.86-3.83,0.86-5.57,0
    l-3.67-1.81c-1.47-0.72-3.22-0.72-4.69,0l-3.67,1.81c-1.75,0.86-3.83,0.86-5.57,0L6.74,0.45c-1.47-0.72-3.22-0.72-4.69,0l-1.83,0.9
    l-0.44-0.9l1.83-0.9c1.74-0.86,3.83-0.86,5.57,0l3.67,1.81c1.47,0.72,3.22,0.72,4.69,0l3.67-1.81c1.74-0.86,3.83-0.86,5.57,0
    l3.67,1.81c1.47,0.72,3.22,0.72,4.69,0l3.67-1.81c1.74-0.86,3.83-0.86,5.57,0l3.67,1.81c1.47,0.72,3.22,0.72,4.69,0l3.67-1.81
    c1.74-0.86,3.83-0.86,5.57,0l3.67,1.81c1.47,0.72,3.22,0.72,4.69,0l3.67-1.81c1.74-0.86,3.83-0.86,5.57,0l3.67,1.81
    c1.47,0.72,3.22,0.72,4.69,0l1.83-0.9l0.44,0.9l-1.83,0.9c-1.74,0.86-3.83,0.86-5.57,0l-3.67-1.81c-1.47-0.72-3.22-0.72-4.69,0
    l-3.67,1.81c-1.74,0.86-3.83,0.86-5.57,0l-3.67-1.81c-1.47-0.72-3.22-0.72-4.69,0l-3.67,1.81C50.31,2.69,49.36,2.9,48.4,2.9z' fill='crimson' stroke='white' stroke-width='0.3' transform='translate(#{x}, #{y})' class='draggable' data-underline-id='#{id}' data-user-id='#{user_id}' data-move-draggable-url='#{move_draggable_annotation_underline_path(self)}' />"
    s += "<a xlink:href='/annotation_underlines//#{id}/delete_it'>
    <g transform='translate(#{x - 8}, #{y - 8})' data-target='draggable.closeIcon' data-underline-id='#{id}' data-user-id='#{user_id}'>
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
