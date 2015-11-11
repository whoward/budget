require 'rails_helper'

describe Budget::ImportableTransactionsController do
  routes { Budget::Engine.routes }

  let!(:txn) { create(:importable_transaction) }

  it "renders the 'new' page by default" do
    get :show, id: txn.id

    expect(response).to render_template 'importable_transactions/new'
  end
end
