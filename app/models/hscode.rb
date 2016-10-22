class Hscode < ApplicationRecord
  has_many :imports
  has_many :exports
end
