class UserMailer < ApplicationMailer
  def account_activation(user)
    activation = Authentication::EmailActivation.new(user)

    @activation_token = activation.mint_token
    @activation_link = account_activation_url(@activation_token)

    mail(to: user.email, subject: 'Welcome to the site!')
  end
end