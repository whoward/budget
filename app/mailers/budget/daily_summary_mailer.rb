# frozen_string_literal: true

module Budget
  class DailySummaryMailer < ActionMailer::Base
    layout 'budget/mailer'

    helper 'budget/application'
    helper 'budget/html_email'

    default from: Budget.mail_recipient,
            to: Budget.mail_recipient

    def build(date: Time.zone.today)
      view_context
      @page = DailySummaryDecorator.decorate(DailySummary.new(date: date))
      mail(subject: "#{page.date} Budget: #{page.summary}")
    end

    private

    attr_reader :page
    helper_method :page
  end
end
