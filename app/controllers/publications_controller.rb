class PublicationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]
  before_action :set_all, only: [:index, :show, :new, :edit, :create]
  before_action :access_user, only: [:edit, :update, :destroy]

  # GET /publications
  # GET /publications.json
  def index

    @publications = Publication.all.includes(:region, :commune, :publication_attachments) #Bulllet
    @publications = @publications.by_title(params[:search_title]) if params[:search_title].present?
    @publications = @publications.by_type(params[:search_type]) if params[:search_type].present?
    @publications = @publications.by_address(params[:search_address]) if params[:search_address].present?
    @publications = @publications.by_region(params[:search_region]) if params[:search_region].present?
    @publications = @publications.by_commune(params[:search_commune]) if params[:search_commune].present?
    @publications = @publications.by_address2(params[:search_address2]) if params[:search_address2].present?
    @publications = @publications.by_region2(params[:search_region2]) if params[:search_region2].present?
    @publications = @publications.by_commune2(params[:search_commune2]) if params[:search_commune2].present?
    @publications = @publications.by_width_min(params[:width_min]) if params[:width_min].present?
    @publications = @publications.by_width_max(params[:width_max]) if params[:width_max].present?
    @publications = @publications.by_length_min(params[:length_min]) if params[:length_min].present?
    @publications = @publications.by_length_max(params[:length_max]) if params[:length_max].present?
    @publications = @publications.by_height_min(params[:height_min]) if params[:height_min].present?
    @publications = @publications.by_height_max(params[:height_max]) if params[:height_max].present?
    @publications = @publications.by_latitude_min(params[:latitude_min]) if params[:latitude_min].present?
    @publications = @publications.by_latitude_max(params[:latitude_max]) if params[:latitude_max].present?
    @publications = @publications.by_longitude_min(params[:longitude_min]) if params[:longitude_min].present?
    @publications = @publications.by_longitude_max(params[:longitude_max]) if params[:longitude_max].present?
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    @publication.page_views += 1
    @publication.save
    @publication_attachments = @publication.publication_attachments.all

    @publications = Publication.all
  end

  def contact_email
    @publication = Publication.find(params[:id])
    UserMailer.contact_send(current_user, @publication, params[:name_sent], params[:phone_sent], params[:email_sent], params[:message_sent]).deliver_now()
  end

  # GET /publications/new
  def new
    @publication = Publication.new
    @publication_attachment = @publication.publication_attachments.build
    @categories = Category.all
    @regions = Region.all.includes(:communes)
  end

  # GET /publications/1/edit
  def edit
  end

  def access_user
    unless @publication.user == current_user
      flash[:alert] = 'Access denied'
      redirect_to pages_path
    end
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = current_user.publications.new(publication_params)

    respond_to do |format|
      if @publication.save
        unless params[:publication_attachments].nil?
          params[:publication_attachments]['photo'].each do |a|
             @publication_attachment = @publication.publication_attachments.create!(:photo => a)
          end
        end
        format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: 'Publication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

     def set_all
      @categories = Category.all
      @types = Type.all
      @regions = Region.all
      @communes = Commune.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:user_id, :title, :width, :length, :height, :description, :address, :address2, :price, :category_id, :type_id, :region_id, :commune_id, :region2_id, :commune2_id, equipments_ids: [], publication_attachments_attributes: [:id, :publication_id, :photo, :photo_cache])
    end
end
