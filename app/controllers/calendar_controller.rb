class CalendarController < ApplicationController
  protect_from_forgery 
  before_action :set_calendar, only: [:delete]

  def index
    @calendar = Calendar.all
    render json: @calendar
  end
  
  def new
    @calendar = Calendar.new
  end
  
  def create
    @calendar = Calendar.create(calendar_params)
    
    if @calendar.save
      render json: @calendar
      # render :show, status: :created
    else
      # render 'new'
      render json: @calendar.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @calendar.destroy
    redirect_to calendar_path
  end

  private

  def calendar_params
    params.require(:calendar).permit(:name, :start, :end)
  end

  def set_calendar
    @calendar = Calendar.find(params[:id])
  end

end
