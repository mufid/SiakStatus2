class SiakStatusesController < ApplicationController
  # GET /stasiuns
  # GET /stasiuns.json
  def index
    @statuses = SiakStatus.order("created_at DESC").page(params[:page]).per(50)
    @data_json = SiakStatus.limit(50).map { |x| [x.created_at.strftime("%H:%M:%S"), x.ping_ms] }
    @data_json.unshift(["x", "Ping (dalam ms)"])
    
    ping_ms = SiakStatus.order("created_at DESC").first.ping_ms

    @status_string =
      if ping_ms < 5000
        "Yeee.. SIAK baik-baik saja!"
      elsif ping_ms < 15000
        "Sepertinya SIAK mengalami masalah.."
      else
        "Auch.. SIAK tidak bisa diakses!"
      end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end
end