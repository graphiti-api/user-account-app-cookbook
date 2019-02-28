class AccountActivationsController < ActionController::Base
  def show
    activation = Authentication::EmailActivation.load(params[:id])

    if activation
      unless activation.user.email_verified_at
        activation.user.update_attributes(email_verified_at: Time.now)
      end

      redirect_to success_account_activations_path
    else
      redirect_to error_account_activations_path
    end
  end
end