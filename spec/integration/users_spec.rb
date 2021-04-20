require 'swagger_helper'

describe 'users API' do

  path '/api/v1/users' do

    post 'Creates a user' do
      tags 'users'
      consumes 'application/json', 'application/xml'
      parameter firstname: :user, in: :body, schema: {
        type: :object,
        properties: {
          firstname: { type: :string },
          lastname: { type: :string },
          salary: { type: :integer }
        },
        required: [ 'firstname', 'lastname', 'salary' ]
      }

      response '201', 'user created' do
        let(:user) { { firstname: 'Dodo', lastname: 'Didi', salary: 4000 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { firstname: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do

    get 'Retrieves a user' do
      tags 'users'
      produces 'application/json', 'application/xml'
      parameter firstname: :id, :in => :path, :type => :string

      response '200', 'firstname found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            firstname: { type: :string },
            lastname: { type: :string },
            salary: { type: :integer }
          },
          required: [ 'id', 'firstname', 'lastname', 'salary' ]

        let(:id) { user.create(firstname: 'foo', lastname: 'Didi', salary: 7000).id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
