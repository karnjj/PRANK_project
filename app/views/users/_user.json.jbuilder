json.extract! user, :id, :email, :name, :user_type, :password_digest, :created_at, :updated_at
json.url user_url(user, format: :json)
