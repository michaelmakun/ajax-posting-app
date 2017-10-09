class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  def display_name
    ## 取email 的前半来显示，如果你也可以另开一个字段是 nickname 让用户可以自已
    #编缉显示名称
    self.email.split("@").first
  end

end
