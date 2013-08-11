class SiakStatusesController < ApplicationController
  # GET /stasiuns
  # GET /stasiuns.json
  def index

    @statuses = SiakStatus.order("created_at DESC").page(params[:page]).per(50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end
end