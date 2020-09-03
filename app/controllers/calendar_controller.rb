class CalendarController < ApplicationController
  before_action :set_calendar, only: [:delete]

  def index
    @calendar = Calendar.all
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = Calendar.create(calendar_params)

    if @calendar.save
      redirect_to calendar_path
    else
      render 'new'
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
