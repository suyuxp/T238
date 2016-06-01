class AuthEntity < Grape::Entity
  expose :token, proc: ->(_, options) {AuthDomain.gen_token(options[:uid])}
end

class InvalidEntity < Grape::Entity
  expose :reason, if: :reason, proc: ->(_, options) { options[:reason] }
end
