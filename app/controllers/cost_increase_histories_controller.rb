class CostIncreaseHistoriesController < ApplicationController
  class CostIncreaseHistoriesController < ApplicationController
    before_action :set_product_supplier
  
    def new
      @cost_increase_history = @product_supplier.cost_increase_histories.new
    end
  
    def create
      @cost_increase_history = @product_supplier.cost_increase_histories.new(cost_increase_history_params)
  
      if @cost_increase_history.save
        redirect_to product_supplier_path(@product_supplier), notice: 'Cost increase history was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @cost_increase_history = @product_supplier.cost_increase_histories.find(params[:id])
    end
  
    def update
      @cost_increase_history = @product_supplier.cost_increase_histories.find(params[:id])
      
      if @cost_increase_history.update(cost_increase_history_params)
        redirect_to product_supplier_path(@product_supplier), notice: 'Cost increase history was successfully updated.'
      else
        render :edit
      end
    end
  
    private
  
    def set_product_supplier
      @product_supplier = ProductSupplier.find(params[:product_supplier_id])
    end
  
    def cost_increase_history_params
      params.require(:cost_increase_history).permit(:current_cost, :cost_revision_date)
    end
  end
  
end
