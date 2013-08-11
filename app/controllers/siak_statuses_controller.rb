class SiakStatusesController < ApplicationController
  # GET /stasiuns
  # GET /stasiuns.json
  def index
    @statuses = SiakStatus.order("created_at DESC").page(params[:page]).per(50)
    @data_json = SiakStatus.limit(50).map { |x| [(x.id % 5 == 0) || true ? x.created_at.strftime("%H:%M:%S") : "" , x.ping_ms] }
    @data_json.unshift(["x", "Ping (dalam ms)"])
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end
end