require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:attachment) { create(:attachment, attachable: question) }

  describe 'DELETE #destroy' do

    it 'deletes his file' do
      sign_in(question.user)
      expect { delete :destroy, params: { id: attachment, format: :js } }.to change(question.attachments, :count).by(-1)
    end

    it 'delete others file' do
      expect { delete :destroy, params: { id: attachment } }.not_to change(Attachment, :count)
    end
  end
end