class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    current_page = params[:page] ||= 1
    @products = Product.where(visible:true).order('id DESC').paginate(page: current_page, per_page: 10)
  end

  def show
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product), notice: "El producto se actualizó de forma exitosa." 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create product_params
    if @product.persisted?
      redirect_to product_path(@product), notice: "El producto se creo de forma exitosa."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other, notice: 'El producto se elimino de forma exitosa.'
  end

  def search
    @q = params[:q]
    @products = Product.where("name LIKE ?", "%#{@q}%").where(visible:true)
  end

  private

  def set_product
    #@product = Product.find params[:id]
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :visible, :image, category_ids: [])
  end
end
