class RequestsController < ApplicationController
  
  before_action :find_request,
                only: [:show, :edit, :destroy, :update, :done]

  before_action :list_of_requests, only: [:index]

  def index
    
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

  def search
    @requests = Request.search(params[:search_term]).paginate(:page => params[:page], :per_page => 3).order('done ASC')
    render :index
  end


  #marks the project as done, and then sends them back to the main page.
  def done
    @request.done ^= true #XOR switches TRUE and FALSE so if DONE -> not done and visa versa
    @request.save
    redirect_to requests_path, notice: "Request status updated"
  end

  private

  def request_attributes
    params.require(:request).permit([:name, :email, :department, :message, :done])
  end

  def find_request
    @request = Request.find(params[:id])
  end

  def list_of_requests
      @requests = Request.paginate(:page => params[:page], :per_page => 3).order('done ASC')
      #@requests = Request.all.order("done ASC")
  end

end
