class ArtifactsController < ApplicationController
  before_action :find_artifact, only: [:show, :edit, :update, :destroy]

  def index
    @artifacts = Artifact.all
  end

  def show
  end

  def new
    @artifact = Artifact.new
    @artifact.project_id = params[:project_id]
  end

  def edit
  end

  def create
    @artifact = Artifact.new(artifact_params)

    respond_to do |format|
      if @artifact.save
        format.html { redirect_to tenant_project_url(tenant_id: Tenant.current_tenant_id, id: @artifact.project_id), notice: 'Artifact was successfully created.' }
        format.json { render :show, status: :created, location: @artifact }
      else
        format.html { render :new }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @artifact.update(artifact_params)
        format.html { redirect_to @artifact, notice: 'Artifact was successfully updated.' }
        format.json { render :show, status: :ok, location: @artifact }
      else
        format.html { render :edit }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @artifact.destroy
    respond_to do |format|
      format.html { redirect_to tenant_project_url(tenant_id: Tenant.current_tenant_id, id: @artifact.project_id), notice: 'Artifact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def find_artifact
    @artifact = Artifact.find(params[:id])
  end

  def artifact_params
    params.require(:artifact).permit(:name, :project_id, :upload)
  end
end
