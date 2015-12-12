class InvitationsController < ApplicationController
  def create
    @event = Event.find(params[:invitation][:event_id])
    invitation = current_user.invitations.build(event_id: @event.id)
    if invitation.save
      flash[:success] = 'You are attending this event!'
      redirect_to :back
    else
      flash[:danger] = 'There is a temporary problem in our servers.'
      redirect_to :back
    end
  end
end
