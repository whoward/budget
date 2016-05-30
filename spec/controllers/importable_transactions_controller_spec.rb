# frozen_string_literal: true

require 'rails_helper'

describe Budget::ImportableTransactionsController do
  let!(:txn) { create(:importable_transaction) }

  it "renders the 'new' page by default" do
    get :show, id: txn.id

    expect(response).to render_template 'importable_transactions/new'
  end
end
