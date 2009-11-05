class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  
  #Setting and updating field values (used for titles and descriptions)
  def self.in_place_loader_for(object, attribute, options = {})
    define_method("set_#{object.to_s.downcase}_#{attribute.to_s.downcase}" ) do
      @item = object.to_s.camelize.constantize.find(params[:id])
      @item.update_attribute(attribute.to_s.downcase, params[:value])
      @item.save
      render :text => @item.attributes[attribute.to_s.downcase]
    end
  end
  
  in_place_edit_for :Product, :title 
  in_place_loader_for :Product, :title
  in_place_edit_for :Product, :description
  in_place_loader_for :Product, :description
  
  
  
  #Setting titles
  #def set_product_title
    #product = Product.find(params[:id])
    #product.title = params[:value]
    #product.save
    #render :text => product.title
  #end
  
  #Setting description
  #def set_product_description
    #product = Product.find(params[:id])
    #product.description = params[:value]
    #product.save
    #render :text => product.description
  #end
 
  def index
    @products = Product.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to(@product) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
end
