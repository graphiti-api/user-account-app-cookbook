class CredentialsController < ApplicationController
  def create
    credential = CredentialResource.build(params)

    if credential.save
      render jsonapi: credential, status: 201
    else
      render jsonapi_errors: credential
    end
  end
end
