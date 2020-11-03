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

  include Rails.application.routes.url_helpers

  belongs_to :annotation
  # belongs_to :user

  def to_svg
    # class='draggable' transform='translate(#{x}, #{y})' data-check-id='#{id}' data-move-draggable-url='#{move_draggable_annotation_check_path(self)}'
    s = "<path d='M6.8,17.2l-6.5-6.5c-0.4-0.4-0.4-1,0-1.4l1.4-1.4c0.4-0.4,1-0.4,1.4,0l4.4,4.4l9.4-9.4c0.4-0.4,1-0.4,1.4,0l1.4,1.4
    c0.4,0.4,0.4,1,0,1.4L8.2,17.2C7.8,17.6,7.2,17.6,6.8,17.2L6.8,17.2z' fill='red' class='draggable' transform='translate(#{x}, #{y})' data-check-id='#{id}' data-move-draggable-url='#{move_draggable_annotation_check_path(self)}'/>"
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
