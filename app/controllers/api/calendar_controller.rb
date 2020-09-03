class Api::CalendarController < ApiController
  before_action :set_calendar, only: [:show]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    calendars = Calendar.all
    render json: calendars
  end

  def show
    render json: @calendar
  end

  def create
    calendar = Calendar.new(calendar_params)
    if calendar.save
      render json: calendar, status: :created
    else
      render json: { errors: calendar.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    def calendar_params
      params.fetch(:calendar,{}).permit(:name, :start, :end)
    end
end
