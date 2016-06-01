require 'adauth'
require 'jwt'

class AuthDomain
  def self.auth uid, passwd
    authDefault   = (ENV["AUTH_DEFAULT"] || "AD").upcase
    authFallback  = ENV["AUTH_FALLBACK"]

    authPass = auth_with_method(uid, passwd, authDefault)
    unless authPass
      if authFallback
        authPass = auth_with_method(uid, passwd, authFallback)
      end
    end

    authPass
  end

  def self.auth_with_method(uid, passwd, method)
    if method == "AD"
      AuthAD.auth(uid, passwd)
    else
      AuthMail.auth(uid, passwd)
    end
  end

  def self.gen_token uid
    exp = Time.now.to_i + ExpireSeconds
    JWT.encode({uid: uid, exp: exp}, SecretHex, "HS256")
  end
end


# -----------------------------------------------------------------------------
# AD Domain Auth
# -----------------------------------------------------------------------------
class AuthAD
  def self.auth uid, passwd
    Adauth.configure do |c|
      c.domain  = ENV["AD_DOMAIN"] || 'example.com'
      c.server  = ENV["AD_SERVER"] || '127.0.0.1'
      c.port    = ENV["AD_PORT"] || 389
      c.base    = ENV["AD_BASE"] || 'dc=example,dc=com'
      c.query_user      = ENV["AD_USER"] || 'docker'
      c.query_password  = ENV["AD_PASSWD"] || 'secret'
    end

    Adauth.authenticate(uid, passwd)  # [true | false]
  end
end


# -----------------------------------------------------------------------------
# MAIL Auth
# -----------------------------------------------------------------------------
class AuthMail
  def self.auth uid, passwd
    require 'net/smtp'
    begin
      Net::SMTP.start(
        ENV["MAIL_HOST"] || '127.0.0.1',
        ENV["MAIL_PORT"] || 25,
        ENV["MAIL_DOMAIN"]  || 'example.com',
        uid,
        passwd,
        (ENV["MAIL_AUTHTYPE"] && ENV["MAIL_AUTHTYPE"].to_sym) || :plain
      )
      return true
    rescue Net::SMTPAuthenticationError
      return false
    end
  end
end
