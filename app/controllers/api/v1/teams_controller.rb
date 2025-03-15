module Api
  module V1
    class TeamsController < Api::ApplicationController
      include SetTeam

      def index
        render json: Team.all.as_json(except: [ :owner_id, :creator_id ],
                                      include: {
                                        owner: { only: [ :id, :first_name, :last_name, :email ] },
                                        creator: { only: [ :id, :first_name, :last_name, :email ] }
                                      })
      end

      def view
        set_team
        render json: @team.as_json(except: [ :owner_id, :creator_id ],
                                  include: {
                                    owner: { only: [ :id, :first_name, :last_name, :email ] },
                                    creator: { only: [ :id, :first_name, :last_name, :email ] }
                                  })
      end

      def tickets
        set_team
        render json: @team&.tickets&.map { |ticket|
          ticket.as_json(except: [ :creator_id, :assignee_id, :team_id, :priority, :status ],
                         include: {
                           creator: { only: [ :id, :first_name, :last_name, :email ] },
                           assignee: { only: [ :id, :first_name, :last_name, :email ] },
                           team: { only: [ :id, :name, :description ] }
                         })
                .merge(status: ticket.human_readable_status, priority: ticket.human_readable_priority)
        }
      end
    end
  end
end
