class CategoriesController < ApplicationController
  PAGE_NUMBER = 20

  def index
    @categories = Category.all.order(created_at: :desc)
  end

  def show
    @category = Category.find(params[:id])
    @foods = @category.foods.page(params[:page]).per(PAGE_NUMBER)
  end
end
