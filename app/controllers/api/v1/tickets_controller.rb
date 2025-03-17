module Api
  module V1
    class TicketsController < Api::ApplicationController
      include SetTicket

      def view
        set_ticket
        render json: @ticket.as_json(except: [ :creator_id, :assignee_id, :status, :priority, :team_id ],
                                     include: {
                                       assignee: { only: [ :id, :first_name, :last_name, :email ] },
                                       creator: { only: [ :id, :first_name, :last_name, :email ] },
                                       team: { only: [ :id, :name, :description ] },
                                       comments: { only: [ :body, :created_at ] }
                                     })
                            .merge(status: @ticket.human_readable_status, priority: @ticket.human_readable_priority)
      end
    end
  end
end
