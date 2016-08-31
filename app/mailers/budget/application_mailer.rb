# frozen_string_literal: true

module Budget
  class ApplicationMailer < ActionMailer::Base
    layout 'budget/mailer'

    helper 'budget/application'
    helper 'budget/html_email'

    default from: Budget.mail_recipient,
            to: Budget.mail_recipient

    def review_reminder
      @txn_count = ImportableTransaction.not_imported.count
      @acc_count = ImportableAccount.not_imported.count

      mail(subject: 'You have stuff to review!')
    end
  end
end
