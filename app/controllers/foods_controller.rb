class FoodsController < ApplicationController
  def index
    @foods = Food.all.order(created_at: :desc)
  end
end
