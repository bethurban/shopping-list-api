class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_item, only: [:show, :update, :delete]

  def index
    @items = Item.all
    json_response(@items)
  end

  def create
    @item = Item.create!(item_params)
    json_response(@item,:created)
  end

  def show
    json_response(@item)
  end

  def update
    @item.update(item_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :amount, :section)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
