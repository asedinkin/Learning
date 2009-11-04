class Product < ActiveRecord::Base
    validates_presence_of :title, :description, :img_url
    validates_numericality_of :price
    validates_uniqueness_of :id
    validates_format_of :img_url, :with => %r{\.(gif|jpg|png)$}i, :message => "Picture must to be a valid gif, jpg, or png image"
    
    protected
    def validate
      errors.add(:price, "Minimal price - 0.01" ) if price.nil? ||
      price < 0.01
    end
end
