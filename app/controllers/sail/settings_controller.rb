# frozen_string_literal: true

module Sail
  class SettingsController < ApplicationController
    def index
      @settings = Setting.paginated(index_params[:page])
      fresh_when(@settings)
    end

    def update
      respond_to do |format|
        @setting = Setting.set(params[:name], params[:value])
        format.js {}
      end
    end

    private

    def index_params
      params.permit(:page)
    end
  end
end
