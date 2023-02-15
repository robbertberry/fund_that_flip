class EncoderController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }, only: :encode

  def encode
    original_string = OriginalString.create!(value: params[:string])
    encoded_string = encode_rot13(params[:string])

    render json: { original_string: original_string.value, encoded_string: encoded_string }

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def encode_rot13(string)
    string.tr('A-Za-z', 'N-ZA-Mn-za-m')
  end
end
