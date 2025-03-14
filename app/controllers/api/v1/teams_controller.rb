module Api
  module V1
    class TeamsController < Api::ApplicationController
      def index
        render json: Team.all
      end

      def find
        render json: Team.find(params[:id])
      end

      def tickets
        render json: Team.find(params[:team_id]).tickets
      end
    end
  end
end
