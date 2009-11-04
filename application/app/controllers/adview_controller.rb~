class AdviewController < ApplicationController
  def index
    @products = Product.find(:all,:conditions => "price > 0" );
  end
end
