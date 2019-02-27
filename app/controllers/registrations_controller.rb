class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    registration = RegistrationResource.build(params)

    if registration.save
      render jsonapi: registration, status: 201
    else
      render jsonapi_errors: registration
    end
  end
end