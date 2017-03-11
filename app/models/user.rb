class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :carts
  belongs_to :current_cart, :class_name => "Cart"

  def create_cart
    self.current_cart = self.carts.create
    save
  end

  def checkout_current_cart
    self.current_cart = nil
    save
  end
end
