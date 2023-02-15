require_relative '../test_helper'
require 'mocha/minitest'

class EncoderControllerTest < ActionController::TestCase
  def setup
    @controller = EncoderController.new
  end

  test 'creates an original string and encodes it using ROT13' do
    post :encode, params: { string: 'Hello, World!' }

    assert_response :ok

    response_body = JSON.parse(response.body)
    assert_includes response_body, 'original_string'
    assert_includes response_body, 'encoded_string'

    original_string = OriginalString.last
    assert_equal 'Hello, World!', original_string.value
    assert_equal 'Uryyb, Jbeyq!', response_body['encoded_string']
  end

  test 'skips authenticity token verification for JSON requests' do
    @controller.stubs(:verify_authenticity_token)

    post :encode, format: :json, params: { string: 'Hello, World!' }

    assert_response :ok
    assert_nothing_raised do
      @controller.send(:verify_authenticity_token)
    end
  end
end
