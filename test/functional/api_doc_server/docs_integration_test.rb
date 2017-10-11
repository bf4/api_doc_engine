require 'test_helper'

module ApiDocServer
  class DocsIntegrationTest < ActionDispatch::IntegrationTest

    setup do
      @routes = Engine.routes
    end

    test 'index action should redirect when single doc version' do
      get '/swagger'
      assert_response :redirect
    end

    test 'index action should not display back link when single doc version' do
      get '/swagger'
      refute_match('Back to API versions', @response.body)
    end

    test 'default config options should work successfully' do
      get '/swagger/v1'
      assert_response :success
      assert_match("url='api_docs/v1/swagger.yaml'", @response.body)
    end
  end
end
