class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[ show edit update destroy ]

  def index
    @q = Supplier.ransack(params[:q])
    @suppliers = @q.result
  end

  def show
  end

  def new
    @supplier = Supplier.new
  end

  def edit
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      redirect_to suppliers_url, notice: "「#{@supplier.name}」のレコードを登録しました。"
    else
      render :new
    end
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      redirect_to supplier_url(@supplier), notice: "「#{@supplier.name}」のレコードを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    supplier = Supplier.find(params[:id])
    supplier.destroy
    redirect_to suppliers_url, notice: "「#{@supplier.name}」のレコードを削除しました。"
  end

  #def destroy
    #@supplier.destroy

    #respond_to do |format|
      #format.html { redirect_to suppliers_url, notice: "「#{@supplier.name}」のレコードを削除しました。" }
      #format.json { head :no_content }
    #end
  #end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(
      %i[
        name
        address
        phone_number
      ]
    )
    end
end
