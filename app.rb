require "grape"
require "grape-entity"

# ----------------------------------------------------
# 数据库连接，初始化全局变量
# ----------------------------------------------------
require_relative "config/env"

# ----------------------------------------------------
# DDD + MVC
# ----------------------------------------------------
require_relative "lib/auth_domain"
require_relative "lib/auth_entity"

module CLOAP
  class API < Grape::API
    version "v1", using: :path, vendor: "intermaker.cn"
    format :json
    prefix :api

    rescue_from :all, backtrace: true do |e|
      error!({ reason: e.to_s }, 500, { 'Content-Type' => 'text/error'})
    end

    desc "Authenticate"
    params do
      requires :uid,    type: String, desc: "user id in AD"
      requires :passwd, type: String, desc: "userPassword in AD"
    end
    post "/auth" do
      unless AuthDomain.auth(params[:uid], params[:passwd])
        status 401
        return present params, with: InvalidEntity, reason: "invalid"
      end

      status 200
      present params, with: AuthEntity, uid: params[:uid]
    end
  end
end
