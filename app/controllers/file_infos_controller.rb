class FileInfosController < ApplicationController

  before_filter :authenticate_user!, except: [:index]
  before_filter :set_user, only: [:index]

  # GET /file_infos
  # GET /file_infos.json
  def index
    @file_info = FileInfo.new
    #@file_infos = FileInfo.all
    @file_infos = current_user.file_info.reverse unless current_user.nil?


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @file_infos }
      format.json { render xml: @file_infos }
    end
  end

  # GET /file_infos/1
  # GET /file_infos/1.json
  def show
    @file_info = FileInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @file_info }
    end
  end

  # POST /file_infos
  # POST /file_infos.json
  def create
    @file_info = FileInfo.new(params[:file_info])
    @file_info.user = current_user
    respond_to do |format|
      if @file_info.save
        @files = current_user.file_info
        format.js{}
        format.html { redirect_to @file_info, notice: 'File info was successfully created.' }
        format.json { render json: @file_info, status: :created, location: @file_info }
      else
        format.html { render action: "new" }
        format.json { render json: @file_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_infos/1
  # DELETE /file_infos/1.json
  def destroy
    @file_info = FileInfo.find(params[:id])
    @file_info.destroy

    respond_to do |format|
      format.html { redirect_to file_infos_url }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    if current_user.nil?
      @user ||= User.new
    else
      @user = current_user
    end
  end

  # def file_infos_params
  #   params.require(:id).permit(:file_info)
  # end

end
