class DashboardsController < ApplicationController
  def index
    @suppliers = Supplier.all
  end
end
