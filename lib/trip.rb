class Trip < ActiveRecord::Base
  belongs_to :users
  belongs_to :countries
end