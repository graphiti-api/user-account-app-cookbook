class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  if Rails.env.development?
    after_action :log_message
  end

  private

  def log_message
    if email_was_sent?
      Rails.logger.info <<~EMAIL
        Sent Email
        Mailer: #{self.class.name}
        Action: #{action_name}
        To: #{Array(headers.to).join(", ")}
        Subject: #{headers.subject}
        Body:
        #{message.body.raw_source}
      EMAIL
    end
  end

  def email_was_sent?
    Array(headers.to).present?
  end
end
