class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  has_many :likes, :dependent => :destroy
  has_many :liked_posts, :through => :likes, :source => :post

  has_many :favorites, :dependent => :destroy
  has_many :favorited_posts, :through => :favorites, :source => :post

  def display_name
    ## 取email 的前半来显示，如果你也可以另开一个字段是 nickname 让用户可以自已
    #编缉显示名称
    self.email.split("@").first
  end

  def fav_post?(post)
    favorited_posts.include?(post)
  end

  def fav!(post)
    favorited_posts << post
  end

  def unfav!(post)
    favorited_posts.delete(post)
  end

  def is_admin?
    role == "admin"
  end

end
