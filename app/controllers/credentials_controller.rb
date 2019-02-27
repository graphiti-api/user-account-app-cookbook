class CredentialsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    credential = CredentialResource.build(params)

    if credential.save
      render jsonapi: credential, status: 201
    else
      render jsonapi_errors: credential
    end
  end
end
