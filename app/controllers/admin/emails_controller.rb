module Admin
  class EmailsController < BaseController
    def new
    end

    def create
      group = Group.where(name: email_params[:receiver_group]).first!
      scheduler = Email::Scheduler.new(
        group: group,
        subject: email_params[:subject],
        body: email_params[:body]
      )
      if scheduler.run
        redirect_to new_admin_email_path, notice: 'Mails have all been sent'
      else
        render :new, alert: 'Mails have not been fully sent'
      end
    end

    private

    def email_params
      params.require(:email).permit(:receiver_group, :subject, :body)
    end
  end
end
