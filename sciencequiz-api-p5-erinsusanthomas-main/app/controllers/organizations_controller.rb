class OrganizationsController < ApplicationController
    #Swagger documentation
    swagger_controller :organizations, "Organizations Management"

    swagger_api :index do
        summary "Fetches all Organizations"
        notes "This lists all the organizations"
    end

    swagger_api :show do
        summary "Shows one Organization"
        param :path, :id, :integer, :required, "Organization ID"
        notes "This lists details of one organization"
        response :not_found
    end

    swagger_api :create do
        summary "Creates a new Organization"
        param :form, :name, :string, :required, "Name"
        param :form, :street_1, :string, :required, "Street 1"
        param :form, :street_2, :string, :optional, "Street 2"
        param :form, :city, :string, :optional, "City"
        param :form, :state, :string, :optional, "State"
        param :form, :zip, :string, :required, "Zip"
        param :form, :short_name, :string, :required, "Short name"
        param :form, :active, :boolean, :optional, "Active"
        response :not_acceptable
    end
 
    swagger_api :update do
        summary "Updates an existing Organization"
        param :path, :id, :integer, :required, "Organization Id"
        param :form, :name, :string, :optional, "Name"
        param :form, :street_1, :string, :optional, "Street 1"
        param :form, :street_2, :string, :optional, "Street 2"
        param :form, :city, :string, :optional, "City"
        param :form, :state, :string, :optional, "State"
        param :form, :zip, :string, :optional, "Zip"
        param :form, :short_name, :string, :optional, "Short name"
        param :form, :active, :boolean, :optional, "Active"
        response :not_found
        response :not_acceptable
    end

    swagger_api :destroy do
        summary "Deletes an existing Organization"
        param :path, :id, :integer, :required, "Organization Id"
        response :not_found
    end


    # Controller Actions
    before_action :set_organization, only: [:show, :update, :destroy]
  
    # GET /organizations
    def index
      @organizations = Organization.active.alphabetical.all
      render json: OrganizationSerializer.new(@organizations)
    end
  
    # GET /organizations/1
    def show
      render json: OrganizationSerializer.new(@organization)
    end
  
    # POST /organizations
    def create
      @organization = Organization.new(organization_params)
  
      if @organization.save
        render json: @organization, status: :created, location: @organization
      else
        render json: @organization.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /organizations/1
    def update
      if @organization.update(organization_params)
        render json: @organization
      else
        render json: @organization.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /organizations/1
    def destroy
      @organization.destroy
      if !@organization.destroyed?
        render json: @organization.errors, status: :unprocessable_entity
      end
    end
  
    private
    def set_organization
        @organization = Organization.find(params[:id])
    end

    def organization_params
        params.permit(:name, :street_1, :street_2, :city, :state, :zip, :short_name, :active)
    end
end