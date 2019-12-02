class Pillar < ApplicationRecord
  belongs_to :region, :polymorphic => true
end
