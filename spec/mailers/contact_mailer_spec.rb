require 'spec_helper'

describe ContactMailer do
  describe '#deliver' do
    it 'sends email with name, email and message' do
      Lenstroy::App.deliver(:contact, :contact_email, 'Slava', 'le@mai.ru', 'Привет')
    end
  end
end
