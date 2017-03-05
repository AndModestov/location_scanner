require 'rails_helper'

RSpec.describe PointsController, type: :controller do

  describe 'GET #index' do
    let(:points){ create_list(:point, 2) }
    before { get :index }

    it 'assigns a @points list' do
      expect(assigns(:points)).to eq points
    end

    it 'assigns a new @point' do
      expect(assigns(:point)).to be_a_new(Point)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:point) { create(:point) }
    before { get :show, id: point }

    it 'assigns the requested question to @question' do
      expect(assigns(:point)).to eq point
    end

    it 'should render the show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    context 'with valid information' do
      it 'saves the point in database' do
        expect {
          post :create, point: attributes_for(:point), format: :js
        }.to change(Point, :count).by(1)
      end

      it 'publish point to /points' do
        expect(PrivatePub).to receive(:publish_to).with("/points", anything)
        post :create, point: attributes_for(:point), format: :js
      end
    end

    context 'with invalid information' do
      it 'does not save the point' do
        expect {
          post :create, point: attributes_for(:invalid_point), format: :js
        }.to_not change(Point, :count)
      end

      it 'does not publish point to /points' do
        expect(PrivatePub).to_not receive(:publish_to).with("/points", anything)
        post :create, point: attributes_for(:invalid_point), format: :js
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:point) { create(:point) }

    it 'deletes point' do
      expect{
        delete :destroy, id: point, format: :js
      }.to change(Point, :count).by(-1)
    end

    it 'renders point id' do
      delete :destroy, id: point, format: :js
      expect(response.body).to be_json_eql(point.id).at_path("point")
    end
  end
end
