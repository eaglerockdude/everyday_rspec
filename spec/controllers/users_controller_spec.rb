require 'rails_helper'
describe UsersController do
  #INDEX action - TBD

  # NEW action
  describe 'GET #new' do
    it 'assigns a new user instance to @user variable' do
      get :new
      expect(assigns(:user)).to be_an_instance_of(User)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
      expect(response)
    end

  end

 #EDIT action - TBD

  #CREATE action
  describe 'POST #Create' do
    context 'with valid attributes'do
      it 'saves the new user to the database'
      it 'redirects somewhere'
    end
    context 'with invalid attributes'
      it 'does not save the contact'
      it 're-renders the :new template'
  end

end