class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def show
    @department = Department.find(params[:id])
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    @department.save!
    redirect_to departments_url, notice: "「#{@department.name}」のレコードを新規登録しました。"
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    @department.update!(department_params)
    redirect_to departments_url, notice: "「#{@department.name}」のレコードを更新しました。"
  end

  def destroy
    department = Department.find(params[:id])
    department.destroy
    redirect_to departments_url, notice: "「#{department.name}」のレコードを削除しました。"
  end

  private

  def department_params
    params.require(:department).permit(:name)
  end
end
