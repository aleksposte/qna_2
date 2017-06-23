require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:answer) { create(:answer, user: user) }
  let(:other_answer) { create(:answer, user: other_user) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves new answer to db' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(question.answers, :count).by(1)
      end

      it 'assigns the new answer to current user' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(@user.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save new anwser to db' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer), format: :js } }.not_to change(Answer, :count)
      end
      it 'render create template' do
        post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    before { answer }
    before { other_answer }

    context 'delete his answer' do
      it 'delete own answer' do
        sign_in(user)
        expect { delete :destroy, params: { question_id: answer.question_id, id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question view' do
        sign_in(user)
        delete :destroy, params: { question_id: answer.question_id, id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'delete others answers' do
      it 'doesnt delete others answer' do
        sign_in(user)
        expect { delete :destroy, params: { question_id: other_answer.question_id, id: other_answer } }.not_to change(Answer, :count)
      end

      it 'show delete error' do
        sign_in(user)
        delete :destroy, params: { question_id: other_answer.question_id, id: other_answer }
        expect(flash[:alert]).to eq 'Your can`t delete others answer'
        expect(response).to redirect_to question_path(other_answer.question)
      end
    end
  end
end

