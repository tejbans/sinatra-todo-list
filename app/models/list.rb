class List <ActiveRecord::Base
  validates :name, :length => {:minimum => 3}
  belongs_to :user
  has_many  :tasks

  def self.valid_params?(params)
    return !params[:name].empty?
  end

end


