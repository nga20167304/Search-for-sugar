class FoodsController < ApplicationController
  PAGE_NUMBER = 20
  before_action :find_food, only: %i[update destroy]

  def index
    @q = Food.ransack(params[:q])
    @foods = @q.result.order(created_at: :desc).page(params[:page]).per(PAGE_NUMBER)
    @foods = nil if params[:q].nil? || params[:q][:name_cont] == ''
  end

  def update
    @food.update(food_params)
  end

  def destroy
    @food.destroy!
  end

  private

  def find_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :amount_of_sugar, :category_id)
  end
end
