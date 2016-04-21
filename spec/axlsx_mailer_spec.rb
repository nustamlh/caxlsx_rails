require 'spec_helper'

describe "Mailer", type: :request do
  before :each do
    @user = User.create name: 'Elmer', last_name: 'Fudd', address: '1234 Somewhere, Over NY 11111', email: 'elmer@fudd.com'
  end

  it "attaches an xlsx file" do
    visit "/users/#{@user.id}/send_instructions"
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email.to).to eq([@user.email])
    expect(last_email.attachments.first).to be
    if Rails.version.to_f >= 5
      expect(last_email.attachments.first.content_type).to eq(mime_type.to_s)
    else
      expect(last_email.attachments.first.content_type).to eq(mime_type.to_s + "; charset=UTF-8")
    end
  end
end
