require 'swagger_helper'

describe 'Users API' do
  path '/users' do
    get 'Fetches all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'successful' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   bio: { type: :string },
                 }
               }

        run_test!
      end
    end
  end
end
