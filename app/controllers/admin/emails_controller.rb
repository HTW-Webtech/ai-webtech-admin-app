module Admin
  class EmailsController < BaseController
    def new
    end

    def create
      scheduler = Email::Scheduler.new(
        group: group_or_review_group!,
        subject: email_params[:subject],
        body: email_params[:body]
      )
      if scheduler.run
        redirect_to new_admin_email_path, notice: "#{scheduler.mails.count} Mail(s) have been sent."
      else
        render :new, alert: 'Mails have not been fully sent'
      end
    end

    private

    def group_or_review_group!
      group_or_review_group or raise(ArgumentError, "You have to select either a group or review group")
    end

    def group_or_review_group
      group || review_group
    end

    def review_group
      ReviewGroup.where(id: email_params[:review_group_id]).first
    end

    def group
      Group.where(id: email_params[:group_id]).first
    end

    def email_params
      params.require(:email).permit(:group_id, :review_group_id, :subject, :body)
    end
  end
end
