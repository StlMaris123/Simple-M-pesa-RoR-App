# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@test.com'
  layout 'mailer'
end
