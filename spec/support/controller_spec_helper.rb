module ControllerSpecHelper
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  def valid_headers(version = nil)
    if version
      {
        'Authorization' => token_generator(user.id),
        'Content-Type' => 'application/json',
        'Accept' => "application/vnd.todos.#{version}+json"
      }
    else
      {
        'Authorization' => token_generator(user.id),
        'Content-Type' => 'application/json'
      }
    end
  end

  def invalid_headers(version = nil)
    if version
      {
        'Authorization' => token_generator(user.id),
        'Content-Type' => 'application/json',
        'Accept' => "application/vnd.todos.#{version}+json"
      }
    else
      {
        'Authorization' => nil,
        'Content-Type' => 'application/json'
      }
    end
  end
end
