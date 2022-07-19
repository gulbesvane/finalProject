class CollabsController < ApplicationController
  before_action :set_collab, only: %i[ show edit update destroy ]
  before_action :require_login, except: [ :index, :show ]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /collabs or /collabs.json
  def index
    @collabs = Collab.order("created_at DESC").paginate(page: params[:page], per_page: 2)
  end

  # GET /collabs/1 or /collabs/1.json
  def show
  end

  # GET /collabs/new
  def new
    @collab = Collab.new
  end

  # GET /collabs/1/edit
  def edit
  end

  # POST /collabs or /collabs.json
  def create
    @collab = Collab.new(collab_params)

    respond_to do |format|
      if @collab.save
        format.html { redirect_to collab_url(@collab), notice: "Collab was successfully created." }
        format.json { render :show, status: :created, location: @collab }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collabs/1 or /collabs/1.json
  def update
    respond_to do |format|
      if @collab.update(collab_params)
        format.html { redirect_to collab_url(@collab), notice: "Collab was successfully updated." }
        format.json { render :show, status: :ok, location: @collab }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collabs/1 or /collabs/1.json
  def destroy
    @collab.destroy
    flash[:notice] = "Your collab has been deleted."
    redirect_to collabs_path, status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collab
      @collab = Collab.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collab_params
      params.require(:collab).permit(:title, :body, :participants, :integer, :image)
    end

    def require_same_user
      # if current user is not the author of the collab and is not admin, then redirect
      if current_user != @collab.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own collab projects."
        redirect_to @collab
      end
    end
end
