class Task <ActiveRecord::Base
  belongs_to  :list

  def self.valid_params?(params)
    return !params[:description].empty? && !params[:priority].nil? && !params[:completed].nil? && !params[:list_id].nil?
  end

end