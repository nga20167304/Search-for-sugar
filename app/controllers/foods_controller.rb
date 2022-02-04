class FoodsController < ApplicationController
  def index
    @q = Food.ransack(params[:q])
    @foods = @q.result.order(created_at: :desc)
  end
end
