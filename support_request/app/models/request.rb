class Request < ActiveRecord::Base
  validates :name, presence: :true
  validates :email, presence: :true

  scope :search, lambda {|search_term| where("name LIKE ? OR email LIKE ? OR department LIKE ? or message LIKE ?","%#{search_term}%","%#{search_term}%","%#{search_term}%","%#{search_term}%")}
 

end
