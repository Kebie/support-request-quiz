class RequestsController < ApplicationController
  
  before_action :find_request,
                only: [:show, :edit, :destroy, :update]

  def index
    @requests = Request.all
  end

  def create
    @request = Request.new(request_attributes)
    if @request.save
      redirect_to requests_path, notice: "Your request was submmited"
    else
      render :new #wasn't created there was validatione errors
    end
  end

  def show
    
  end

  def edit
  end

  def update
    if @request.update_attributes(request_attributes)
      redirect_to requests_path, notice: "Your request was updated!"
    else
      render :edit
    end
  end

  def new
    @request = Request.new    
  end


  def destroy
    if @request.destroy
      redirect_to requests_path, notice: "Request deleted"
    else
      redirect_to request_path, error: "We had a problem deleting your request"
    end
  end

  private

  def request_attributes
    params.require(:request).permit([:name, :email, :department, :message, :done])
  end

  def find_request
    @request = Request.find(params[:id])
  end

end
