require "grape"
require "grape-entity"

# ----------------------------------------------------
# 数据库连接，初始化全局变量
# ----------------------------------------------------
require_relative "config/env"

# ----------------------------------------------------
# DDD + MVC
# ----------------------------------------------------
module CLOAP
  class API < Grape::API
    format :json

    rescue_from :all, backtrace: true do |e|
      error!({ reason: e.to_s }, 500, { 'Content-Type' => 'text/error'})
    end

    desc "获取文件列表"
    get "/documentation" do
      UPLOAD_FILES
    end

    desc "下载文件"
    params do
      requires :id, type: Integer
    end
    get "/documentation/:id/download" do
      row = UPLOAD_FILES[params[:id]]
      content_type "application/octet-stream"
      header['Content-Disposition'] = "attachment; filename=#{row[:path]}"
      env['api.format'] = :binary
      File.open("#{FILE_PATH}/#{row[:path]}").read
      # File.binread("#{FILE_PATH}/#{row[:path]}")
    end
  end
end
