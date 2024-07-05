class GptsController < ApplicationController
    def create
        gpt = Gpt.new(gpt_params)
        gpt.response = gpt.get_response(gpt.system, gpt.prompt)
        gpt.user_id = current_user.id
        if gpt.save
            redirect_to gpts_path
        end
    end

    def index
        @gpts = Gpt.where(user_id: current_user.id)
        @gpt = Gpt.new
        @pre_system = Gpt.where(user_id: current_user.id).last.system if Gpt.where(user_id: current_user.id).last.present?

    end

    def destroy_all
        Gpt.where(user_id: current_user.id).destroy_all
        redirect_to gpts_path
    end
    


    private

    def gpt_params
        params.require(:gpt).permit(:prompt, :system)
    end
end
